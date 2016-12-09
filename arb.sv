// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
// arb.sv

module arb (
            bmif.mstrR m0, 
            bmif.mstrR m1, 
            bmif.mstrR m2, 
            bmif.mstrR m3, 
            svif.slvR s0, 
            svif.slvR s1, 
            svif.slvR s2, 
            svif.slvR s3, 
            
            input integer amt, 
            input integer max_clk, 
            input integer max_amt
            );

logic [3:0] master_grant; 
logic [9:0] balance [3:0];
logic [3:0] bid [3:0];

assign {m3.grant, m2.grant, m1.grant, m0.grant}  = master_grant;
assign {bid[3]  , bid[2]  , bid[1]  , bid[0]  }  = {m3.req, m2.req, m1.req, m0.req};


always@(*)          // ADDRESS DECODING & CONNECTIONS 
        begin
            casez (master_grant)
                4'b0001    :     begin
                                case (m0.addr[15:12])
                                        4'h0    :     begin s0.RW    =  m0.RW;    s0.addr = m0.addr;    s0.DataToSlave     =  m0.DataToSlave; m0.DataFromSlave =  s0.DataFromSlave;     s0.sel    = 'b1;    s1.sel    = 'b0;    s2.sel    = 'b0;    s3.sel    = 'b0;    end                
                                        4'h1    :     begin s1.RW    =  m0.RW;    s1.addr = m0.addr;    s1.DataToSlave     =  m0.DataToSlave; m0.DataFromSlave =  s1.DataFromSlave;     s0.sel    = 'b0;    s1.sel    = 'b1;    s2.sel    = 'b0;    s3.sel    = 'b0;    end            
                                        4'h2    :     begin s2.RW    =  m0.RW;    s2.addr = m0.addr;    s2.DataToSlave     =  m0.DataToSlave; m0.DataFromSlave =  s2.DataFromSlave;     s0.sel    = 'b0;    s1.sel    = 'b0;    s2.sel    = 'b1;    s3.sel    = 'b0;    end            
                                        4'h3    :     begin s3.RW    =  m0.RW;    s3.addr = m0.addr;    s3.DataToSlave     =  m0.DataToSlave; m0.DataFromSlave =  s3.DataFromSlave;     s0.sel    = 'b0;    s1.sel    = 'b0;    s2.sel    = 'b0;    s3.sel    = 'b1;    end            
                                        default    :      begin s0.sel = 'b0;        s1.sel  = 'b0;        s2.sel = 'b0;        s3.sel = 'b0;  end                            
                                endcase
                            end
                4'b0010    :     begin
                                case (m1.addr)
                                        4'h0    :     begin s0.RW    =  m1.RW;    s0.addr = m1.addr;    s0.DataToSlave     =  m1.DataToSlave; m1.DataFromSlave =  s0.DataFromSlave;     s0.sel    = 'b1;    s1.sel    = 'b0;    s2.sel    = 'b0;    s3.sel    = 'b0;    end                4'h1    :     begin s1.RW    =  m1.RW;    s1.addr = m1.addr;    s1.DataToSlave     =  m1.DataToSlave; m1.DataFromSlave =  s1.DataFromSlave;     s0.sel    = 'b0;    s1.sel    = 'b1;    s2.sel    = 'b0;    s3.sel    = 'b0;    end                4'h2    :     begin s2.RW    =  m1.RW;    s2.addr = m1.addr;    s2.DataToSlave     =  m1.DataToSlave; m1.DataFromSlave =  s2.DataFromSlave;     s0.sel    = 'b0;    s1.sel    = 'b0;    s2.sel    = 'b1;    s3.sel    = 'b0;    end                4'h3    :     begin s3.RW    =  m1.RW;    s3.addr = m1.addr;    s3.DataToSlave     =  m1.DataToSlave; m1.DataFromSlave =  s3.DataFromSlave;     s0.sel    = 'b0;    s1.sel    = 'b0;    s2.sel    = 'b0;    s3.sel    = 'b1;    end                default    :      begin s0.sel = 'b0;        s1.sel  = 'b0;        s2.sel = 'b0;        s3.sel = 'b0;    end                                    
                                endcase
                            end
                4'b0100    :     begin
                                case (m2.addr)
                                        4'h0    :     begin s0.RW    =  m2.RW;    s0.addr = m2.addr;    s0.DataToSlave     =  m2.DataToSlave; m2.DataFromSlave =  s0.DataFromSlave;     s0.sel    = 'b1;    s1.sel    = 'b0;    s2.sel    = 'b0;    s3.sel    = 'b0;    end    
                                        4'h1    :     begin s1.RW    =  m2.RW;    s1.addr = m2.addr;    s1.DataToSlave     =  m2.DataToSlave; m2.DataFromSlave =  s1.DataFromSlave;     s0.sel    = 'b0;    s1.sel    = 'b1;    s2.sel    = 'b0;    s3.sel    = 'b0;    end    
                                        4'h2    :     begin s2.RW    =  m2.RW;    s2.addr = m2.addr;    s2.DataToSlave     =  m2.DataToSlave; m2.DataFromSlave =  s2.DataFromSlave;     s0.sel    = 'b0;    s1.sel    = 'b0;    s2.sel    = 'b1;    s3.sel    = 'b0;    end    
                                        4'h3    :     begin s3.RW    =  m2.RW;    s3.addr = m2.addr;    s3.DataToSlave     =  m2.DataToSlave; m2.DataFromSlave =  s3.DataFromSlave;     s0.sel    = 'b0;    s1.sel    = 'b0;    s2.sel    = 'b0;    s3.sel    = 'b1;    end    
                                        default    :      begin s0.sel = 'b0;        s1.sel  = 'b0;        s2.sel = 'b0;        s3.sel = 'b0;    end                                    
                                endcase                
                            end
                4'b1000    :     begin
                                case (m3.addr)
                                        4'h0    :     begin s0.RW    =  m3.RW;    s0.addr = m3.addr;    s0.DataToSlave     =  m3.DataToSlave; m3.DataFromSlave =  s0.DataFromSlave;     s0.sel    = 'b1;    s1.sel    = 'b0;    s2.sel    = 'b0;    s3.sel    = 'b0;    end
                                        4'h1    :     begin s1.RW    =  m3.RW;    s1.addr = m3.addr;    s1.DataToSlave     =  m3.DataToSlave; m3.DataFromSlave =  s1.DataFromSlave;     s0.sel    = 'b0;    s1.sel    = 'b1;    s2.sel    = 'b0;    s3.sel    = 'b0;    end
                                        4'h2    :     begin s2.RW    =  m3.RW;    s2.addr = m3.addr;    s2.DataToSlave     =  m3.DataToSlave; m3.DataFromSlave =  s2.DataFromSlave;     s0.sel    = 'b0;    s1.sel    = 'b0;    s2.sel    = 'b1;    s3.sel    = 'b0;    end        
                                        4'h3    :     begin s3.RW    =  m3.RW;    s3.addr = m3.addr;    s3.DataToSlave     =  m3.DataToSlave; m3.DataFromSlave =  s3.DataFromSlave;     s0.sel    = 'b0;    s1.sel    = 'b0;    s2.sel    = 'b0;    s3.sel    = 'b1;    end        
                                        default    :      begin s0.sel = 'b0;        s1.sel  = 'b0;        s2.sel = 'b0;        s3.sel = 'b0;    end
                                endcase                
                            end
                default    :                              begin s0.sel = 'b0;        s1.sel  = 'b0;        s2.sel = 'b0;        s3.sel = 'b0;  end
            endcase
        end
        
        

