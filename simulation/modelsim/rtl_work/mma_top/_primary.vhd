library verilog;
use verilog.vl_types.all;
entity mma_top is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        oclk            : in     vl_logic;
        hsync_in        : in     vl_logic;
        vsync_in        : in     vl_logic;
        de_in           : in     vl_logic;
        data_in         : in     vl_logic_vector(23 downto 0);
        led0            : out    vl_logic;
        led1            : out    vl_logic;
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
end mma_top;
