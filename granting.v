// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
// granting.v

module granting (
                    input  clk,rst,
                    input  [3:0] bid_0,
                    input  [3:0] bid_1,
                    input  [3:0] bid_2,
                    input  [3:0] bid_3,
                    
                    output [3:0] grant
                );

parameter Mast0 = 4'b0001;
parameter Mast1 = 4'b0010;
parameter Mast2 = 4'b0100;
parameter Mast3 = 4'b1000;

				
wire [9:0] balance [3:0];
reg  [3:0] result;
wire [3:0] bid [3:0];
reg  [3:0] valid_balance;

reg  [3:0] highest_bid;
wire highest_bid_bit;

reg  [3:0] equal_bid;
wire equal_bid_bit;

reg  [3:0] last_serviced;

reg  [5:0] count_60 [3:0];

reg  [3:0] serve_60 ;
wire serve_60_bit ;



assign grant  = result;				// final 
//assign result = highest_bid;		// temporary 

assign bid[0] = bid_0;
assign bid[1] = bid_1;
assign bid[2] = bid_2;
assign bid[3] = bid_3;

assign highest_bid_bit  	= ( highest_bid == Mast0 | highest_bid == Mast1 | highest_bid == Mast2 | highest_bid == Mast3 ) ? 'b1 : 'b0 ;			// 	ensure only 1 highest bid exists 
assign equal_bid_bit   	= ( equal_bid[0] 	| equal_bid[1] 			| equal_bid[2] 			| equal_bid[3]   );			// 	equal_bid_bit   	= 1 if multiple equal bid exists
assign serve_60_bit  	= ( serve_60 == Mast0 | serve_60 == Mast1 | serve_60 == Mast2 | serve_60 == Mast3 ) ? 'b1 : 'b0 ;	// 	serve_60_bit   		= 1 if no service for 60 cycles  for EITHER ONE MASTER , CANNOT HANDLE 1+ MASTER   IT GETS COMPLICATED 


