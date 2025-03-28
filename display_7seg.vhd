library IEEE;
use IEEE.STD_LOGIC_1164.ALL;  -- Solo esta librería es necesaria

entity display_7seg is
    Port (
        piso_bin  : in  STD_LOGIC_VECTOR(2 downto 0); -- Número del piso en binario
        piso_7seg : out STD_LOGIC_VECTOR(6 downto 0) -- Salida para display de 7 segmentos
    );
end display_7seg;

architecture arch_display of display_7seg is
begin
    process(piso_bin)
    begin
        case piso_bin is
            when "000" => piso_7seg <= "0111111"; -- 0
            when "001" => piso_7seg <= "0000110"; -- 1
            when "010" => piso_7seg <= "1011011"; -- 2
            when "011" => piso_7seg <= "1001111"; -- 3
            when "100" => piso_7seg <= "1100110"; -- 4
            when others => piso_7seg <= "0000000"; -- Apagado
        end case;
    end process;
end arch_display;