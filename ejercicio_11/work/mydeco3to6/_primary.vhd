library verilog;
use verilog.vl_types.all;
entity mydeco3to6 is
    port(
        Y               : out    vl_logic_vector(5 downto 0);
        D               : in     vl_logic_vector(2 downto 0)
    );
end mydeco3to6;