// ################################################# 
always@(*) 
    begin
        if (rst)
            begin
				result <= 'b0;
			end
		else
			begin
				if (serve_60_bit) 							
						casez (serve_60)
							Mast0 	: result <= Mast0;
							Mast1 	: result <= Mast1;
							Mast2 	: result <= Mast2;
							Mast3 	: result <= Mast3;
							default	: result <= 'b0;	// FAULTY CASE will NOT allow ANY master grant 
						endcase
				else
					begin
							
									 if ( (valid_balance[0] == 1)  && (highest_bid == Mast0) ) result <= Mast0 ;	// If Master0 has valid balance and highest bid , grant bus to Master0
								else if ( (valid_balance[1] == 1)  && (highest_bid == Mast1) ) result <= Mast1 ;	// If Master1 has valid balance and highest bid , grant bus to Master1
								else if ( (valid_balance[2] == 1)  && (highest_bid == Mast2) ) result <= Mast2 ;	// If Master2 has valid balance and highest bid , grant bus to Master2
								else if ( (valid_balance[3] == 1)  && (highest_bid == Mast3) ) result <= Mast3 ;	// If Master3 has valid balance and highest bid , grant bus to Master3
								else 	
									begin
										if (equal_bid_bit)
														casez(last_serviced)
																Mast0 	: 	casez( {equal_bid[3]&valid_balance[3], equal_bid[2]&valid_balance[2], equal_bid[1]&valid_balance[1], equal_bid[0]&valid_balance[0]} )		// 3 2 1 0 										
																					4'b0011	:	result <= Mast1 ;  
																					4'b0101	:	result <= Mast2 ;
																					4'b0111	:	result <= Mast1 ;
																					4'b1001	:	result <= Mast3 ;
																					4'b1011	:	result <= Mast1 ;
																					4'b1101	:	result <= Mast2 ;
																					4'b1111	:	result <= Mast3 ;
																					4'b???0	:	result <= Mast1 ;	 // if no valid balance exists for Mast0 , Mast1 will be granted access  NOTE : WILL go in loop if all Masters finish valid balance   
																					default	: 	result <= 'b1;		// ERROR CASE 
																			endcase
																			
																Mast1 	: 	casez( {equal_bid[0]&valid_balance[0], equal_bid[3]&valid_balance[3], equal_bid[2]&valid_balance[2], equal_bid[1]&valid_balance[1]} )		// 0 3 2 1 	
																					4'b0011	:	result <= Mast1 ;  
																					4'b0101	:	result <= Mast2 ;
																					4'b0111	:	result <= Mast1 ;
																					4'b1001	:	result <= Mast3 ;
																					4'b1011	:	result <= Mast1 ;
																					4'b1101	:	result <= Mast2 ;
																					4'b1111	:	result <= Mast3 ;			
																					4'b???0	:	result <= Mast0 ;	 // if no valid balance exists for Mast1 , Mast0 will be granted access  NOTE : WILL go in loop if all Masters finish valid balance   																					
																					default	: 	result <= 'b1;		// ERROR CASE 
																			endcase

																Mast2 	: 	casez( {equal_bid[1]&valid_balance[1], equal_bid[0]&valid_balance[0], equal_bid[3]&valid_balance[3], equal_bid[2]&valid_balance[2]} )		// 1 0 3 2 
																					4'b0011	:	result <= Mast1 ;  
																					4'b0101	:	result <= Mast2 ;
																					4'b0111	:	result <= Mast1 ;
																					4'b1001	:	result <= Mast3 ;
																					4'b1011	:	result <= Mast1 ;
																					4'b1101	:	result <= Mast2 ;
																					4'b1111	:	result <= Mast3 ;
																					4'b???0	:	result <= Mast0 ;	 // if no valid balance exists for Mast1 , Mast0 will be granted access  NOTE : WILL go in loop if all Masters finish valid balance   																																										
																					default	: 	result <= 'b1;		// ERROR CASE 
																			endcase
																			
																Mast3 	: 	casez( {equal_bid[2]&valid_balance[2], equal_bid[0]&valid_balance[0], equal_bid[1]&valid_balance[1], equal_bid[3]&valid_balance[3]} )		// 2 0 1 3 										
																					4'b0011	:	result <= Mast1 ;  
																					4'b0101	:	result <= Mast2 ;
																					4'b0111	:	result <= Mast1 ;
																					4'b1001	:	result <= Mast3 ;
																					4'b1011	:	result <= Mast1 ;
																					4'b1101	:	result <= Mast2 ;
																					4'b1111	:	result <= Mast3 ;																
																					4'b???0	:	result <= Mast0 ;	 // if no valid balance exists for Mast1 , Mast0 will be granted access  NOTE : WILL go in loop if all Masters finish valid balance   																																										
																					default	: 	result <= 'b1;		// ERROR CASE 
																			endcase
																default : result <= 'b1;		// ERROR CASE 
														endcase
										else
														begin
																 if ( (balance[0] == 1)  && (highest_bid == Mast0) ) result <= Mast0 ;	// If Master0 has  balance = 1  and highest bid , grant bus to Master0
															else if ( (balance[1] == 1)  && (highest_bid == Mast1) ) result <= Mast1 ;	// If Master1 has  balance = 1  and highest bid , grant bus to Master1
															else if ( (balance[2] == 1)  && (highest_bid == Mast2) ) result <= Mast2 ;	// If Master2 has  balance = 1  and highest bid , grant bus to Master2
															else if ( (balance[3] == 1)  && (highest_bid == Mast3) ) result <= Mast3 ;	// If Master3 has  balance = 1  and highest bid , grant bus to Master3
															else 	result <=  'b1;
														end
										end
					end										
			end
	end
					
