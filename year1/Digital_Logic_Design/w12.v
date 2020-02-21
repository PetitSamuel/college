module Counter_1 (output reg [2: 0] Count, input clock, reset);
always @ (posedge clock, negedge reset)
  if(reset == 0) Count = 0;
  else case(Count)
    0: Count = 1;
    1: Count = 3;
    3: Count = 7;
    4: Count = 0;
    6: Count = 4;
    7: Count = 6;
    default : Count = 0;
  endcase
endmodule
