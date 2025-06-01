module and_tb;
    reg A, B;
    wire Result;
//To get waveform output, use the following commands:
//iverilog -o and_tb.vvp and_tb.v and_test.v
//vvp and_tb.vvp
//gtkwave

    // Instantiate the AND gate
    and_test uut (
        .A(A),
        .B(B),
        .Result(Result)
    );

    initial begin
        // Dumping waveform info
        $dumpfile("and_test.vcd");
        $dumpvars(0, and_tb);

        // Test cases
        A = 0; B = 0; #10;
        $display("A: %b, B: %b, Result: %b", A, B, Result);

        A = 0; B = 1; #10;
        $display("A: %b, B: %b, Result: %b", A, B, Result);

        A = 1; B = 0; #10;
        $display("A: %b, B: %b, Result: %b", A, B, Result);

        A = 1; B = 1; #10;
        $display("A: %b, B: %b, Result: %b", A, B, Result);

        $finish;
    end
endmodule