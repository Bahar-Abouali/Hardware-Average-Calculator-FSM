module AveController (
    input start, reset, clk,
    output reg dataReady, rstsum, loadsum, rstcounter, encount, rstout, loadoutput
);

parameter [1:0]
    IDLE     = 2'b00,
    GETData  = 2'b01,
    LoadData = 2'b10,
    Done     = 2'b11;

reg [1:0] Pstate, nstate;

always @(posedge clk)
begin
    if (reset)
        Pstate <= IDLE;
    else
        Pstate <= nstate;
end

always @(Pstate, start) begin
    dataReady  = 1'b0;
    rstsum     = 1'b0;
    loadsum    = 1'b0;
    rstcounter = 1'b0;
    encount    = 1'b0;
    rstout     = 1'b0;
    loadoutput = 1'b0;
    nstate = IDLE;
    case(Pstate)
        IDLE:
        begin
            rstsum = 1'b1;
            rstcounter = 1'b1;
            rstout = 1'b1;
            if(start)
                nstate = GETData;
            else
                nstate = IDLE;
        end

        GETData:
        begin
            loadsum = 1'b1;
            encount = 1'b1;
            if(start)
                nstate = GETData;
            else
                nstate = LoadData;
        end

        LoadData:
        begin
            loadoutput = 1'b1;
            nstate = Done;
        end

        Done:
        begin
            dataReady = 1'b1;
            nstate = IDLE;
        end

        default:
            nstate = IDLE;

    endcase
end
endmodule