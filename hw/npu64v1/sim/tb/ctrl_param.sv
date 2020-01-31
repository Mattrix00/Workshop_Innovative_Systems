import globals_sv::*;


module ctrl_param (
		     input 		 c1_c2_n,
		     output 		 opcode,
		     output [CLOG2K-1:0] arv_ksize,
		     output [CLOG2W-1:0] arv_ckgate,
		     output [CLOG2T-1:0] arv_i_tile,		   
		     output [CLOG2T-1:0] arv_o_tile,
		     output [CLOG2B-1:0] arv_ifmaps,
		     output [CLOG2C-1:0] arv_ofmaps
		   );
   
   reg [CLOG2W-1:0] 			 int_arv_npu 	 = '0; // default size is 32: truncated unsigned vector
   reg [CLOG2K-1:0] 			 int_arv_ksize 	 = '0;
   reg [CLOG2W-1:0] 			 int_arv_ckgate  = '0;   
   reg [CLOG2T-1:0] 			 int_arv_i_tile  = '0;
   reg [CLOG2T-1:0] 			 int_arv_o_tile  = '0;   
   reg [CLOG2B-1:0] 			 int_arv_ifmaps  = '0;
   reg [CLOG2C-1:0] 			 int_arv_ofmaps  = '0;

   localparam ARV_W    = W-1;
   localparam ARV_K    = K-1;
   
   localparam ARV_CKG1 = ARV_W - ARV_K;
   localparam ARV_i_T1 = C1_NB_TILE-1;     
   localparam ARV_o_T1 = C1_NB_TILE-1; // same as input tile always?
   localparam ARV_TB1  = C1_NB_TILEB-1;
   localparam ARV_TC1  = C1_NB_TILEC-1;
   
   localparam ARV_CKG2 = 1;
   localparam ARV_i_T2 = C2_NB_TILE-1;     
   localparam ARV_o_T2 = C2_NB_TILE-1;
   localparam ARV_TB2  = C2_NB_TILEB-1;
   localparam ARV_TC2  = C2_NB_TILEC-1;
   
   assign arv_ksize   = int_arv_ksize + ARV_K;	
   assign arv_ckgate  = (c1_c2_n == 1'b0) ? int_arv_ckgate + ARV_CKG1 : int_arv_ckgate + ARV_CKG2;
   assign arv_i_tile  = (c1_c2_n == 1'b0) ? int_arv_i_tile + ARV_i_T1 : int_arv_i_tile + ARV_i_T2;
   assign arv_o_tile  = (c1_c2_n == 1'b0) ? int_arv_o_tile + ARV_o_T1 : int_arv_o_tile + ARV_o_T2;
   assign arv_ifmaps  = (c1_c2_n == 1'b0) ? int_arv_ifmaps + ARV_TB1  : int_arv_ifmaps + ARV_TB2;
   assign arv_ofmaps  = (c1_c2_n == 1'b0) ? int_arv_ofmaps + ARV_TC1  : int_arv_ifmaps + ARV_TC2;
   
endmodule // ctrl_param

   
		     