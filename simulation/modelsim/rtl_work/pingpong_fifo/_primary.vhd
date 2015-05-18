library verilog;
use verilog.vl_types.all;
entity pingpong_fifo is
    port(
        oclk            : in     vl_logic;
        clkc0_24m       : in     vl_logic;
        sysrst_n        : in     vl_logic;
        de1             : in     vl_logic;
        de2             : in     vl_logic;
        rdreq1          : in     vl_logic;
        rdreq2          : in     vl_logic;
        data            : in     vl_logic_vector(23 downto 0);
        clr1            : in     vl_logic;
        clr2            : in     vl_logic;
        fifo1_full      : out    vl_logic;
        fifo1_empty     : out    vl_logic;
        fifo2_full      : out    vl_logic;
        fifo2_empty     : out    vl_logic;
        q1_1            : out    vl_logic_vector(23 downto 0);
        q1_2            : out    vl_logic_vector(23 downto 0);
        q2_1            : out    vl_logic_vector(23 downto 0);
        q2_2            : out    vl_logic_vector(23 downto 0)
    );
end pingpong_fifo;
