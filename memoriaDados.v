module memoriaDados (
    input wire clock,
    input wire MemRead,
    input wire MemWrite,
    input wire [10:0] endereco,   // 2048 posições = 11 bits
    input wire [31:0] writeData,
    output reg [31:0] readData
);

    // memória de 32 bits x 2048 palavras
    reg [31:0] mem [0:2047];

    // escrita sincronizada
    always @(posedge clock) begin
        if (MemWrite)
            mem[endereco] <= writeData;
    end

    // leitura sincronizada (forma que o Quartus reconhece como RAM)
    always @(posedge clock) begin
        if (MemRead)
            readData <= mem[endereco];
    end

endmodule
