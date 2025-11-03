module mux_branch (pcmais, branchEnd, branch, zero, pcProx);
	input  wire [31:0] pcmais;     // PC + 1
   input  wire [31:0] branchEnd;  // endereço do branch
   input  wire        branch;       // sinal da unidade de controle
   input  wire        zero;         // flag da ULA
   output wire [31:0] pcProx;       // próximo valor do PC

   wire branch_taken;

   // Branch só é tomado se branch=1 e zero=1
   assign branch_taken = branch & zero;
   
	// Se branch_taken=1 → vai para branch_addr
   // Se branch_taken=0 → segue fluxo normal (PC+1)
   assign pcProx = (branch_taken) ? branchEnd : pcmais;

endmodule