// #################################################		
always@(*) 
    begin
        if (rst)
            begin
                highest_bid <= 'b0;
				equal_bid	<= 'b0;
				valid_balance	<= 'b0;
            end
        else
            begin                
                    if ((bid[0] == 0) &&  (bid[1] == 0) && (bid[2] == 0) && (bid[3] == 0))  begin highest_bid <= 'b0; 	equal_bid	<= 'b0;     end
                    else
                        begin
                            if     ((bid[0] > bid[1]) && (bid[0] > bid[2]) && (bid[0] > bid[3])  )      highest_bid[0] <= 'b1;    else	highest_bid[0] <= 'b0;  
                            if     ((bid[1] > bid[0]) && (bid[1] > bid[2]) && (bid[1] > bid[3])  )      highest_bid[1] <= 'b1;    else	highest_bid[1] <= 'b0;  	
                            if     ((bid[2] > bid[0]) && (bid[2] > bid[1]) && (bid[2] > bid[3])  )      highest_bid[2] <= 'b1;    else	highest_bid[2] <= 'b0;    
                            if     ((bid[3] > bid[0]) && (bid[3] > bid[1]) && (bid[3] > bid[2])  )      highest_bid[3] <= 'b1;    else	highest_bid[3] <= 'b0;  
							
                            if     ((bid[0] == bid[1]) | (bid[0] == bid[2]) | (bid[0] == bid[3])  )     equal_bid[0] <= 'b1;    else	equal_bid[0] <= 'b0;  
                            if     ((bid[1] == bid[0]) | (bid[1] == bid[2]) | (bid[1] == bid[3])  )     equal_bid[1] <= 'b1;    else	equal_bid[1] <= 'b0;  
                            if     ((bid[2] == bid[0]) | (bid[2] == bid[1]) | (bid[2] == bid[3])  )     equal_bid[2] <= 'b1;    else	equal_bid[2] <= 'b0;  
                            if     ((bid[3] == bid[0]) | (bid[3] == bid[1]) | (bid[3] == bid[2])  )     equal_bid[3] <= 'b1;    else	equal_bid[3] <= 'b0;  
							
							if 		(balance[0] > bid[0])  valid_balance[0] <= 'b1; else  valid_balance[0] <= 'b0;
							if 		(balance[1] > bid[1])  valid_balance[1] <= 'b1; else  valid_balance[1] <= 'b0;
							if 		(balance[2] > bid[2])  valid_balance[2] <= 'b1; else  valid_balance[2] <= 'b0;
							if 		(balance[3] > bid[3])  valid_balance[3] <= 'b1; else  valid_balance[3] <= 'b0;
														
                        end
            end

    end
	
// #################################################
always@(posedge clk or posedge rst)
	begin
		if (rst)
			begin
				count_60[0] <= 'b0;	
				count_60[1] <= 'b0;	
				count_60[2] <= 'b0;	
				count_60[3] <= 'b0;	
				serve_60	<= 'b0;
				last_serviced	<= 'b0;
			end
		else
			begin
					last_serviced <= result;										// flopping to store which master was last serviced 
					
					count_60[0] <= ((result[0]) | (bid[0] == 'b0) ) ? 'b0 : (count_60[0] +1);			// start counter to avoid 60 cycle no service error , start it even if no bid by master 
					count_60[1] <= ((result[1]) | (bid[1] == 'b0) ) ? 'b0 : (count_60[1] +1);		
					count_60[2] <= ((result[2]) | (bid[2] == 'b0) ) ? 'b0 : (count_60[2] +1);		
					count_60[3] <= ((result[3]) | (bid[3] == 'b0) ) ? 'b0 : (count_60[3] +1);						
					
					serve_60[0] <= (count_60[0] == 6'd60) ? 'b1 : 'b0; 				// Flag to indicate which master to serve to avoid 60 cycle no service error 
					serve_60[1] <= (count_60[1] == 6'd60) ? 'b1 : 'b0; 					
					serve_60[2] <= (count_60[2] == 6'd60) ? 'b1 : 'b0; 									
					serve_60[3] <= (count_60[3] == 6'd60) ? 'b1 : 'b0; 														
			end
	end	
// #################################################	
	
	
	
count M0 (     clk, rst,    bid[0],    grant[0], balance[0]); 
count M1 (     clk, rst,    bid[1],    grant[1], balance[1]); 
count M2 (     clk, rst,    bid[2],    grant[2], balance[2]); 
count M3 (     clk, rst,    bid[3],    grant[3], balance[3]); 

    
endmodule


// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
// count.v

module count (     input clk, rst,
                input [3:0] bid,
                input granted,
                output reg [9:0] balance
            );
                
reg [9:0] counter; 

always@(negedge clk, posedge rst)
    begin    
        if (rst)
            begin
                balance = 750;  
                counter <= 'b0;                
            end
        else
            begin
                counter <= (counter == 400) ? 'b0 : (counter +1);           // free running counter resets automatically  every 400 counts  
                
                if (counter == 400)            balance = (balance > 150) ? 900 : (balance + 750);       // Adds previous balance & takes care of limits 
                else
                    if (granted)    if (balance <= 0)    balance = 1; else balance = (balance == 1)? 1: (((balance - bid) == 0) ?  1 : (balance - bid));      // reduces bid amount to maintain bank balance 
                    else            balance = balance;          
            end
    end

endmodule
