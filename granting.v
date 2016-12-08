// granting.v
module granting (
					input  clk,rst,
					input  [3:0] bid_0,
					input  [3:0] bid_1,
					input  [3:0] bid_2,
					input  [3:0] bid_3,
					
					output [3:0] grant
				);

reg  [3:0] tracking_1 ;
reg  [3:0] tracking_2 ; 

wire [9:0] balance [3:0];
wire [3:0] bid [3:0];
wire [3:0] master_grant;



assign master_grant = tracking_1;
assign grant = tracking_1;

assign bid[0] = bid_0;
assign bid[1] = bid_1;
assign bid[2] = bid_2;
assign bid[3] = bid_3;

always@(*) 
	begin
		if (rst)
			begin
				tracking_1 	 <= 'b0;				
			end
		else
			begin				
/*				casez(tracking_2)
					4'b???0 : begin if	 ((bid[0] >= bid[1]) && (bid[0] >= bid[2]) && (bid[0] >= bid[3])  && (balance[0] >= bid[0]) && (balance[0] !== 4'd1))   tracking_1 <= 4'b0001;	end
					4'b??0? : begin if	 ((bid[1] >= bid[0]) && (bid[1] >= bid[2]) && (bid[1] >= bid[3])  && (balance[1] >= bid[1]) && (balance[1] !== 4'd1))  	tracking_1 <= 4'b0010;  end
					4'b?0?? : begin if	 ((bid[2] >= bid[0]) && (bid[2] >= bid[1]) && (bid[2] >= bid[3])  && (balance[2] >= bid[2]) && (balance[2] !== 4'd1))  	tracking_1 <= 4'b0100;	end			
					4'b0??? : begin if	 ((bid[3] >= bid[0]) && (bid[3] >= bid[1]) && (bid[3] >= bid[2])  && (balance[3] >= bid[3]) && (balance[4] !== 4'd1))  	tracking_1 <= 4'b1000;  end
					default : begin tracking_1 <= 4'b0000; end
				endcase
*/
						 if ((tracking_2[0] == 0) && (balance[0] !== 10'd1))  begin if	 ((bid[0] >= bid[1]) && (bid[0] >= bid[2]) && (bid[0] >= bid[3])  && (balance[0] >= bid[0]))    tracking_1 <= 4'b0001;	end
					else if ((tracking_2[1] == 0) && (balance[1] !== 10'd1))  begin if	 ((bid[1] >= bid[0]) && (bid[1] >= bid[2]) && (bid[1] >= bid[3])  && (balance[1] >= bid[1]))  	tracking_1 <= 4'b0010;  end
					else if ((tracking_2[2] == 0) && (balance[2] !== 10'd1))  begin if	 ((bid[2] >= bid[0]) && (bid[2] >= bid[1]) && (bid[2] >= bid[3])  && (balance[2] >= bid[2]))  	tracking_1 <= 4'b0100;	end			
					else if ((tracking_2[3] == 0) && (balance[3] !== 10'd1))  begin if	 ((bid[3] >= bid[0]) && (bid[3] >= bid[1]) && (bid[3] >= bid[2])  && (balance[3] >= bid[3]))  	tracking_1 <= 4'b1000;  end
					else 						  begin 	   tracking_1 <= 4'b0000; end
				

			end

	end

always@(posedge clk or posedge rst)
	begin
		if (rst)	tracking_2 	 <= 'b0;
		else		tracking_2 <= tracking_1;
	end
	
count M0 ( 	clk, rst,	bid[0],	master_grant[0], balance[0]); 
count M1 ( 	clk, rst,	bid[1],	master_grant[1], balance[1]); 
count M2 ( 	clk, rst,	bid[2],	master_grant[2], balance[2]); 
count M3 ( 	clk, rst,	bid[3],	master_grant[3], balance[3]); 

	
endmodule