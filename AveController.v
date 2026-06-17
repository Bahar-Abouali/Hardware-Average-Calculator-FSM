module average (
    input [7:0]dataIn, start, reset, clk,
    output [15:0]dataOut, dataReady
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
    else:
        Pstate <= nstate;
end

always @(Pstate, start) begin
    nstate = IDLE;
    case(Pstate)
        IDLE:
            if(start)
                nstate = GETData;
            else
                nstate = IDLE;
        
        GETData:
            if(start)
                nstate = GETData;
            else
                nstate = LoadData;
        
        LoadData:
            nstate = Done;
        
        Done:
            nstate = IDLE;
    endcase
end

assign dataReady = (Pstate==Done) ? 1'b1 : 1'b0;
                     