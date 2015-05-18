library verilog;
use verilog.vl_types.all;
entity vga_controler is
    generic(
        IDLE            : integer := 0;
        RD_FIFO1        : integer := 1;
        RD_FIFO2        : integer := 2
    );
    port(
        clkc0_24m       : in     vl_logic;
        sysrst_n        : in     vl_logic;
        hsync_in        : in     vl_logic;
        vsync_in        : in     vl_logic;
        q1_1            : in     vl_logic_vector(23 downto 0);
        q1_2            : in     vl_logic_vector(23 downto 0);
        q2_1            : in     vl_logic_vector(23 downto 0);
        q2_2            : in     vl_logic_vector(23 downto 0);
        fifo1_full      : in     vl_logic;
        fifo1_empty     : in     vl_logic;
        fifo2_full      : in     vl_logic;
        fifo2_empty     : in     vl_logic;
        rdreq1          : out    vl_logic;
        rdreq2          : out    vl_logic;
        vga_clk         : out    vl_logic;
        hsync_l         : out    vl_logic;
        vsync_l         : out    vl_logic;
        blank_n_l       : out    vl_logic;
        sync_n_l        : out    vl_logic;
        vga_l           : out    vl_logic_vector(23 downto 0);
        hsync_r         : out    vl_logic;
        vsync_r         : out    vl_logic;
        blank_n_r       : out    vl_logic;
        sync_n_r        : out    vl_logic;
        vga_r           : out    vl_logic_vector(23 downto 0)
    );
end vga_controler;
