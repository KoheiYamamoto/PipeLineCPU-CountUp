library verilog;
use verilog.vl_types.all;
entity cputop is
    port(
        SEGX_A          : out    vl_logic_vector(7 downto 0);
        SEGX_B          : out    vl_logic_vector(7 downto 0);
        SEGX_C          : out    vl_logic_vector(7 downto 0);
        SEGX_D          : out    vl_logic_vector(7 downto 0);
        SEGX_E          : out    vl_logic_vector(7 downto 0);
        SEGX_F          : out    vl_logic_vector(7 downto 0);
        SEGX_G          : out    vl_logic_vector(7 downto 0);
        SEGX_H          : out    vl_logic_vector(7 downto 0);
        SEGX_SEL        : out    vl_logic_vector(8 downto 0);
        SEG_A           : out    vl_logic_vector(7 downto 0);
        SEG_B           : out    vl_logic_vector(7 downto 0);
        SEG_SELA        : out    vl_logic_vector(3 downto 0);
        SEG_SELB        : out    vl_logic_vector(3 downto 0);
        LED             : out    vl_logic_vector(7 downto 0);
        BZ              : out    vl_logic;
        PSW_D0          : in     vl_logic;
        PSW_D1          : in     vl_logic;
        CLK             : in     vl_logic;
        CLK20MHZ        : in     vl_logic;
        RSTN            : in     vl_logic
    );
end cputop;
