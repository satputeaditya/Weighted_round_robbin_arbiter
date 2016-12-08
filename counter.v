// counter.v

module count ( 	input clk, rst,
				input [3:0] bid,
				input granted,
				output reg [9:0] balance
			);
				
reg [9:0] bank;
reg [9:0] temp;		// debug purposes
reg [9:0] counter; 
wire grant_gated;

assign #5 grant_gated =  (granted & clk);  

always@(*)
	begin	
		if (rst)
			begin
				balance = 750;
				bank	= 750;
				temp 	= 0;		// debug purposes
			end
		else
			if (counter == 400)
				begin					 
					 temp = balance;	// debug purposes
					 if (balance > 150)	balance = 900;
					 else balance = (balance + 750);					 
					 
				end
			else
				if (grant_gated)	begin bank = balance; if (balance <= 0)	balance = 1; else balance = (balance == 1)? 1: (((balance - bid) == 0) ?  1 : (balance - bid));  	end
				else			begin balance = balance;  		 	bank= balance;  end
		end

always@(posedge clk, posedge rst)
	begin
		if (rst)	counter <= 'b0;
		else		counter <= (counter == 400) ? 'b0 : (counter +1);							
	end
endmodule