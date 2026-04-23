module fulladder(
    input A, B, Cin,
    output Cout, Y
    
);
     assign Cout = ((B&Cin) | (A&B) | (A&Cin));
     assign Y = (A ^ B ^ Cin);
endmodule 
