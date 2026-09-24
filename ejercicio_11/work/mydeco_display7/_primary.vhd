library verilog;
use verilog.vl_types.all;
entity mydeco_display7 is
    port(
        Seg             : out    vl_logic_vector(6 downto 0);
        A               : in     vl_logic_vector(3 downto 0)
    );
end mydeco_display7;
