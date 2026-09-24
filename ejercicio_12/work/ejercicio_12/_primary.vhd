library verilog;
use verilog.vl_types.all;
entity ejercicio_12 is
    port(
        iEntrada        : in     vl_logic_vector(3 downto 0);
        oDisplay1       : out    vl_logic_vector(6 downto 0);
        oDisplay2       : out    vl_logic_vector(6 downto 0);
        oDisplay3       : out    vl_logic_vector(6 downto 0);
        oDisplay4       : out    vl_logic_vector(6 downto 0);
        oDisplay5       : out    vl_logic_vector(6 downto 0);
        oDisplay6       : out    vl_logic_vector(6 downto 0);
        oLEDs_Gray      : out    vl_logic_vector(3 downto 0)
    );
end ejercicio_12;
