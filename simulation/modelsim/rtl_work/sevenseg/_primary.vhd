library verilog;
use verilog.vl_types.all;
entity sevenseg is
    port(
        SEGX_SEL        : out    vl_logic_vector(8 downto 0);
        SEGX_A          : out    vl_logic_vector(7 downto 0);
        SEGX_B          : out    vl_logic_vector(7 downto 0);
        SEGX_C          : out    vl_logic_vector(7 downto 0);
        SEGX_D          : out    vl_logic_vector(7 downto 0);
        SEGX_E          : out    vl_logic_vector(7 downto 0);
        SEGX_F          : out    vl_logic_vector(7 downto 0);
        SEGX_G          : out    vl_logic_vector(7 downto 0);
        SEGX_H          : out    vl_logic_vector(7 downto 0);
        LEDX            : in     vl_logic_vector(63 downto 0);
        DATA0           : in     vl_logic_vector(15 downto 0);
        DATA1           : in     vl_logic_vector(15 downto 0);
        DATA2           : in     vl_logic_vector(15 downto 0);
        DATA3           : in     vl_logic_vector(15 downto 0);
        DATA4           : in     vl_logic_vector(15 downto 0);
        DATA5           : in     vl_logic_vector(15 downto 0);
        DATA6           : in     vl_logic_vector(15 downto 0);
        DATA7           : in     vl_logic_vector(15 downto 0);
        DATAP           : in     vl_logic_vector(15 downto 0);
        DATAQ           : in     vl_logic_vector(15 downto 0);
        DATAR           : in     vl_logic_vector(15 downto 0);
        DATAS           : in     vl_logic_vector(15 downto 0);
        DATAT           : in     vl_logic_vector(15 downto 0);
        DATAU           : in     vl_logic_vector(15 downto 0);
        DATAV           : in     vl_logic_vector(15 downto 0);
        DATAW           : in     vl_logic_vector(15 downto 0);
        CLK             : in     vl_logic;
        RSTN            : in     vl_logic
    );
end sevenseg;
