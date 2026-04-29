//Timer: Mod-60 downcounter with synchronous load
module timer(
    input clk,
    input rst,
    input en,               //Enables or Disables clock
    input load,             //If load=1, load the counter with "load_value"
    input [5:0] load_value, //Value to load into counter register. Counter will then start counting from this value
    output [5:0] state     //6-bits to represent the highest number 59
);
    //  wire d1out,d2out,d3out,d4out,d5out,d6out, f1out, f2out, f3out, f4out, f5out, f6out, carry1, carry2,carry3,carry4,carry5, is_min;
    //  wire m1out,m2out,m3out,m4out,m5out,m6out;
          
    // //fulladders
    // fulladder f1 (.A(d1out), .B(m1out & en), .Y(f1out), .Cout(carry1), .Cin(1'b0));
    // fulladder f2 (.A(d2out), .B(m2out & en) ,.Y(f2out), .Cin(carry1), .Cout(carry2));
    // fulladder f3 (.A(d3out), .B(m3out & en) ,.Y(f3out), .Cin(carry2), .Cout(carry3));
    // fulladder f4 (.A(d4out), .B(m4out & en) ,.Y(f4out), .Cin(carry3), .Cout(carry4));
    // fulladder f5 (.A(d5out), .B(m5out & en) ,.Y(f5out), .Cin(carry4), .Cout(carry5));
    // fulladder f6 (.A(d6out), .B(m6out & en) ,.Y(f6out), .Cin(carry5));
    
    // assign is_min = (f1out & f2out & ~f3out & f4out &f5out & f6out);
    
    // //dflipflops
    // dff d1 (.Q(d1out), .D(f1out), .res(rst | is_min), .clk(clk));
    // dff d2 (.Q(d2out), .D(f2out), .res(rst | is_min), .clk(clk));
    // dff d3 (.Q(d3out), .D(f3out), .res(rst | is_min), .clk(clk));
    // dff d4 (.Q(d4out), .D(f4out), .res(rst | is_min), .clk(clk));
    // dff d5 (.Q(d5out), .D(f5out), .res(rst | is_min), .clk(clk));
    // dff d6 (.Q(d6out), .D(f6out), .res(rst | is_min), .clk(clk));
    
    //mux
    // mux_sel m1 (.select(load & clk), .load(load_value[0]), .def(1'b1), .muxout(m1out));
    // mux_sel m2 (.select(load& clk), .load(load_value[1]), .def(1'b1), .muxout(m2out));
    // mux_sel m3 (.select(load& clk), .load(load_value[2]), .def(1'b0), .muxout(m3out));
    // mux_sel m4 (.select(load& clk), .load(load_value[3]), .def(1'b1), .muxout(m4out));
    // mux_sel m5 (.select(load& clk), .load(load_value[4]), .def(1'b1), .muxout(m5out));
    // mux_sel m6 (.select(load& clk), .load(load_value[5]), .def(1'b1), .muxout(m6out));
    
    // assign state[0] = ~d1out;
    //assign state[1] = d2out ^ ~d1out;
    //assign state[2] = d3out ^ (~d1out & ~d2out);
    //assign state[3] = d4out ^ (~d3out & ~d1out & ~d2out);
    //assign state[4] = d5out ^ (~d4out & ~d3out & ~d1out & ~d2out);
    //assign state[5] = d6out ^ (~d5out & ~d4out & ~d3out & ~d1out & ~d2out);


    always @(posedge clk) begin
        if (rst) begin
            state <= 6'd0;// resets
        end 
        else if (load) begin
            state <= load_value;  // checks if load
        end 
        else if (en) begin
            if (state == 6'd0) begin
                state <= 6'd59; // Wrap around for Mod-60
            end else begin
                state <= state - 1'b1;   // deincraments by 1
            end
        end
    end
    

endmodule
