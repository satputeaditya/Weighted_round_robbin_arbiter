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
                    
                    output reg [3:0] grant
                );

wire [9:0] balance [3:0];
wire [3:0] bid [3:0];
reg  [3:0] highest_bid;

assign grant = highest_bid;

assign bid[0] = bid_0;
assign bid[1] = bid_1;
assign bid[2] = bid_2;
assign bid[3] = bid_3;

always@(*) 
    begin
        if (rst)
            begin
                highest_bid <= 'b0;
            end
        else
            begin                
                    if ((bid[0] == 0) &&  (bid[1] == 0) && (bid[2] == 0) && (bid[3] == 0)) highest_bid <= 4'b0000;       // takes care during initial system reset 
                    else
                        begin
                            if     ((bid[0] > bid[1]) && (bid[0] > bid[2]) && (bid[0] > bid[3])  && (balance[0] > bid[0]))    highest_bid[0] <= 4'b0001;    
                            if     ((bid[1] > bid[0]) && (bid[1] > bid[2]) && (bid[1] > bid[3])  && (balance[1] > bid[1]))      highest_bid[1] <= 4'b0010;  
                            if     ((bid[2] > bid[0]) && (bid[2] > bid[1]) && (bid[2] > bid[3])  && (balance[2] > bid[2]))      highest_bid[2] <= 4'b0100;    
                            if     ((bid[3] > bid[0]) && (bid[3] > bid[1]) && (bid[3] > bid[2])  && (balance[3] > bid[3]))      highest_bid[3] <= 4'b1000;  
                        end
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
