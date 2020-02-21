module OddFunction (A, x, y, clk, reset_b);
output A;
input x;
input y;
input clk;
input reset_b;
reg state;

parameter S0 = 1'b0, S1 = 1'b1;

always @ (posedge clk, negedge reset_b)
  if(reset_b == 0) state <= S0;
  else case(state)
  S0: if((x == 1 && y == 0) ||(x==0 && y == 1)) state <= S1; else state <= S0;
  S1: if((x == 0 && y == 1) || (x== 1 && y == 0)) state <= S0; else state <= S1;
  endcase
  assign A = state;
endmodule
