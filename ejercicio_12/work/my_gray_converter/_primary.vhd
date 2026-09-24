library verilog;
use verilog.vl_types.all;
entity my_gray_converter is
    port(
        iBinario        : in     vl_logic_vector(3 downto 0);
        oGray           : out    vl_logic_vector(3 downto 0)
    );
end my_gray_converter;
