module registradores(clock, isHalt, leituraUm, leituraDois, regEscrita, escreveDado, DadosUm, DadosDois, escreveReg);
	input clock;
	input isHalt;            // << NOVO
	
	input [4:0] leituraUm; //rs
	input [4:0] leituraDois; //rt
	input [4:0] regEscrita; //rd (mux_regdst)
	input [31:0] escreveDado; //dado a escrever
	
	input escreveReg; // sinal de controle WriteEnable
	
	
	output [31:0] DadosUm;
	output [31:0] DadosDois;

	
	
	reg [31:0] registradores [31:0];
	
	// Leitura assíncrona
   assign DadosUm   = registradores[leituraUm];
   assign DadosDois = registradores[leituraDois];
	
	// Escrita síncrona
    always @(posedge clock) begin
        if (!isHalt && escreveReg && regEscrita != 0) begin
            registradores[regEscrita] <= escreveDado;
        end
    end
endmodule