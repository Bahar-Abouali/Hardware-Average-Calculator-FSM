module AveDatapath (
    input clk,
    input [7:0] dataIn,
    input rstsum, loadsum,
    input rstcounter, encount,
    input loadoutput,
    output reg [8:0] countout,
    output reg [15:0] dataOut
);

    reg [15:0] sum;
    wire [15:0] next_sum;

    assign next_sum = sum + dataIn;

    always @(posedge clk) begin
        if (rstsum)
            sum <= 16'd0;
        else if (loadsum)
            sum <= next_sum;
    end

    always @(posedge clk) begin
        if (rstcounter)
            countout <= 9'd0;
        else if (encount)
            countout <= countout + 1'b1;
    end

    always @(*) begin
        if (loadoutput) begin
            if (countout == 9'd0) 
                dataOut = 16'd0;
            else
                dataOut = sum / countout;
        end
        else begin
            dataOut = 16'd0;
        end
    end

endmodule