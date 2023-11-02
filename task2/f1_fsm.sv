module f1_fsm (
    input logic clk,      
    input logic rst,      
    input logic en,      
    output logic [7:0] data_out  
);

typedef enum logic [2:0] {
    S0 = 3'b000,
    S1 = 3'b001,
    S2 = 3'b010,
    S3 = 3'b011,
    S4 = 3'b100,
    S5 = 3'b101,
    S6 = 3'b110,
    S7 = 3'b111
} my_state;

my_state current_state, next_state;

always_comb begin
    case(current_state)
        S0: next_state = S1;
        S1: next_state = S2;
        S2: next_state = S3;
        S3: next_state = S4;
        S4: next_state = S5;
        S5: next_state = S6;
        S6: next_state = S7;
        S7: next_state = S0;
        default: next_state = S0;
    endcase
end

always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
        current_state <= S0;
    end else if (en) begin
        current_state <= next_state;
    end
end

always_comb begin
    case(current_state)
        S0: data_out = 8'b0;
        S1: data_out = 8'b1;
        S2: data_out = 8'b11;
        S3: data_out = 8'b111;
        S4: data_out = 8'b1111;
        S5: data_out = 8'b11111;
        S6: data_out = 8'b111111;
        S7: data_out = 8'b1111111;
        default: data_out = 8'b0;
    endcase
end

endmodule
