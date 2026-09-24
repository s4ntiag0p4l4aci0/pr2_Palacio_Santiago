library verilog;
use verilog.vl_types.all;
entity my_alu_core is
    port(
        iA              : in     vl_logic_vector(4 downto 0);
        iB              : in     vl_logic_vector(4 downto 0);
        iSel            : in     vl_logic_vector(2 downto 0);
        oResultado      : out    vl_logic_vector(4 downto 0);
        oCarry          : out    vl_logic
    );
end my_alu_core;