granting G1 ( m0.clk, m0.rst, bid[0], bid[1], bid[2], bid[3], master_grant);

endmodule



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
reg  [3:0] bid_reg [3:0];

reg  [3:0] bid_reg_0;
reg  [3:0] bid_reg_1;
reg  [3:0] bid_reg_2;
reg  [3:0] bid_reg_3;



reg  [3:0] valid_balance;

reg  [3:0] highest_bid;
reg  [3:0] highest_bid_en;
wire highest_bid_bit;

reg  [3:0] equal_bid;
wire equal_bid_bit;

reg  [3:0] last_serviced;

reg  [5:0] count_60 [3:0];

reg  [3:0] serve_60 ;
wire serve_60_bit ;



assign grant  = result;                // final 

assign bid[0] = bid_0;
assign bid[1] = bid_1;
assign bid[2] = bid_2;
assign bid[3] = bid_3;

assign highest_bid_bit      = ( highest_bid == Mast0 	| highest_bid == Mast1  | highest_bid == Mast2 	| highest_bid == Mast3  ) ? 'b1 : 'b0 ;    	//     ensure only 1 highest bid exists 
assign serve_60_bit      	= ( serve_60 == Mast0 		| serve_60 == Mast1 	| serve_60 == Mast2 	| serve_60 == Mast3 	) ? 'b1 : 'b0 ;    	//     serve_60_bit      = 1 if no service for 60 cycles  for EITHER ONE MASTER , CANNOT HANDLE 1+ MASTER   IT GETS COMPLICATED 
assign equal_bid_bit       	= ( equal_bid[0]     		| equal_bid[1]          | equal_bid[2]          | equal_bid[3]   );            				//     equal_bid_bit    = 1 if multiple equal bid exists

