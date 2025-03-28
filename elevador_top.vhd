library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Elevador_Principal is
    port (
        clk, reset : in std_logic;
        boton_subir, boton_bajar : in std_logic_vector(4 downto 0);
        boton_abrir, boton_cerrar : in std_logic;
        boton_piso : in std_logic_vector(4 downto 0);
        sensor_personas : in std_logic;
        fallo_energia : in std_logic;
        cantidad_personas : out std_logic_vector(3 downto 0);
        piso_actual : out std_logic_vector(2 downto 0);
        puertas_abiertas : out std_logic;
        alarma_sonora, alarma_visual : out std_logic;
        luces_encendidas : out std_logic;
        display_piso : out std_logic_vector(2 downto 0)
    );
end Elevador_Principal;

architecture Behavioral of Elevador_Principal is

    -- Señales internas para interconectar módulos
    signal llegada_piso : std_logic;
    signal abrir_puertas, cerrar_puertas : std_logic;
    signal moviendo : std_logic;
    signal exceso_personas : std_logic;

    -- Componentes
    component Entrada_Usuario
        port (...);
    end component;
    
    component Control_Movimiento
        port (...);
    end component;
    
    component Control_Puertas
        port (...);
    end component;
    
    component Sensor_Personas
        port (...);
    end component;
    
    component Seguridad
        port (...);
    end component;
    
    component Iluminacion
        port (...);
    end component;
    
    component Botones_Internos
        port (...);
    end component;
    
    component DivisorF
        port (...);
    end component;

begin

    -- Instancias de cada módulo y conexiones
    U1: Entrada_Usuario
        port map (...);
    
    U2: Control_Movimiento
        port map (...);
    
    U3: Control_Puertas
        port map (...);
    
    U4: Sensor_Personas
        port map (...);
    
    U5: Seguridad
        port map (...);
    
    U6: Iluminacion
        port map (...);
    
    U7: Botones_Internos
        port map (...);
    
    U8: DivisorF
        port map (...);
    
end Behavioral;

