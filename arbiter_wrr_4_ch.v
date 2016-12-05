// arbiter_wrr_4_ch.v

module arbiter_wrr_4_ch(
						input clk,
						input resetb,
						input [3:0] req_vec,		// Bus Resuest pin for 4 masters with one hot encoding 
						
						input [3:0] req_vec_wt_0,	// Programmable weight for master 0
						input [3:0] req_vec_wt_1,	// Programmable weight for master 1
						input [3:0] req_vec_wt_2,	// Programmable weight for master 2
						input [3:0] req_vec_wt_3,	// Programmable weight for master 3		

						input req_n_valid ,			// Active high pulse signal to indicate new arbitration interval (similar to ALE)						
						input  [3:0] end_access_vec,	// Bus handover / End Bus Request pin for 3 masters with one hot encoding 
						output reg [3:0] gnt_vec 		/*change*/			
					);

reg  [2:0] arbiter_state, arbiter_state_nxt;	
reg  [3:0] gnt_vec_nxt;
reg  [3:0] count_req_vec [3:0];			/*change 2ND PART*/
reg  [3:0] count_req_vec_nxt [3:0];		/*change 2ND PART*/

wire [3:0] cnt_reqdone_vec;
reg  [3:0] relative_req_vec;
reg  [1:0] grant_posn,grant_posn_nxt;
reg  [3:0] relative_cntdone_vec;

reg  [3:0] req_vec_wt_stored [3:0];
wire [3:0] req_vec_wt[3:0];

parameter IDLE 		= 3'b001,	ARM_VALUE 		= 3'b010,		END_ACCESS 		= 3'b100;
parameter IDLE_ID 	= 0,		ARM_VALUE_ID 	= 1,			END_ACCESS_ID 	= 2;

assign req_vec_wt[0] = req_vec_wt_0;
assign req_vec_wt[1] = req_vec_wt_1;
assign req_vec_wt[2] = req_vec_wt_2;
assign req_vec_wt[3] = req_vec_wt_3;


always@(*)
	begin
		relative_req_vec = req_vec;				// req_vec  = Bus Resuest pin
		// rotate to right 
		
		case(grant_posn)											// keeps track of orginal bus 
		2'd0: relative_req_vec	= {req_vec[0],req_vec[3:1]};		// performs rotating of bus requests
		2'd1: relative_req_vec	= {req_vec[1:0],req_vec[3:2]};		// relative_req_vec = rotated requests
		2'd2: relative_req_vec	= {req_vec[2:0],req_vec[3] };				
		2'd3: relative_req_vec	= {req_vec[3:0]};		
		default : begin end
		endcase		
	end
	
	
always@(*)
	begin
		relative_cntdone_vec	= cnt_reqdone_vec;
		//rotate to right
		
		case(grant_posn)
		2'd0: relative_cntdone_vec	= {cnt_reqdone_vec[0]  ,cnt_reqdone_vec[3:1]};
		2'd1: relative_cntdone_vec	= {cnt_reqdone_vec[1:0],cnt_reqdone_vec[3:2]};		
		2'd2: relative_cntdone_vec	= {cnt_reqdone_vec[2:0],cnt_reqdone_vec[3]} ;				
		2'd3: relative_cntdone_vec	= {cnt_reqdone_vec[3:0]};				
		default : begin end
		endcase
	end

