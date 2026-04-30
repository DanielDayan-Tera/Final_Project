module top 
(
    input clk,           // 100 MHz
    input btnC,          // reset
    input [15:0] sw,     // switches
    output [15:0] led,    //LEDs
    output [3:0] an,     //Outputs for 7-segment display
    output [6:0] seg     //Outputs for 7-segment display
);

/******** DO NOT MODIFY ********/
wire clk_1Hz;       //Generate Internal 1Hz Clock
wire btnC_1Hz;     //Stretch load signal

//If running simulation, output clock frequency is 100MHz, else 1Hz
`ifndef SYNTHESIS
    assign clk_1Hz = clk;
`else
    clk_div #(.INPUT_FREQ(100_000_000), .OUTPUT_FREQ(1)) clk_div_1Hz 
    (.iclk(clk) , .rst(btnC) , .oclk(clk_1Hz));
`endif

// Check stopwatch/timer frequency
initial begin
`ifndef SYNTHESIS
    $display("Stopwatch/Timer Frequency set to 100MHz");
`else
    $display("Stopwatch/Timer Frequency set to 1Hz");
`endif
end

//Seven Segment Display Interface
seven_segment_inf seven_segment_inf_inst (.clk(clk), .rst(btnC), .count(count) , .anode(an), .segs(seg));
/********************************/

/******** UNCOMMENT & UPDATE THIS SECTION ********/
//wire "count" feeds in count value to seven segment display. This should be a 6-bit value
//This will decide if seven segment display shows stopwatch count or timer count
wire [5:0] count = (mode == 1'b1) ? timerout  : stopwatchout;

/******** UPDATE THIS SECTION ********/
/******* INITIALIZE STOPWATCH AND TIMER MODULE ***********/
// Control signals
assign btnC_1Hz = btnC;
wire mode       = sw[0];           // 0 = stopwatch, 1 = timer
wire run        = sw[1];           // 0 = pause, 1 = run
wire load       = sw[2];           // 1 = load value
wire [5:0] load_val_sw = sw[15:10]; // Set Timer Value

wire [5:0] timerout;
wire [5:0] stopwatchout;


wire [5:0] count = (mode == 1'b1) ? timerout : stopwatchout;

// Timer Module Instance (Counts Down)
timer tm (
    .clk(clk_1Hz), 
    .rst(btnC_1Hz), 
    .en(run & mode),       // Only count when in Timer mode
    .load(load), 
    .load_value(load_val_sw), 
    .state(timerout)
);

// Stopwatch Module Instance (Counts Up)
stopwatch stw (
    .clk(clk_1Hz), 
    .rst(btnC_1Hz), 
    .en(run & ~mode),      // Only count when in Stopwatch mode
    .state(stopwatchout)
);

// LED Visual Feedback
//assign led[5:0] = count;     // Show current active count on first 6 LEDs
//assign led[15]  = mode;      // High LED indicates Timer Mode
assign led[8:3] = stopwatchout[5:0]; //to match table in project handout
assign led[15:10] = timerout[5:0];

endmodule
