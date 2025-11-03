module temporizador (
    input  wire clock,
    output wire reduzclock
);
    reg [25:0] contador = 26'b0;  // inicializa com zero

    always @(posedge clock) begin
        contador <= contador + 1'b1;
    end

    assign reduzclock = contador[25];
endmodule
