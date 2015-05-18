library verilog;
use verilog.vl_types.all;
entity fifo2_2 is
    port(
        aclr            : in     vl_logic;
        data            : in     vl_logic_vector(23 downto 0);
        rdclk           : in     vl_logic;
        rdreq           : in     vl_logic;
        wrclk           : in     vl_logic;
        wrreq           : in     vl_logic;
        q               : out    vl_logic_vector(23 downto 0);
        rdempty         : out    vl_logic;
        wrusedw         : out    vl_logic_vector(10 downto 0)
    );
end fifo2_2;
