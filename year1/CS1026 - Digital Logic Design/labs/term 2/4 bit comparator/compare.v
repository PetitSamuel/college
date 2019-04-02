module Compare (A, B, Y);

  input [3:0] A;
  input [3:0] B;
  output [5:0] Y;

  reg [5:0] Y;


always @(A or B)
 begin
 Y[0] = 0;
 Y[1] = 0;
 Y[2] = 0;
 Y[3] = 0;
 Y[4] = 0;
 Y[5] = 0;

  if(A == B) Y[5] = 1;
  else Y[4] = 1;

  if (Y[4] == 1 && A > B) Y[3] = 1;
  else if (Y[4] == 1 && A < B) Y[2] = 1;
  if(A > B || A == B) Y[1] = 1;
  if(A < B || A == B) Y[0] = 1;
end
endmodule
