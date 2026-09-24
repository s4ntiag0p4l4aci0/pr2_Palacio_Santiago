library verilog;
use verilog.vl_types.all;
entity mymux4to4 is
    port(
        Y               : out    vl_logic_vector(3 downto 0);
        A               : in     vl_logic_vector(3 downto 0);
        S               : in     vl_logic
    );
end mymux4to4;
