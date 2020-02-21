
//module Circuit_2 (Out_1, Out_2, Out_3, A, B, C, D);

module t_Circuit_2;
	wire Out_1, Out_2, Out_3;
	reg A, B, C, D;
Circuit_2 M1 (A, B, C, D, Out_1, Out_2, Out_3); // Instance name required

initial
	begin
		$dumpfile("Circuit_2.vcd");
		$dumpvars(0, t_Circuit_2);
	A = 1'b0; B = 1'b1; C = 1'b0; D = 1'b1;
	#200	A = 1'b0; B = 1'b1; C = 1'b0; D = 1'b1;
	#300	A = 1'b0; B = 1'b1; C = 1'b1; D = 1'b0;
	#400	A = 1'b0; B = 1'b1; C = 1'b1; D = 1'b0;
	#500	A = 1'b0; B = 1'b1; C = 1'b1; D = 1'b1;
	#600	A = 1'b0; B = 1'b1; C = 1'b1; D = 1'b1;

	end

initial #600 $finish;
endmodule
