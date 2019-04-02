module FiniteStateMachine (A, x, y, clk, reset_b);
output reg A;
input x;
input y;
input clk;
input reset_b;
reg [1:0] state;

always @ (posedge clk, negedge reset_b)
  if(reset_b == 0) state_reg <= 2'b00;
  else case(state)
    2'b00: if(x && y) state <= 2'b01; else if(x && ~y) state <= 2'b11; else state <= 2'b00;
    2'b01: if(x) state <= 2'b10; else state <= 2'b00;
    2'b10: if(x) state <= 2'b11; else state <= 2'b00;
    2'b11: if(x) state <= 2'b11; else state <= 2'b00;
    endcase

    always @(state)
      case (state)
        2'b00: A = 1'b0;
        2'b01: A = 1'b0;
        2'b10: A = 1'b1;
        2'b11: A = 1'b1;
      endcase
endmodule
