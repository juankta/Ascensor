library verilog;
use verilog.vl_types.all;
entity alarma_vlg_sample_tst is
    port(
        alarma_personas : in     vl_logic;
        alarma_puerta   : in     vl_logic;
        clk             : in     vl_logic;
        falla_energia   : in     vl_logic;
        reset           : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end alarma_vlg_sample_tst;
