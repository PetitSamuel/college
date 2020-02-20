module Circuit_1 (A, B, C, F1, F2);
     output F1, F2;
     input A, B, C;
     wire w1, w2, w3, w4, w5, w6, w7; 
     and G1 (w1, A, B, C);
     or G2 (w2, A, B, C);	
     and G3 (w3, A, B);
     and G4 (w4, A, C);
     and G5 (w5, B, C);
    or  G6(F2, w3, w4, w5);
    not G7 (w6, F2);
    and G8(w7, w6, w2);
    or G9(F1, w7, w1);
endmodule