// Priority encoder
module encode (A, valid, Y);
input [7:0] A; // 8-bit input vector
output [2:0] Y; // 3-bit encoded output
output valid; // Asserted when an input is not all 0’s
reg [2:0] Y; // target of assignment
reg valid;
 always @(A) begin
 valid = 1;
 casex (A)
 8’bXXXXXXX1: Y = 0;
 8’bXXXXXX10: Y = 1;
 8’bXXXXX100: Y = 2;
 8’bXXXX1000: Y = 3;
 8’bXXX10000: Y = 4;
 8’bXX100000: Y = 5;
 8’bX1000000: Y = 6;
 8’b10000000: Y = 7;
 default: begin
 valid = 0;
 Y = 3’bX; // Don’t care when input is all 0’s
 end
 endcase
 end
endmodule