always@(*)
		begin
			arbiter_state_nxt		= arbiter_state;
			gnt_vec_nxt				= gnt_vec;
			count_req_vec_nxt[0]	= count_req_vec[0];
			count_req_vec_nxt[1]	= count_req_vec[1];
			count_req_vec_nxt[2]	= count_req_vec[2];			
			count_req_vec_nxt[3]	= count_req_vec[3];	
			grant_posn_nxt			= grant_posn;

			case(1'b1)			// shortcut method for implementing priority structure instead of if-else statements
				arbiter_state[IDLE_ID]	: 
						begin
							if(req_n_valid)
								begin
									arbiter_state_nxt		= ARM_VALUE;
									
									count_req_vec_nxt[0]	= req_vec_wt[0];
									count_req_vec_nxt[1]	= req_vec_wt[1];						
									count_req_vec_nxt[2]	= req_vec_wt[2];				
									count_req_vec_nxt[3]	= req_vec_wt[3];	
																		
									gnt_vec_nxt			= 4'b0000;
								end
						end
				arbiter_state[ARM_VALUE_ID] :
						begin
							if ((gnt_vec== 'd0)				 	 ||   // If nobody   has bus  			  OR 
								(end_access_vec[0] & gnt_vec[0]) ||   // If Master 1 had bus  & let it go OR	
								(end_access_vec[1] & gnt_vec[1]) ||   // If Master 2 had bus  & let it go OR		
								(end_access_vec[2] & gnt_vec[2]) ||   // If Master 3 had bus  & let it go OR
								(end_access_vec[3] & gnt_vec[3]) )    // If Master 4 had bus  & let it go OR								
									begin
										if (relative_req_vec[0] & !relative_cntdone_vec[0])
											begin
												arbiter_state_nxt = END_ACCESS;			
												
												case(grant_posn)			// 
												2'd0 :	gnt_vec_nxt	= 4'b0010;
												2'd1 :	gnt_vec_nxt	= 4'b0100;
												2'd2 :	gnt_vec_nxt	= 4'b1000;
												2'd3 :	gnt_vec_nxt	= 4'b0001;
												default: begin end
												endcase
											
												case(grant_posn)			// reduces weight count by 1 when bus is granted + the values are rotated accordingly
												2'd0 :	count_req_vec_nxt[1]	= count_req_vec_nxt[1] -1'b1;
												2'd1 :	count_req_vec_nxt[2]	= count_req_vec_nxt[2] -1'b1;
												2'd2 :	count_req_vec_nxt[3]	= count_req_vec_nxt[3] -1'b1;
												2'd3 :	count_req_vec_nxt[0]	= count_req_vec_nxt[0] -1'b1;
												default: begin end
												endcase
												
												case(grant_posn)			// decides next grant position
												2'd0 :	grant_posn_nxt	= 'd1;
												2'd1 :	grant_posn_nxt	= 'd2;
												2'd2 :	grant_posn_nxt	= 'd3;
												2'd3 :	grant_posn_nxt	= 'd0;
												default: begin end
												endcase
											end
										else
										if (relative_req_vec[1] & !relative_cntdone_vec[1])
											begin
												arbiter_state_nxt = END_ACCESS;			
												
												case(grant_posn)			// 
												2'd0 :	gnt_vec_nxt	= 4'b0100;
												2'd1 :	gnt_vec_nxt	= 4'b1000;
												2'd2 :	gnt_vec_nxt	= 4'b0001;
												2'd3 :	gnt_vec_nxt	= 4'b0010;
												default: begin end
												endcase
											
												case(grant_posn)			// reduces weight count by 1 when bus is granted + the values are rotated accordingly
												2'd0 :	count_req_vec_nxt[2]	= count_req_vec_nxt[2] -1'b1;
												2'd1 :	count_req_vec_nxt[3]	= count_req_vec_nxt[3] -1'b1;
												2'd2 :	count_req_vec_nxt[0]	= count_req_vec_nxt[0] -1'b1;
												2'd3 :	count_req_vec_nxt[1]	= count_req_vec_nxt[1] -1'b1;
												default: begin end
												endcase
												
												case(grant_posn)			// decides next grant position
												2'd0 :	grant_posn_nxt	= 'd2;
												2'd1 :	grant_posn_nxt	= 'd3;
												2'd2 :	grant_posn_nxt	= 'd0;
												2'd3 :	grant_posn_nxt	= 'd1;
												default: begin end
												endcase
											end
										else
										if (relative_req_vec[2] & !relative_cntdone_vec[2])
											begin
												arbiter_state_nxt = END_ACCESS;			
												
												case(grant_posn)			// 
												2'd0 :	gnt_vec_nxt	= 4'b1000;
												2'd1 :	gnt_vec_nxt	= 4'b0001;
												2'd2 :	gnt_vec_nxt	= 4'b0010;
												2'd3 :	gnt_vec_nxt	= 4'b0100;
												default: begin end
												endcase
											
												case(grant_posn)			// reduces weight count by 1 when bus is granted + the values are rotated accordingly
												2'd0 :	count_req_vec_nxt[3]	= count_req_vec_nxt[3] -1'b1;
												2'd1 :	count_req_vec_nxt[0]	= count_req_vec_nxt[0] -1'b1;
												2'd2 :	count_req_vec_nxt[1]	= count_req_vec_nxt[1] -1'b1;
												2'd3 :	count_req_vec_nxt[2]	= count_req_vec_nxt[2] -1'b1;
												default: begin end
												endcase
												
												case(grant_posn)			// decides next grant position
												2'd0 :	grant_posn_nxt	= 'd3;
												2'd1 :	grant_posn_nxt	= 'd0;
												2'd2 :	grant_posn_nxt	= 'd1;
												2'd3 :	grant_posn_nxt	= 'd2;
												default: begin end
												endcase
											end
										else
										if (relative_req_vec[3] & !relative_cntdone_vec[3])
											begin
												arbiter_state_nxt = END_ACCESS;			
												
												case(grant_posn)			// 
												2'd0 :	gnt_vec_nxt	= 4'b0001;
												2'd1 :	gnt_vec_nxt	= 4'b0010;
												2'd2 :	gnt_vec_nxt	= 4'b0100;
												2'd3 :	gnt_vec_nxt	= 4'b1000;
												default: begin end
												endcase
											
												case(grant_posn)			// reduces weight count by 1 when bus is granted + the values are rotated accordingly
												2'd0 :	count_req_vec_nxt[0]	= count_req_vec_nxt[0] -1'b1;
												2'd1 :	count_req_vec_nxt[1]	= count_req_vec_nxt[1] -1'b1;
												2'd2 :	count_req_vec_nxt[2]	= count_req_vec_nxt[2] -1'b1;
												2'd3 :	count_req_vec_nxt[3]	= count_req_vec_nxt[3] -1'b1;
												default: begin end
												endcase
												
												case(grant_posn)			// decides next grant position
												2'd0 :	grant_posn_nxt	= 'd0;
												2'd1 :	grant_posn_nxt	= 'd1;
												2'd2 :	grant_posn_nxt	= 'd2;
												2'd3 :	grant_posn_nxt	= 'd3;
												default: begin end
												endcase
											end
										else
											begin
												gnt_vec_nxt	= 4'b0000;
												count_req_vec_nxt[0]	= req_vec_wt_stored[0];
												count_req_vec_nxt[1]	= req_vec_wt_stored[1];
												count_req_vec_nxt[2]	= req_vec_wt_stored[2];	
												count_req_vec_nxt[3]	= req_vec_wt_stored[3];
											end										
									end	
						end
				
				arbiter_state[END_ACCESS_ID] :
						begin
							if ((end_access_vec[0] & gnt_vec[0]) || 
								(end_access_vec[1] & gnt_vec[1]) || 
								(end_access_vec[2] & gnt_vec[2]) ||
								(end_access_vec[3] & gnt_vec[3])) 
								begin
									arbiter_state_nxt = ARM_VALUE;

										if (relative_req_vec[0] & !relative_cntdone_vec[0])
											begin
												arbiter_state_nxt = END_ACCESS;			
												
												case(grant_posn)			// 
												2'd0 :	gnt_vec_nxt	= 4'b0010;
												2'd1 :	gnt_vec_nxt	= 4'b0100;
												2'd2 :	gnt_vec_nxt	= 4'b1000;
												2'd3 :	gnt_vec_nxt	= 4'b0001;
												default: begin end
												endcase
											
												case(grant_posn)			// reduces weight count by 1 when bus is granted + the values are rotated accordingly
												2'd0 :	count_req_vec_nxt[1]	= count_req_vec_nxt[1] -1'b1;
												2'd1 :	count_req_vec_nxt[2]	= count_req_vec_nxt[2] -1'b1;
												2'd2 :	count_req_vec_nxt[3]	= count_req_vec_nxt[3] -1'b1;
												2'd3 :	count_req_vec_nxt[0]	= count_req_vec_nxt[0] -1'b1;
												default: begin end
												endcase
												
												case(grant_posn)			// decides next grant position
												2'd0 :	grant_posn_nxt	= 'd1;
												2'd1 :	grant_posn_nxt	= 'd2;
												2'd2 :	grant_posn_nxt	= 'd3;
												2'd3 :	grant_posn_nxt	= 'd0;
												default: begin end
												endcase
											end
									else
										if (relative_req_vec[1] & !relative_cntdone_vec[1])
											begin
												arbiter_state_nxt = END_ACCESS;			
												
												case(grant_posn)			// 
												2'd0 :	gnt_vec_nxt	= 4'b0100;
												2'd1 :	gnt_vec_nxt	= 4'b1000;
												2'd2 :	gnt_vec_nxt	= 4'b0001;
												2'd3 :	gnt_vec_nxt	= 4'b0010;
												default: begin end
												endcase
											
												case(grant_posn)			// reduces weight count by 1 when bus is granted + the values are rotated accordingly
												2'd0 :	count_req_vec_nxt[2]	= count_req_vec_nxt[2] -1'b1;
												2'd1 :	count_req_vec_nxt[3]	= count_req_vec_nxt[3] -1'b1;
												2'd2 :	count_req_vec_nxt[0]	= count_req_vec_nxt[0] -1'b1;
												2'd3 :	count_req_vec_nxt[1]	= count_req_vec_nxt[1] -1'b1;
												default: begin end
												endcase
												
												case(grant_posn)			// decides next grant position
												2'd0 :	grant_posn_nxt	= 'd2;
												2'd1 :	grant_posn_nxt	= 'd3;
												2'd2 :	grant_posn_nxt	= 'd0;
												2'd3 :	grant_posn_nxt	= 'd1;
												default: begin end
												endcase
											end
									else
										if (relative_req_vec[2] & !relative_cntdone_vec[2])
											begin
												arbiter_state_nxt = END_ACCESS;			
												
												case(grant_posn)			// 
												2'd0 :	gnt_vec_nxt	= 4'b1000;
												2'd1 :	gnt_vec_nxt	= 4'b0001;
												2'd2 :	gnt_vec_nxt	= 4'b0010;
												2'd3 :	gnt_vec_nxt	= 4'b0100;
												default: begin end
												endcase
											
												case(grant_posn)			// reduces weight count by 1 when bus is granted + the values are rotated accordingly
												2'd0 :	count_req_vec_nxt[3]	= count_req_vec_nxt[3] -1'b1;
												2'd1 :	count_req_vec_nxt[0]	= count_req_vec_nxt[0] -1'b1;
												2'd2 :	count_req_vec_nxt[1]	= count_req_vec_nxt[1] -1'b1;
												2'd3 :	count_req_vec_nxt[2]	= count_req_vec_nxt[2] -1'b1;
												default: begin end
												endcase
												
												case(grant_posn)			// decides next grant position
												2'd0 :	grant_posn_nxt	= 'd3;
												2'd1 :	grant_posn_nxt	= 'd0;
												2'd2 :	grant_posn_nxt	= 'd1;
												2'd3 :	grant_posn_nxt	= 'd2;
												default: begin end
												endcase
											end
									else
										if (relative_req_vec[3] & !relative_cntdone_vec[3])
											begin
												arbiter_state_nxt = END_ACCESS;			
												
												case(grant_posn)			// 
												2'd0 :	gnt_vec_nxt	= 4'b0001;
												2'd1 :	gnt_vec_nxt	= 4'b0010;
												2'd2 :	gnt_vec_nxt	= 4'b0100;
												2'd3 :	gnt_vec_nxt	= 4'b1000;
												default: begin end
												endcase
											
												case(grant_posn)			// reduces weight count by 1 when bus is granted + the values are rotated accordingly
												2'd0 :	count_req_vec_nxt[0]	= count_req_vec_nxt[0] -1'b1;
												2'd1 :	count_req_vec_nxt[1]	= count_req_vec_nxt[1] -1'b1;
												2'd2 :	count_req_vec_nxt[2]	= count_req_vec_nxt[2] -1'b1;
												2'd3 :	count_req_vec_nxt[3]	= count_req_vec_nxt[3] -1'b1;
												default: begin end
												endcase
												
												case(grant_posn)			// decides next grant position
												2'd0 :	grant_posn_nxt	= 'd0;
												2'd1 :	grant_posn_nxt	= 'd1;
												2'd2 :	grant_posn_nxt	= 'd2;
												2'd3 :	grant_posn_nxt	= 'd3;
												default: begin end
												endcase
											end											
										else
											begin
												gnt_vec_nxt	= 4'b0000;
												count_req_vec_nxt[0]	= req_vec_wt_stored[0];
												count_req_vec_nxt[1]	= req_vec_wt_stored[1];
												count_req_vec_nxt[2]	= req_vec_wt_stored[2];												
												count_req_vec_nxt[3]	= req_vec_wt_stored[3];
											end										
									end	
						end
			endcase
			
		end


assign cnt_reqdone_vec[0] = (count_req_vec[0] =='d0);
assign cnt_reqdone_vec[1] = (count_req_vec[1] =='d0);
assign cnt_reqdone_vec[2] = (count_req_vec[2] =='d0);
assign cnt_reqdone_vec[3] = (count_req_vec[3] =='d0);

always@(posedge clk or negedge resetb)
	begin
		if(!resetb)
			begin
				arbiter_state		<= IDLE;
				gnt_vec				<= 'd0;
				count_req_vec[0]	<= 'd0;
				count_req_vec[1]	<= 'd0;				
				count_req_vec[2]	<= 'd0;				
				count_req_vec[3]	<= 'd0;				
				
				req_vec_wt_stored[0] <= 'd0;
				req_vec_wt_stored[1] <= 'd0;
				req_vec_wt_stored[2] <= 'd0;
				req_vec_wt_stored[3] <= 'd0;				
				grant_posn			 <= 'd2;
			end
		else	
			begin
				arbiter_state		<= arbiter_state_nxt;				
				gnt_vec				<= gnt_vec_nxt;
				count_req_vec[0]	<= count_req_vec_nxt[0];
				count_req_vec[1]	<= count_req_vec_nxt[1];
				count_req_vec[2]	<= count_req_vec_nxt[2];
				count_req_vec[3]	<= count_req_vec_nxt[3];
				
				req_vec_wt_stored[0] <= req_vec_wt_stored[0];
				req_vec_wt_stored[1] <= req_vec_wt_stored[1];
				req_vec_wt_stored[2] <= req_vec_wt_stored[2];
				req_vec_wt_stored[3] <= req_vec_wt_stored[3];						
				grant_posn			 <= grant_posn_nxt;
			end
	end
endmodule