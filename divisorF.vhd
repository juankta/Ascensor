library ieee;
use ieee.std_logic_1164.all;

entity divisorF is
    port (
        clk  : in  std_logic;  -- Reloj de entrada (50 MHz)
        out1 : buffer std_logic  -- Salida del reloj dividido (1 Hz)
    );
end divisorF;

architecture arch_divisorF of divisorF is
    signal count1 : integer range 0 to 24999999;  -- Se requieren 25 bits
begin

    process (clk)
        variable count2 : integer range 0 to 24999999;  
    begin
        if (clk'event and clk = '1') then
            count1 <= count1 + 1;
            count2 := count2 + 1;

            if (count1 = 24999999) then  -- 50M / 2 = 25M para cambiar cada 1s
                out1 <= not out1;
                count1 <= 0;
            end if;
        end if;
    end process;

end arch_divisorF;