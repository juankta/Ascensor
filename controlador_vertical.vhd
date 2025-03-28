library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity controlador_vertical is
    Port (
        clk                : in  STD_LOGIC;
        reset              : in  STD_LOGIC;
        piso_destino       : in  STD_LOGIC_VECTOR(2 downto 0);
        dir                : in  STD_LOGIC;
        habilitar_ascensor : in  STD_LOGIC;

        -- Salidas:
        piso_actual  : out STD_LOGIC_VECTOR(2 downto 0);
        piso_7seg    : out STD_LOGIC_VECTOR(6 downto 0);
        llegada      : out STD_LOGIC
    );
end controlador_vertical;

architecture controlador_vertical_arch of controlador_vertical is
    signal piso_act_reg  : integer range 0 to 4 := 0;
    signal llegada_reg   : STD_LOGIC := '0';
    signal contador      : integer range 0 to 50000000 := 0; -- Para simular tiempo de movimiento
    
    -- Función para decodificar 7 segmentos
    function decode_7seg(digit: unsigned(2 downto 0)) return std_logic_vector is
    begin
       case digit is
         when "000" => return "1000000"; -- 0
         when "001" => return "1111001"; -- 1
         when "010" => return "0100100"; -- 2
         when "011" => return "0110000"; -- 3
         when "100" => return "0011001"; -- 4
         when others => return "1111111"; -- Valor no válido
       end case;
    end function;

begin
    process(clk, reset)
        variable destino_int : integer;
    begin
        if reset = '1' then
            piso_act_reg <= 0;
            llegada_reg  <= '0';
            contador     <= 0;
        elsif rising_edge(clk) then
            destino_int := to_integer(unsigned(piso_destino));

            -- Si el ascensor ya llegó al destino
            if piso_act_reg = destino_int then
                llegada_reg <= '1';  
                contador    <= 0;  -- Reset del contador
            else
                llegada_reg <= '0';

                if habilitar_ascensor = '1' then  
                    if contador = 50000000 then -- Espera antes de moverse
                        contador <= 0;
                        if dir = '1' and piso_act_reg < 4 then
                            piso_act_reg <= piso_act_reg + 1;
                        elsif dir = '0' and piso_act_reg > 0 then
                            piso_act_reg <= piso_act_reg - 1;
                        end if;
                    else
                        contador <= contador + 1;
                    end if;
                end if;
            end if;
        end if;
    end process;
    
    -- Salidas
    piso_actual <= std_logic_vector(to_unsigned(piso_act_reg, 3));
    piso_7seg   <= decode_7seg(to_unsigned(piso_act_reg, 3));
    llegada     <= llegada_reg;
    
end controlador_vertical_arch;