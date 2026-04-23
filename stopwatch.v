//StopWatch: Modulo-60 Counter
module stopwatch(
    input clk,
    input rst,
    input en,
    output [5:0] state     //6-bits to represent the highest number 59
);
    wire d1out,d2out,d3out,d4out,d5out,d6out, f1out, f2out, f3out, f4out, f5out, f6out, carry1, carry2,carry3,carry4,carry5, is_min;
   
    //fulladders
    fulladder f1 (.A(d1out), .B(1'b1 ), .Y(f1out), .Cin(1'b0),   .Cout(carry1));
    fulladder f2 (.A(d2out), .B(1'b0 ) ,.Y(f2out), .Cin(carry1), .Cout(carry2));
    fulladder f3 (.A(d3out), .B(1'b0 ) ,.Y(f3out), .Cin(carry2), .Cout(carry3));
    fulladder f4 (.A(d4out), .B(1'b0 ) ,.Y(f4out), .Cin(carry3), .Cout(carry4));
    fulladder f5 (.A(d5out), .B(1'b0 ) ,.Y(f5out), .Cin(carry4), .Cout(carry5));
    fulladder f6 (.A(d6out), .B(1'b0 ) ,.Y(f6out), .Cin(carry5));
    
    assign is_min = (f1out & f2out & ~f3out & f4out &f5out & f6out);
    
    //dflipflops
    dff d1 (.Q(d1out), .D(f1out), .res(rst | is_min), .clk(clk & en));
    dff d2 (.Q(d2out), .D(f2out), .res(rst | is_min), .clk(clk & en));
    dff d3 (.Q(d3out), .D(f3out), .res(rst | is_min), .clk(clk & en));
    dff d4 (.Q(d4out), .D(f4out), .res(rst | is_min), .clk(clk & en));
    dff d5 (.Q(d5out), .D(f5out), .res(rst | is_min), .clk(clk & en));
    dff d6 (.Q(d6out), .D(f6out), .res(rst | is_min), .clk(clk & en));
    
    assign state [0] = f1out;
    assign state [1] = f2out;
    assign state [2] = f3out;
    assign state [3] = f4out;
    assign state [4] = f5out;
    assign state [5] = f6out;
    
    
endmodule