// ################################################# 
always@(*) 
    begin
        if (rst)
            begin
                result <= 'b0;
            end
        else
            begin
                if ((bid[0] !== 0) |  (bid[1] !== 0) | (bid[2] !== 0) | (bid[3] !== 0))            
                    begin
                                if (serve_60_bit)                             
                                        casez (serve_60)
                                            Mast0     : result <= Mast0;
                                            Mast1     : result <= Mast1;
                                            Mast2     : result <= Mast2;
                                            Mast3     : result <= Mast3;
                                            default    : result <= 'b1;    // FAULTY CASE will NOT allow ANY master grant 
                                        endcase
                                else
                                    begin
                                            
                                                     if ( ( /* valid_balance[0] == 1)  && */ ( highest_bid == Mast0) ) result <= Mast0 ;    // If Master0 has valid balance and highest bid , grant bus to Master0
                                                else if ( ( /* valid_balance[1] == 1)  && */ ( highest_bid == Mast1) ) result <= Mast1 ;    // If Master1 has valid balance and highest bid , grant bus to Master1
                                                else if ( ( /* valid_balance[2] == 1)  && */ ( highest_bid == Mast2) ) result <= Mast2 ;    // If Master2 has valid balance and highest bid , grant bus to Master2
                                                else if ( ( /* valid_balance[3] == 1)  && */ ( highest_bid == Mast3) ) result <= Mast3 ;    // If Master3 has valid balance and highest bid , grant bus to Master3
                                                else     
                                                    begin
                                                        if (equal_bid_bit)
                                                                        casez(last_serviced)
                                                                                Mast0     :     casez( {equal_bid[3]&valid_balance[3], equal_bid[2]&valid_balance[2], equal_bid[1]&valid_balance[1], equal_bid[0]&valid_balance[0]} )        // 3 2 1 0                                         
                                                                                                    4'b0011    :    result <= Mast1 ;  
                                                                                                    4'b0101    :    result <= Mast2 ;
                                                                                                    4'b0111    :    result <= Mast1 ;
                                                                                                    4'b1001    :    result <= Mast3 ;
                                                                                                    4'b1011    :    result <= Mast1 ;
                                                                                                    4'b1101    :    result <= Mast2 ;
                                                                                                    4'b1111    :    result <= Mast3 ;
                                                                                                    4'b???0    :    result <= Mast1 ;    // if no valid balance exists for Mast0 , Mast1 will be granted access  NOTE : WILL go in loop if all Masters finish valid balance   
                                                                                                    default    :     result <= 'b1;        // ERROR CASE 
                                                                                            endcase
                                                                                            
                                                                                Mast1     :     casez( {equal_bid[0]&valid_balance[0], equal_bid[3]&valid_balance[3], equal_bid[2]&valid_balance[2], equal_bid[1]&valid_balance[1]} )        // 0 3 2 1     
                                                                                                    4'b0011    :    result <= Mast1 ;  
                                                                                                    4'b0101    :    result <= Mast2 ;
                                                                                                    4'b0111    :    result <= Mast1 ;
                                                                                                    4'b1001    :    result <= Mast3 ;
                                                                                                    4'b1011    :    result <= Mast1 ;
                                                                                                    4'b1101    :    result <= Mast2 ;
                                                                                                    4'b1111    :    result <= Mast3 ;            
                                                                                                    4'b???0    :    result <= Mast0 ;    // if no valid balance exists for Mast1 , Mast0 will be granted access  NOTE : WILL go in loop if all Masters finish valid balance                                                                                       
                                                                                                    default    :     result <= 'b1;        // ERROR CASE 
                                                                                            endcase

                                                                                Mast2     :     casez( {equal_bid[1]&valid_balance[1], equal_bid[0]&valid_balance[0], equal_bid[3]&valid_balance[3], equal_bid[2]&valid_balance[2]} )        // 1 0 3 2 
                                                                                                    4'b0011    :    result <= Mast1 ;  
                                                                                                    4'b0101    :    result <= Mast2 ;
                                                                                                    4'b0111    :    result <= Mast1 ;
                                                                                                    4'b1001    :    result <= Mast3 ;
                                                                                                    4'b1011    :    result <= Mast1 ;
                                                                                                    4'b1101    :    result <= Mast2 ;
                                                                                                    4'b1111    :    result <= Mast3 ;
                                                                                                    4'b???0    :    result <= Mast0 ;    // if no valid balance exists for Mast1 , Mast0 will be granted access  NOTE : WILL go in loop if all Masters finish valid balance                                                                                                                                                                           
                                                                                                    default    :     result <= 'b1;        // ERROR CASE 
                                                                                            endcase
                                                                                            
                                                                                Mast3     :     casez( {equal_bid[2]&valid_balance[2], equal_bid[0]&valid_balance[0], equal_bid[1]&valid_balance[1], equal_bid[3]&valid_balance[3]} )        // 2 0 1 3                                         
                                                                                                    4'b0011    :    result <= Mast1 ;  
                                                                                                    4'b0101    :    result <= Mast2 ;
                                                                                                    4'b0111    :    result <= Mast1 ;
                                                                                                    4'b1001    :    result <= Mast3 ;
                                                                                                    4'b1011    :    result <= Mast1 ;
                                                                                                    4'b1101    :    result <= Mast2 ;
                                                                                                    4'b1111    :    result <= Mast3 ;                                                                
                                                                                                    4'b???0    :    result <= Mast0 ;    // if no valid balance exists for Mast1 , Mast0 will be granted access  NOTE : WILL go in loop if all Masters finish valid balance                                                                                                                                                                           
                                                                                                    default    :     result <= 'b1;        // ERROR CASE 
                                                                                            endcase
                                                                                default : result <= 'b1;        // ERROR CASE 
                                                                        endcase
                                                        else
                                                                        begin
                                                                                if ( (balance[0] == 1)  && (highest_bid == Mast0) ) result <= Mast0 ;    // If Master0 has  balance = 1  and highest bid , grant bus to Master0
                                                                            else if ( (balance[1] == 1)  && (highest_bid == Mast1) ) result <= Mast1 ;    // If Master1 has  balance = 1  and highest bid , grant bus to Master1
                                                                            else if ( (balance[2] == 1)  && (highest_bid == Mast2) ) result <= Mast2 ;    // If Master2 has  balance = 1  and highest bid , grant bus to Master2
                                                                            else if ( (balance[3] == 1)  && (highest_bid == Mast3) ) result <= Mast3 ;    // If Master3 has  balance = 1  and highest bid , grant bus to Master3
                                                                            else     result <=  'b1;
                                                                        end
                                                        end
                                    end        
                    end
                else
                    result <= 'b0 ;
            end
    end
                    
// #################################################
always@(*) 
    begin
        if (rst)
            begin
                highest_bid 	= 'b0;
				highest_bid_en	= 'b0;
                equal_bid    	= 'b0;
                valid_balance   = 'b0;

				bid_reg_0		= 'b0;
				bid_reg_1		= 'b0;
				bid_reg_2		= 'b0;
				bid_reg_3		= 'b0;				
				
            end
        else
            begin      
						
						bid_reg_0 		= bid_0;		// copy bid values 
						bid_reg_1 		= bid_1;
						bid_reg_2 		= bid_2;
						bid_reg_3		= bid_3;			

						
						highest_bid_en[0] = (bid[0] == 0) ? 'b0 : (valid_balance[0]==0) ? 'b0 : 'b1; 	// Ensures bid is valid and is not 0  
						highest_bid_en[1] = (bid[1] == 0) ? 'b0 : (valid_balance[1]==0) ? 'b0 : 'b1;
						highest_bid_en[2] = (bid[2] == 0) ? 'b0 : (valid_balance[2]==0) ? 'b0 : 'b1;
						highest_bid_en[3] = (bid[3] == 0) ? 'b0 : (valid_balance[3]==0) ? 'b0 : 'b1;
						
						
//                                               if ((bid[0] > bid[1]) && (bid[0] > bid[2]) && (bid[0] > bid[3])  )      highest_bid[0] <= 'b1;    else    highest_bid[0] <= 'b0;
//                                               if ((bid[1] > bid[0]) && (bid[1] > bid[2]) && (bid[1] > bid[3])  )      highest_bid[1] <= 'b1;    else    highest_bid[1] <= 'b0;
//                                               if ((bid[2] > bid[0]) && (bid[2] > bid[1]) && (bid[2] > bid[3])  )      highest_bid[2] <= 'b1;    else    highest_bid[2] <= 'b0;
//                                               if ((bid[3] > bid[0]) && (bid[3] > bid[1]) && (bid[3] > bid[2])  )      highest_bid[3] <= 'b1;    else    highest_bid[3] <= 'b0;

							bid_reg_0  = (valid_balance[0]) ? bid[0] : 'b0 ;		//  replaces bid value with 0 if balance does not exist 
							bid_reg_1  = (valid_balance[1]) ? bid[1] : 'b0 ;
							bid_reg_2  = (valid_balance[2]) ? bid[2] : 'b0 ;
							bid_reg_3  = (valid_balance[3]) ? bid[3] : 'b0 ;
							
                                
                        
                            if(highest_bid_en[0]) if     ((bid_reg_0  > bid_reg_1 ) && (bid_reg_0  > bid_reg_2 ) && (bid_reg_0  > bid_reg_3 )  )      highest_bid[0] <= 'b1;    else    highest_bid[0] <= 'b0;  else highest_bid[0] <= 'b0;
                            if(highest_bid_en[1]) if     ((bid_reg_1  > bid_reg_0 ) && (bid_reg_1  > bid_reg_2 ) && (bid_reg_1  > bid_reg_3 )  )      highest_bid[1] <= 'b1;    else    highest_bid[1] <= 'b0;  else highest_bid[1] <= 'b0;
                            if(highest_bid_en[2]) if     ((bid_reg_2  > bid_reg_0 ) && (bid_reg_2  > bid_reg_1 ) && (bid_reg_2  > bid_reg_3 )  )      highest_bid[2] <= 'b1;    else    highest_bid[2] <= 'b0;  else highest_bid[2] <= 'b0;
                            if(highest_bid_en[3]) if     ((bid_reg_3  > bid_reg_0 ) && (bid_reg_3  > bid_reg_1 ) && (bid_reg_3  > bid_reg_2 )  )      highest_bid[3] <= 'b1;    else    highest_bid[3] <= 'b0;  else highest_bid[3] <= 'b0;
                            
//                                                if     ((bid[1] > bid[0]) && (bid[1] > bid[2]) && (bid[1] > bid[3])  )      highest_bid[1] <= 'b1;    else    highest_bid[1] <= 'b0;      
//                                                if     ((bid[2] > bid[0]) && (bid[2] > bid[1]) && (bid[2] > bid[3])  )      highest_bid[2] <= 'b1;    else    highest_bid[2] <= 'b0;    
//                                                if     ((bid[3] > bid[0]) && (bid[3] > bid[1]) && (bid[3] > bid[2])  )      highest_bid[3] <= 'b1;    else    highest_bid[3] <= 'b0;  

                            if     (( bid_reg_0  == bid_reg_1  ) | ( bid_reg_0  == bid_reg_2  ) | ( bid_reg_0  == bid_reg_3  )  )     equal_bid[0] <= 'b1;    else    equal_bid[0] <= 'b0; 
                            if     (( bid_reg_1  == bid_reg_0  ) | ( bid_reg_1  == bid_reg_2  ) | ( bid_reg_1  == bid_reg_3  )  )     equal_bid[1] <= 'b1;    else    equal_bid[1] <= 'b0;  
                            if     (( bid_reg_2  == bid_reg_0  ) | ( bid_reg_2  == bid_reg_1  ) | ( bid_reg_2  == bid_reg_3  )  )     equal_bid[2] <= 'b1;    else    equal_bid[2] <= 'b0;  
                            if     (( bid_reg_3  == bid_reg_0  ) | ( bid_reg_3  == bid_reg_1  ) | ( bid_reg_3  == bid_reg_2  )  )     equal_bid[3] <= 'b1;    else    equal_bid[3] <= 'b0;  
                            
                            if         (balance[0] >= bid[0])  valid_balance[0] <= 'b1; 	else  valid_balance[0] <= 'b0;
                            if         (balance[1] >= bid[1])  valid_balance[1] <= 'b1; 	else  valid_balance[1] <= 'b0;
                            if         (balance[2] >= bid[2])  valid_balance[2] <= 'b1; 	else  valid_balance[2] <= 'b0;
                            if         (balance[3] >= bid[3])  valid_balance[3] <= 'b1; 	else  valid_balance[3] <= 'b0;
                                                        
			end            
    end
    
// #################################################
always@(negedge clk or posedge rst)
    begin
        if (rst)
            begin
                count_60[0] <= 'b0;    
                count_60[1] <= 'b0;    
                count_60[2] <= 'b0;    
                count_60[3] <= 'b0;    
                serve_60    <= 'b0;
                last_serviced    <= 'b0;
            end
        else
            begin
                    last_serviced <= result;                                        // flopping to store which master was last serviced 
                    
                    count_60[0] <= ((result[0]) | (bid[0] == 'b0) ) ? 'b0 : (count_60[0] +1);            // start counter to avoid 60 cycle no service error , start it even if no bid by master 
                    count_60[1] <= ((result[1]) | (bid[1] == 'b0) ) ? 'b0 : (count_60[1] +1);        
                    count_60[2] <= ((result[2]) | (bid[2] == 'b0) ) ? 'b0 : (count_60[2] +1);        
                    count_60[3] <= ((result[3]) | (bid[3] == 'b0) ) ? 'b0 : (count_60[3] +1);                        
                    
                    serve_60[0] <= (count_60[0] == 6'd58) ? 'b1 : 'b0;                 // Flag to indicate which master to serve to avoid 60 cycle no service error 
                    serve_60[1] <= (count_60[1] == 6'd58) ? 'b1 : 'b0;                     
                    serve_60[2] <= (count_60[2] == 6'd58) ? 'b1 : 'b0;                                     
                    serve_60[3] <= (count_60[3] == 6'd58) ? 'b1 : 'b0;                                                         
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
