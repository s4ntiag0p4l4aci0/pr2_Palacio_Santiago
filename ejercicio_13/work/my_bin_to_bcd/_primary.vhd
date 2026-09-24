library verilog;
use verilog.vl_types.all;
entity my_bin_to_bcd is
    port(
        iBinario        : in     vl_logic_vector(4 downto 0);
        oDecenas        : out    vl_logic_vector(3 downto 0);
        oUnidades       : out    vl_logic_vector(3 downto 0)
    );
end my_bin_to_bcd;
