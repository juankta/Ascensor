library verilog;
use verilog.vl_types.all;
entity alarma is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        alarma_personas : in     vl_logic;
        falla_energia   : in     vl_logic;
        alarma_puerta   : in     vl_logic;
        alarma_sonora   : out    vl_logic;
        alarma_visual   : out    vl_logic
    );
end alarma;
