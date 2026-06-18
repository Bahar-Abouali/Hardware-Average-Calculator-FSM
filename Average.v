module Average (
    input clk,
    input reset,
    input start,
    input [7:0] dataIn,
    output [15:0] dataOut,
    output dataReady
);

    wire rstsum, loadsum, rstcounter, encount, rstout, loadoutput;
    wire [8:0] countout;

    AveController controller (
        .clk(clk),
        .reset(reset),
        .start(start),
        .dataReady(dataReady),
        .rstsum(rstsum),
        .loadsum(loadsum),
        .rstcounter(rstcounter),
        .encount(encount),
        .rstout(rstout),
        .loadoutput(loadoutput)
    );

    AveDatapath datapath (
        .clk(clk),
        .dataIn(dataIn),
        .rstsum(rstsum),
        .loadsum(loadsum),
        .rstcounter(rstcounter),
        .encount(encount),
        .loadoutput(loadoutput),
        .countout(countout),
        .dataOut(dataOut)
    );

endmodule