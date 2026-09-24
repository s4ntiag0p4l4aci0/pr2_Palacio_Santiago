library verilog;
use verilog.vl_types.all;
entity my_demux_par is
    port(
        iVal            : in     vl_logic_vector(3 downto 0);
        sel1            : in     vl_logic;
        sel2            : in     vl_logic;
        oDato           : out    vl_logic_vector(3 downto 0)
    );
end my_demux_par;
