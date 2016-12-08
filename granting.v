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

wire [9:0] balance [3:0];
wire [3:0] result;
wire [3:0] bid [3:0];
reg  [3:0] highest_bid;
reg  [3:0] equal_bid;
reg  [3:0] last_serviced;
reg  [5:0] count_60 [3:0];
reg  [3:0] serve_60 ;



assign grant  = result;				// final 
assign result = highest_bid;		// temporary 

assign bid[0] = bid_0;
assign bid[1] = bid_1;
assign bid[2] = bid_2;
assign bid[3] = bid_3;

always@(*) 
    begin
        if (rst)
            begin
                highest_bid <= 'b0;
				equal_bid	<= 'b0;
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
							
                        end
            end

    end

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
					last_serviced <= result;
					
					count_60[0] <= (result[0]) ? 'b0 : (count_60[0] +1);			// start counter to avoid 60 cycle error after service stopped 
					count_60[1] <= (result[1]) ? 'b0 : (count_60[1] +1);		
					count_60[2] <= (result[2]) ? 'b0 : (count_60[2] +1);		
					count_60[3] <= (result[3]) ? 'b0 : (count_60[3] +1);						
					
					serve_60[0] <= (count_60[0] == 5'd60) ? 'b1 : 'b0; 				// Flag to indicate which master to serve for 60 cycle error 
					serve_60[1] <= (count_60[1] == 5'd60) ? 'b1 : 'b0; 					
					serve_60[2] <= (count_60[2] == 5'd60) ? 'b1 : 'b0; 									
					serve_60[3] <= (count_60[3] == 5'd60) ? 'b1 : 'b0; 														
			end
	end	
	
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
