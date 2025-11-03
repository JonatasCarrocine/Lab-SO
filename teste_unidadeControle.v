module teste_unidadeControle (opcode, clock, resetCPU, isOut, jump, regDst, regWrite, ALUSrc, memRead, memWrite, memToReg, aluOP, PCSource, isHalt);
	input wire [5:0] opcode; //instr[31:26]-
	input wire clock;
	input wire resetCPU;
	output reg isOut;
	output reg jump;
	output reg regDst;
	output reg regWrite;
	output reg ALUSrc;
	output reg memRead;
	output reg memWrite;
	output reg memToReg;
	output reg [1:0] aluOP;
	output reg [1:0] PCSource;
	output reg isHalt;
	
	reg halted;
	
	always @(posedge clock or posedge resetCPU) begin
    if (resetCPU)
        halted <= 1'b0;
    else if (opcode == 6'b010111) // HALT detectado
        halted <= 1'b1;
    // não tem else: se entrou HALT uma vez, nunca mais volta pra 0
	end
	
	always @(*) begin
		// valores padrão (NOP)
		isOut = 1'b0;
      jump = 1'b0;
		regDst = 1'b0;
		regWrite = 1'b0;
		ALUSrc = 1'b0;
		memRead = 1'b0;
		memWrite = 1'b0;
		memToReg = 1'b0;
		aluOP = 2'b00;
		PCSource = 2'b00;
		isHalt = halted;
		
		case (opcode)
			6'b000000: //Tipo add
				begin
					jump = 1'b0;
					regDst = 1'b1;
					regWrite = 1'b1;
					ALUSrc = 1'b0;
					memRead = 1'b0;
					memWrite = 1'b0;
					memToReg = 1'b0;
					aluOP    = 2'b00; // ADD
				end
			6'b000001: //Tipo addi
				begin
					jump = 1'b0;
					regDst = 1'b0;
					regWrite = 1'b1;
					ALUSrc = 1'b1;
					memRead = 1'b0;
					memWrite = 1'b0;
					memToReg = 1'b0;
					aluOP    = 2'b00; // ADD
				end
			6'b001100: //Tipo load
				begin
					jump = 1'b0;
					regDst = 1'b0;
					regWrite = 1'b1;
					ALUSrc = 1'b1;
					memRead = 1'b1;
					memWrite = 1'b0;
					memToReg = 1'b1;
					aluOP    = 2'b00; // ADD
				end
			6'b001101: //Tipo LDI
				begin
					jump = 1'b0;
					regDst = 1'b0;
					regWrite = 1'b1;
					ALUSrc = 1'b1;
					memRead = 1'b0;
					memWrite = 1'b0;
					memToReg = 1'b0;
					aluOP    = 2'b00; // ADD
				end
			6'b001110: //Tipo str
				begin
					jump   = 1'b0;
					regDst = 1'b0;
					regWrite = 1'b0;
					ALUSrc = 1'b1;
					memRead = 1'b0;
					memWrite = 1'b1;
					memToReg = 1'b0;
					aluOP    = 2'b00; // ADD
				end
			6'b010010: //Tipo JUMP
				begin
					jump   = 1'b1;
					regDst = 1'b0;
					regWrite = 1'b1;
					ALUSrc = 1'b1;
					memRead = 1'b0;
					memWrite = 1'b0;
					memToReg = 1'b0;
					PCSource = 2'b10;
				end
			6'b010011: //Tipo JR
				begin
					jump   = 1'b1;
					regDst = 1'b0;
					regWrite = 1'b0;
					ALUSrc = 1'b0;
					memRead = 1'b0;
					memWrite = 1'b0;
					memToReg = 1'b0;
					PCSource = 2'b11;
				end
			6'b010110: //Tipo OUT
				begin
					isOut = 1'b1;
					jump = 1'b0;
					regDst = 1'b0;
					regWrite = 1'b0;
					ALUSrc = 1'b0;
					memRead = 1'b0;
					memWrite = 1'b1;
					memToReg = 1'b0;
					aluOP    = 2'b00; // ADD
				end
			6'b011000: //Tipo MOVE
				begin
					jump   = 1'b0;
					regDst = 1'b1;
					regWrite = 1'b1;
					ALUSrc = 1'b0;
					memRead = 1'b0;
					memWrite = 1'b0;
					memToReg = 1'b0;
					aluOP    = 2'b00; // ADD
				end
			6'b010111: //Tipo HALT
				begin
					isHalt = 1'b1;
					jump   = 1'b0;
					regDst = 1'b0;
					regWrite = 1'b0;
					ALUSrc = 1'b0;
					memRead = 1'b0;
					memWrite = 1'b0;
					memToReg = 1'b0;
					aluOP    = 2'b00; // ADD
				end
         default: begin
               // instrução não reconhecida → sinais de NOP
            end
		endcase
	end
endmodule