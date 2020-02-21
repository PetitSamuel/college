module BCD_Adder (Sum, Carry_out, Addend, Augend, Carry_in);
  output [3:0] Sum;
  output Carry_out;
  input [3:0] Addend;
  input [3:0] Augend;
  input Carry_in;
  reg [3:0] Sum;
  reg Carry_out;

    always @(Addend or Augend or Carry_in)
	   begin
	    {Carry_out, Sum} = Addend + Augend +Carry_in;
      if({Carry_out, Sum} > 9) {Carry_out, Sum} = {Carry_out, Sum} + 6;
    end
endmodule
