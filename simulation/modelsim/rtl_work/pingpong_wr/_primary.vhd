library verilog;
use verilog.vl_types.all;
entity pingpong_wr is
    generic(
        IDLE            : integer := 0;
        CLR_FIFO1       : integer := 1;
        WR_FIFO1        : integer := 2;
        CLR_FIFO2       : integer := 4;
        WR_FIFO2        : integer := 8
    );
    port(
        oclk            : in     vl_logic;
        sysrst_n        : in     vl_logic;
        fifo1_full      : in     vl_logic;
        fifo1_empty     : in     vl_logic;
        fifo2_full      : in     vl_logic;
        fifo2_empty     : in     vl_logic;
        de              : in     vl_logic;
        led0            : out    vl_logic;
        led1            : out    vl_logic;
        clr1            : out    vl_logic;
        clr2            : out    vl_logic;
        wrreq1          : out    vl_logic;
        wrreq2          : out    vl_logic
    );
end pingpong_wr;
