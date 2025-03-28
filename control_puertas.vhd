library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity control_puertas is
    Port (
        clk               : in STD_LOGIC;
        reset             : in STD_LOGIC;
        habilitar_ascensor: in STD_LOGIC;
        llegada_piso      : in STD_LOGIC;
        boton_abrir       : in STD_LOGIC;
        boton_cerrar      : in STD_LOGIC;
        puerta_abierta    : out STD_LOGIC;
        puerta_cerrada    : out STD_LOGIC;
        alarma_puerta     : out STD_LOGIC
    );
end control_puertas;

architecture arch_puertas of control_puertas is
    signal contador      : INTEGER := 0;
    signal puerta_estado : STD_LOGIC := '0'; -- 0: Cerrada, 1: Abierta
begin
    
    process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                puerta_estado <= '0';
                alarma_puerta <= '1';
                contador <= 0;
            elsif habilitar_ascensor = '0' then
                puerta_estado <= '0';
                alarma_puerta <= '1';
                contador <= 0;
            else
                alarma_puerta <= '0';
                
                if (llegada_piso = '1' and boton_abrir = '1') and puerta_estado = '0' then
                    -- Iniciar apertura y temporización
                    puerta_estado <= '1';
                    contador <= 10;
                elsif llegada_piso = '1' and boton_cerrar = '1' and puerta_estado = '1' then
                    -- Iniciar cierre y temporización
                    puerta_estado <= '0';
                    contador <= 45;
					 elsif llegada_piso = '1' and puerta_estado = '0' then
                    -- Iniciar apertura y temporización
                    puerta_estado <= '1';
                    contador <= 10;
					 elsif llegada_piso = '1' and puerta_estado = '1' then
                    -- Iniciar cierre y temporización
                    puerta_estado <= '0';
                    contador <= 45;
					 
                elsif contador > 0 then
                    contador <= contador - 1;
					 elsif llegada_piso='0' and boton_cerrar ='1' and puerta_estado='0' then 
						  puerta_estado <= '0' ;
					 elsif llegada_piso='0' and boton_abrir ='1' and puerta_estado='0' then 
						  puerta_estado <= '0' ;  
					 elsif llegada_piso='0' and boton_cerrar ='1' and puerta_estado='1' then 
						  puerta_estado <= '0' ;  
				    elsif llegada_piso='0' and boton_abrir ='1' and puerta_estado='1' then 
						  puerta_estado <= '0' ;
                end if;
            end if;
        end if;
		  
    end process;
    
    puerta_abierta <= puerta_estado;
    puerta_cerrada <= not puerta_estado;
    
end arch_puertas;
