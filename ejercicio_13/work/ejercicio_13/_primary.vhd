library verilog;
use verilog.vl_types.all;
entity ejercicio_13 is
    port(
        iA              : in     vl_logic_vector(4 downto 0);
        iB              : in     vl_logic_vector(4 downto 0);
        iKeys           : in     vl_logic_vector(3 downto 0);
        oLEDs_Res       : out    vl_logic_vector(4 downto 0);
        oLED_Carry      : out    vl_logic;
        o7segD          : out    vl_logic_vector(6 downto 0);
        o7segU          : out    vl_logic_vector(6 downto 0)
    );
end ejercicio_13;
