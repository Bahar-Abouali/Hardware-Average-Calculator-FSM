`timescale 1ns/1ps

module tb_Average;

    reg clk;
    reg reset;
    reg start;
    reg [7:0] dataIn;
    
    wire [15:0] dataOut;
    wire dataReady;

    Average uut (
        .clk(clk),
        .reset(reset),
        .start(start),
        .dataIn(dataIn),
        .dataOut(dataOut),
        .dataReady(dataReady)
    );

    always #5 clk = ~clk;

initial begin
    
        clk = 0;
        reset = 1;
        start = 0;
        dataIn = 8'd0;

        #15;
        reset = 0;
        #10;

        start = 1;
        
        dataIn = 8'd4;
        #10;
        
        dataIn = 8'd8;
        #10;
        
        dataIn = 8'd2;
        #10;
        
        dataIn = 8'd1;
        #10;

        start = 0;
        dataIn = 8'd0;

        @(posedge dataReady);
        #5;

        $display("Calculated Average: %d (Expected: 3 )", dataOut);

        #20;
        $finish;
    end

endmodule