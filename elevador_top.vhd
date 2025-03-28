library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ascensor is
    Port (
        clk              : in  STD_LOGIC;
        reset            : in  STD_LOGIC;
        boton_subir      : in  STD_LOGIC_VECTOR(4 downto 0);
        boton_bajar      : in  STD_LOGIC_VECTOR(4 downto 0);
        boton_abrir      : in  STD_LOGIC;
        boton_cerrar     : in  STD_LOGIC;
        solicitudes      : in  STD_LOGIC_VECTOR(4 downto 0);
        piso_actual_disp : out STD_LOGIC_VECTOR(6 downto 0);
        puerta_abierta   : out STD_LOGIC;
        puerta_cerrada   : out STD_LOGIC;
        alarma_general   : out STD_LOGIC
    );
end ascensor;

architecture arch_ascensor of ascensor is
    signal piso_actual     : STD_LOGIC_VECTOR(2 downto 0);
    signal piso_destino    : STD_LOGIC_VECTOR(2 downto 0);
    signal dir             : STD_LOGIC;
    signal request_valid   : STD_LOGIC;
    signal llegada_piso    : STD_LOGIC;
    signal habilitar_asc   : STD_LOGIC;
    signal cantidad_personas : INTEGER range 0 to 11;
    signal alarma_personas : STD_LOGIC;
    signal alarma_puerta   : STD_LOGIC;
    signal clk_div         : STD_LOGIC;
    
    -- Instancia del divisor de frecuencia
    component divisorF is
        Port (
            clk  : in  STD_LOGIC;
            out1 : buffer STD_LOGIC
        );
    end component;
    
    -- Instancia del controlador
    component controlador is
        Port (
            clk, reset, enable: in STD_LOGIC;
            solicitud_pisos   : in STD_LOGIC_VECTOR(4 downto 0);
            solicitud_abrir, solicitud_cerrar: in STD_LOGIC;
            solicitud_subir, solicitud_bajar : in STD_LOGIC_VECTOR(4 downto 0);
            piso_actual       : in STD_LOGIC_VECTOR(2 downto 0);
            puerta_abierta, puerta_cerrada : in STD_LOGIC;
            piso_destino      : out STD_LOGIC_VECTOR(2 downto 0);
            dir              : out STD_LOGIC;
            request_valid, llegada_piso, habilitar_ascensor : out STD_LOGIC
        );
    end component;
    
    -- Instancia del controlador vertical
    component controlador_vertical is
        Port (
            clk, reset : in STD_LOGIC;
            piso_destino : in STD_LOGIC_VECTOR(2 downto 0);
            dir : in STD_LOGIC;
            habilitar_ascensor : in STD_LOGIC;
            piso_actual : out STD_LOGIC_VECTOR(2 downto 0);
            piso_7seg : out STD_LOGIC_VECTOR(6 downto 0);
            llegada : out STD_LOGIC
        );
    end component;
    
    -- Instancia del módulo sensor de personas
    component sensor_personas is
        Port (
            clk, reset : in STD_LOGIC;
            boton_subir, boton_bajar : in STD_LOGIC;
            cantidad_personas : out INTEGER range 0 to 11;
            alarma_personas : out STD_LOGIC
        );
    end component;
    
    -- Instancia del módulo de control de puertas
    component control_puertas is
        Port (
            clk, reset : in STD_LOGIC;
            habilitar_ascensor, llegada_piso, boton_abrir, boton_cerrar : in STD_LOGIC;
            puerta_abierta, puerta_cerrada : out STD_LOGIC;
            alarma_puerta : out STD_LOGIC
        );
    end component;
    
    -- Instancia del display de 7 segmentos
    component display_7seg is
        Port (
            piso_bin : in STD_LOGIC_VECTOR(2 downto 0);
            piso_7seg : out STD_LOGIC_VECTOR(6 downto 0)
        );
    end component;
    
    -- Instancia del módulo de alarmas
    component alarmas is
        Port (
            alarma_personas, alarma_puerta : in STD_LOGIC;
            alarma_general : out STD_LOGIC
        );
    end component;
    
begin
    -- Conectar divisor de frecuencia
    clk_divisor: divisorF port map(clk => clk, out1 => clk_div);
    
    -- Conectar controlador principal
    controlador_inst: controlador port map(
        clk => clk_div, reset => reset, enable => '1',
        solicitud_pisos => solicitudes,
        solicitud_abrir => boton_abrir,
        solicitud_cerrar => boton_cerrar,
        solicitud_subir => boton_subir,
        solicitud_bajar => boton_bajar,
        piso_actual => piso_actual,
        puerta_abierta => puerta_abierta,
        puerta_cerrada => puerta_cerrada,
        piso_destino => piso_destino,
        dir => dir,
        request_valid => request_valid,
        llegada_piso => llegada_piso,
        habilitar_ascensor => habilitar_asc
    );
    
    -- Conectar controlador vertical
    controlador_vertical_inst: controlador_vertical port map(
        clk => clk_div, reset => reset,
        piso_destino => piso_destino,
        dir => dir,
        habilitar_ascensor => habilitar_asc,
        piso_actual => piso_actual,
        piso_7seg => piso_actual_disp,
        llegada => llegada_piso
    );
    
    -- Conectar sensor de personas
    sensor_personas_inst: sensor_personas port map(
        clk => clk_div, reset => reset,
        boton_subir => boton_subir(0),
        boton_bajar => boton_bajar(0),
        cantidad_personas => cantidad_personas,
        alarma_personas => alarma_personas
    );
    
    -- Conectar control de puertas
    control_puertas_inst: control_puertas port map(
        clk => clk_div, reset => reset,
        habilitar_ascensor => habilitar_asc,
        llegada_piso => llegada_piso,
        boton_abrir => boton_abrir,
        boton_cerrar => boton_cerrar,
        puerta_abierta => puerta_abierta,
        puerta_cerrada => puerta_cerrada,
        alarma_puerta => alarma_puerta
    );
    
    -- Conectar alarmas
    alarmas_inst: alarmas port map(
        alarma_personas => alarma_personas,
        alarma_puerta => alarma_puerta,
        alarma_general => alarma_general
    );
    
end arch_ascensor;
