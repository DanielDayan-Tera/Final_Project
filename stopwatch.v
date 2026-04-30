//StopWatch: Modulo-60 Counter
module stopwatch(
    input clk,
    input rst,
    input en,
    output [5:0] state     //6-bits to represent the highest number 59
);
    wire d0out,d1out,d2out,d3out,d4out,d5out, f0out, f1out, f2out, f3out, f4out, f5out, carry0, carry1,carry2,carry3,carry4, is_max;
   
    //fulladders
    fulladder f0 (.A(d0out), .B(1'b1 ), .Y(f0out), .Cin(1'b0),   .Cout(carry0));
    fulladder f1 (.A(d1out), .B(1'b0 ) ,.Y(f1out), .Cin(carry0), .Cout(carry1));
    fulladder f2 (.A(d2out), .B(1'b0 ) ,.Y(f2out), .Cin(carry1), .Cout(carry2));
    fulladder f3 (.A(d3out), .B(1'b0 ) ,.Y(f3out), .Cin(carry2), .Cout(carry3));
    fulladder f4 (.A(d4out), .B(1'b0 ) ,.Y(f4out), .Cin(carry3), .Cout(carry4));
    fulladder f5 (.A(d5out), .B(1'b0 ) ,.Y(f5out), .Cin(carry4));
    
    //assign is_max = (f0out & f1out & ~f2out & f3out &f4out & f5out);
    
    assign is_max = (d5out & d4out & d3out & d2out & ~d1out & ~d0out);
    
    //dflipflops
    dff d0 (.Q(d0out), .D(f0out), .res(rst | is_max), .clk(clk & en));
    dff d2 (.Q(d2out), .D(f2out), .res(rst | is_max), .clk(clk & en));
    dff d1 (.Q(d1out), .D(f1out), .res(rst | is_max), .clk(clk & en));
    dff d3 (.Q(d3out), .D(f3out), .res(rst | is_max), .clk(clk & en));
    dff d4 (.Q(d4out), .D(f4out), .res(rst | is_max), .clk(clk & en));
    dff d5 (.Q(d5out), .D(f5out), .res(rst | is_max), .clk(clk & en));
    
    assign state [0] = d0out;
    assign state [1] = d1out;
    assign state [2] = d2out;
    assign state [3] = d3out;
    assign state [5] = d5out;
    assign state [4] = d4out;



//    //try this;
//    always @(posedge clk) begin
//        if(rst) begin
//            state <= 6'd0    // if reset set to 0
//        end else if (en) begin
//            if(state == 6'd49) begin
//                state <=6'd0;  // if 59 and en is on res to 0
//            end else begin
//                state <= state + 1'b1;   // instead of adders adds one if its not 59
//            end
//        end
//    end
    
    
endmodule
