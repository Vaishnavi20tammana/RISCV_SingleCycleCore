module Instruction_Memory(rst,A,RD);

  input rst;
  input [31:0]A;
  output [31:0]RD;

  reg [31:0] mem [1023:0];
  
  assign RD = (~rst) ? {32{1'b0}} : mem[A[31:2]];

  initial begin
      $readmemh("mem.hex",mem);
  end
  
  initial begin
    
    //load x6, -4(x9)
    //mem[0] = 32'hFFC4A303;
    //mem[1] = 32'h00B62423;
    
    //store x6, 8(x9)
    //mem[0] = 32'h0064A423;

    //R-type or x4,x5,x6
    //mem[0] = 32'h0062E233;

    //R-type and x4,x5,x6
    //mem[0] = 32'h0062F233;
  end

endmodule