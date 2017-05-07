library verilog;
use verilog.vl_types.all;
entity sound is
    port(
        BZ              : out    vl_logic;
        data            : in     vl_logic_vector(15 downto 0);
        CLK             : in     vl_logic;
        RSTN            : in     vl_logic
    );
end sound;
