library verilog;
use verilog.vl_types.all;
entity my_decoder_4to16 is
    port(
        iBin            : in     vl_logic_vector(3 downto 0);
        oDeco           : out    vl_logic_vector(15 downto 0)
    );
end my_decoder_4to16;
