library verilog;
use verilog.vl_types.all;
entity my_deco_7seg is
    port(
        iBCD            : in     vl_logic_vector(3 downto 0);
        oSegmentos      : out    vl_logic_vector(6 downto 0)
    );
end my_deco_7seg;
