module AveController (
    input [7:0]dataIn,
    input start, reset, clk,
    output [15:0]dataOut,
    output dataReady, rstsum, loadsum, rstcounter, encount, rstout, loadoutput
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
            rstsum = 1'b1;
            rstcounter = 1'b1;
            rstout = 1'b1;
            if(start)
                nstate = GETData;
            else
                nstate = IDLE;
        
        GETData:
            loadsum = 1'b1;
            encount = 1'b1;
            if(start)
                nstate = GETData;
            else
                nstate = LoadData;
        
        LoadData:
            loadoutput = 1'b1;
            nstate = Done;
        
        Done:
            dataReady = 1'b1;
            nstate = IDLE;
    endcase
end