//Timer: Mod-50 downcounter with synchronous load
module timer(
    input clk,
    input rst,
    input en,               //Enables or Disables clock
    input load,             //If load=1, load the counter with "load_value"
    input [5:0] load_value, //Value to load into counter register. Counter will then start counting from this value
    output [5:0] state     //5-bits to represent the highest number 59
);
    wire d0out,d1out,d2out,d3out,d5out,d4out, is_zero;
    wire m0out,m1out,m2out,m3out,m4out,m5out;
    wire [5:0] next_state;
    
    assign next_state[0] = ~d0out;
    assign next_state[1] = d1out ^ ~d0out;
    assign next_state[2] = d2out ^ (~d0out & ~d1out);
    assign next_state[3] = d3out ^ (~d2out & ~d0out & ~d1out);
    assign next_state[4] = d4out ^ (~d3out & ~d2out & ~d0out & ~d1out);
    assign next_state[5] = d5out ^ (~d4out & ~d3out & ~d2out & ~d0out & ~d1out);
    
    assign is_zero = (~d0out & ~d1out & ~d2out & ~d3out & ~d4out & ~d5out);
    
     //dflipflops
     dff d0 (.Q(d0out), .D(mux_load0out), .res(rst), .clk(clk));
     dff d1 (.Q(d1out), .D(mux_load1out), .res(rst), .clk(clk));
     dff d2 (.Q(d2out), .D(mux_load2out), .res(rst), .clk(clk));
     dff d3 (.Q(d3out), .D(mux_load3out), .res(rst), .clk(clk));
     dff d4 (.Q(d4out), .D(mux_load4out), .res(rst), .clk(clk));
     dff d5 (.Q(d5out), .D(mux_load5out), .res(rst), .clk(clk));
    
    //first mux
     mux_sel m0 (.select(en & ~is_zero), .load(next_state[0]), .def(d0out), .muxout(m0out));
     mux_sel m1 (.select(en & ~is_zero), .load(next_state[1]), .def(d1out), .muxout(m1out));
     mux_sel m2 (.select(en & ~is_zero), .load(next_state[2]), .def(d2out), .muxout(m2out));
     mux_sel m3 (.select(en & ~is_zero), .load(next_state[3]), .def(d3out), .muxout(m3out));
     mux_sel m4 (.select(en & ~is_zero), .load(next_state[4]), .def(d4out), .muxout(m4out));
     mux_sel m5 (.select(en & ~is_zero), .load(next_state[5]), .def(d5out), .muxout(m5out));
     
     //second mux
     mux_sel mux_load0 (.select(load), .load(load_value[0]), .def(m0out), .muxout(mux_load0out));
     mux_sel mux_load1 (.select(load), .load(load_value[1]), .def(m1out), .muxout(mux_load1out));
     mux_sel mux_load2 (.select(load), .load(load_value[2]), .def(m2out), .muxout(mux_load2out));
     mux_sel mux_load3 (.select(load), .load(load_value[3]), .def(m3out), .muxout(mux_load3out));
     mux_sel mux_load4 (.select(load), .load(load_value[4]), .def(m4out), .muxout(mux_load4out));
     mux_sel mux_load5 (.select(load), .load(load_value[5]), .def(m5out), .muxout(mux_load5out));
    
    assign state[0] = d0out;
    assign state[1] = d1out;
    assign state[2] = d2out;
    assign state[3] = d3out;
    assign state[4] = d4out;
    assign state[5] = d5out;


//    always @(posedge clk) begin
//        if (rst) begin
//            state <= 6'd0;// resets
//        end 
//        else if (load) begin
//            state <= load_value;  // checks if load
//        end 
//        else if (en) begin
//            if (state == 6'd0) begin
//                state <= 6'd49; // Wrap around for Mod-60
//            end else begin
//                state <= state - 1'b1;   // deincraments by 1
//            end
//        end
//    end
    

endmodule
