module dff(
    input clk,
    input D,
    input res,
    output reg Q,
    output reg Q_nt
    );
    initial begin
        Q = 1'b0;
        Q_nt = 1'b1;
    end
    
    always @(posedge clk, posedge res) begin
        if(res) 
            Q <= 1'b0;
        else begin
            Q <= D;
            Q_nt <= ~D;
        end     
    end
endmodule
