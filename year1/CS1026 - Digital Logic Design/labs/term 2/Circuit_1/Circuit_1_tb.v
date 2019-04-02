
module t_Circuit_1;
	wire F1, F2;
	reg A, B, C;
Circuit_1 M1 (A, B, C, F1, F2); // Instance name required

initial
	begin
		$dumpfile("Circuit_1.vcd");
		$dumpvars(0, t_Circuit_1);
		A = 1'b0; B = 1'b0; C = 1'b0;
		#100 A = 1'b0; B = 1'b0; C = 1'b1;
		#200 A = 1'b0; B = 1'b1; C = 1'b0;
		#300 A = 1'b0; B = 1'b1; C = 1'b1;
	  #400 A = 1'b1; B = 1'b0; C = 1'b0;
		#500 A = 1'b1; B = 1'b1; C = 1'b0;
		#600 A = 1'b1; B = 1'b1; C = 1'b1;
	end

initial #600 $finish;
endmodule
