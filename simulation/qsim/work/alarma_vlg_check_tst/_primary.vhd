library verilog;
use verilog.vl_types.all;
entity alarma_vlg_check_tst is
    port(
        alarma_sonora   : in     vl_logic;
        alarma_visual   : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end alarma_vlg_check_tst;
