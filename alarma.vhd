library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity alarma is
    Port (
        clk             : in  STD_LOGIC;
        reset           : in  STD_LOGIC;
        alarma_personas : in  STD_LOGIC;  -- Se activa si hay más de 10 personas
        falla_energia   : in  STD_LOGIC;  -- Se activa si hay una anomalía de energía
        alarma_puerta   : in  STD_LOGIC;  -- Nueva entrada: problema con la puerta
        alarma_sonora   : out STD_LOGIC;
        alarma_visual   : out STD_LOGIC
    );
end alarma;

architecture arch_alarma of alarma is
    signal alarma_activa : STD_LOGIC := '0'; -- Señal interna para la alarma
    signal contador      : INTEGER range 0 to 50000 := 0; -- Se redujo el valor del contador
    signal buzzer_clk    : STD_LOGIC := '0'; -- Genera sonido intermitente

begin
    process(clk, reset)
    begin
        if reset = '1' then
            alarma_activa <= '0';
            buzzer_clk    <= '0';
            contador      <= 0;
        elsif rising_edge(clk) then
            -- Activar alarma en caso de más de 10 personas, falla de energía o problema con la puerta
            if alarma_personas = '1' or falla_energia = '1' or alarma_puerta = '1' then
                alarma_activa <= '1';
            else
                alarma_activa <= '0';
            end if;

            -- Generar pulso intermitente para la alarma sonora
            if alarma_activa = '1' then
                if contador < 50000 then  -- Se redujo el tiempo de alternancia
                    contador <= contador + 1;
                else
                    contador <= 0;
                    buzzer_clk <= NOT buzzer_clk; -- Alterna la señal del buzzer más rápido
                end if;
            else
                buzzer_clk <= '0'; -- Silencia la alarma cuando no está activa
            end if;
        end if;
    end process;

    -- Asignar señales de salida
    alarma_sonora <= alarma_activa OR buzzer_clk; -- Ahora la alarma sonora siempre se activa cuando hay una alarma
    alarma_visual <= alarma_activa; -- La alarma visual sigue siendo continua cuando está activa

end arch_alarma;

