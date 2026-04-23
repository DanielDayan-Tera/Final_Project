module mux_sel(
    input load,     
    input select,
    input def,    //mux 
    output muxout   
);

    wire mux_sel   = select; 

// condition ? true : false
    assign muxout = (mux_sel == 1'b1) ? load  : def;
                  
endmodule
