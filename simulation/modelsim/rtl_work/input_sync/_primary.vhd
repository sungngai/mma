library verilog;
use verilog.vl_types.all;
entity input_sync is
    port(
        oclk            : in     vl_logic;
        sysrst_n        : in     vl_logic;
        hsync_in        : in     vl_logic;
        vsync_in        : in     vl_logic;
        de_in           : in     vl_logic;
        data_in         : in     vl_logic_vector(23 downto 0);
        hsync           : out    vl_logic;
        vsync           : out    vl_logic;
        de              : out    vl_logic;
        data            : out    vl_logic_vector(23 downto 0)
    );
end input_sync;
