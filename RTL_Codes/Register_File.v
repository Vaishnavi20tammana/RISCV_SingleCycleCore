module Register_File(clk,rst,WE3,WD3,A1,A2,A3,RD1,RD2);

    input clk,rst,WE3;
    input [4:0]A1,A2,A3;
    input [31:0]WD3;
    output [31:0]RD1,RD2;

    reg [31:0] Register [31:0];

    always @ (posedge clk)
    begin
        if(WE3)
            Register[A3] <= WD3;
    end

    assign RD1 = (~rst) ? 32'd0 : Register[A1];
    assign RD2 = (~rst) ? 32'd0 : Register[A2];

 initial begin
    //used for I-type
    //Register[9] = 32'h00000020;
    
    //used for S-Type
    //Register[6] = 32'h000000AA;

    //used for R-type
    Register[5] = 32'h0A61F;
    Register[6] = 32'h1F01;

 end
endmodule