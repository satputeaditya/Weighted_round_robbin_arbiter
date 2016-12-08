//
// A simplt top level test bench
//
// It contains 4 masters and 4 slaves

// The slaves are addressed as:
// FFEF_S200-FFEF_S2FF
//  where S indicates the slave 0-3
//
// The interface for a bus master
//

  modport mstrR(input clk, input rst, input [3:0] req, output grant, input xfr,
            input RW, input [31:0] addr, input [31:0] DataToSlave, output [31:0] DataFromSlave);

            
  modport mstrR(input clk, input rst, input [3:0] req, output grant, input xfr,
            input RW, input [31:0] addr, input [31:0] DataToSlave, output [31:0] DataFromSlave);

endinterface : bmif

//
// The slave interface
// Connects to a master through the arbitrator
//
                  
  modport slvR(input clk, input rst, output sel, output RW,
                output [31:0] addr, output [31:0] DataToSlave, input [31:0] DataFromSlave);
  
endinterface : svif



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


always@(*)
		begin
			case (master_grant)
				4'h0001	: 	begin
								case (m0.addr)
										32'hFFEF_0200	: 	begin s0.RW	=  m0.RW;	s0.addr = m0.addr;	s0.DataToSlave 	=  m0.DataToSlave; m0.DataFromSlave =  s0.DataFromSlave; 	s0.sel	= 'b1;	s1.sel	= 'b0;	s2.sel	= 'b0;	s3.sel	= 'b0;	end															
										32'hFFEF_1200	: 	begin s1.RW	=  m0.RW;	s1.addr = m0.addr;	s1.DataToSlave 	=  m0.DataToSlave; m0.DataFromSlave =  s1.DataFromSlave; 	s0.sel	= 'b0;	s1.sel	= 'b1;	s2.sel	= 'b0;	s3.sel	= 'b0;	end															
										32'hFFEF_2200	: 	begin s2.RW	=  m0.RW;	s2.addr = m0.addr;	s2.DataToSlave 	=  m0.DataToSlave; m0.DataFromSlave =  s2.DataFromSlave; 	s0.sel	= 'b0;	s1.sel	= 'b0;	s2.sel	= 'b1;	s3.sel	= 'b0;	end															
										32'hFFEF_3200	: 	begin s3.RW	=  m0.RW;	s3.addr = m0.addr;	s3.DataToSlave 	=  m0.DataToSlave; m0.DataFromSlave =  s3.DataFromSlave; 	s0.sel	= 'b0;	s1.sel	= 'b0;	s2.sel	= 'b0;	s3.sel	= 'b1;	end															
										default			:  	begin s0.sel = 'b0;		s1.sel  = 'b0;		s2.sel = 'b0;		s3.sel = 'b0;  end							
								endcase
							end
				4'b0010	: 	begin
								case (m1.addr)
										32'hFFEF_0200	: 	begin s0.RW	=  m1.RW;	s0.addr = m1.addr;	s0.DataToSlave 	=  m1.DataToSlave; m1.DataFromSlave =  s0.DataFromSlave; 	s0.sel	= 'b1;	s1.sel	= 'b0;	s2.sel	= 'b0;	s3.sel	= 'b0;	end															
										32'hFFEF_1200	: 	begin s1.RW	=  m1.RW;	s1.addr = m1.addr;	s1.DataToSlave 	=  m1.DataToSlave; m1.DataFromSlave =  s1.DataFromSlave; 	s0.sel	= 'b0;	s1.sel	= 'b1;	s2.sel	= 'b0;	s3.sel	= 'b0;	end															
										32'hFFEF_2200	: 	begin s2.RW	=  m1.RW;	s2.addr = m1.addr;	s2.DataToSlave 	=  m1.DataToSlave; m1.DataFromSlave =  s2.DataFromSlave; 	s0.sel	= 'b0;	s1.sel	= 'b0;	s2.sel	= 'b1;	s3.sel	= 'b0;	end															
										32'hFFEF_3200	: 	begin s3.RW	=  m1.RW;	s3.addr = m1.addr;	s3.DataToSlave 	=  m1.DataToSlave; m1.DataFromSlave =  s3.DataFromSlave; 	s0.sel	= 'b0;	s1.sel	= 'b0;	s2.sel	= 'b0;	s3.sel	= 'b1;	end															
										default			:  	begin s0.sel = 'b0;		s1.sel  = 'b0;		s2.sel = 'b0;		s3.sel = 'b0;	end									
								endcase
							end
				4'b0100	: 	begin
								case (m2.addr)
										32'hFFEF_0200	: 	begin s0.RW	=  m2.RW;	s0.addr = m2.addr;	s0.DataToSlave 	=  m2.DataToSlave; m2.DataFromSlave =  s0.DataFromSlave; 	s0.sel	= 'b1;	s1.sel	= 'b0;	s2.sel	= 'b0;	s3.sel	= 'b0;	end	
										32'hFFEF_1200	: 	begin s1.RW	=  m2.RW;	s1.addr = m2.addr;	s1.DataToSlave 	=  m2.DataToSlave; m2.DataFromSlave =  s1.DataFromSlave; 	s0.sel	= 'b0;	s1.sel	= 'b1;	s2.sel	= 'b0;	s3.sel	= 'b0;	end	
										32'hFFEF_2200	: 	begin s2.RW	=  m2.RW;	s2.addr = m2.addr;	s2.DataToSlave 	=  m2.DataToSlave; m2.DataFromSlave =  s2.DataFromSlave; 	s0.sel	= 'b0;	s1.sel	= 'b0;	s2.sel	= 'b1;	s3.sel	= 'b0;	end	
										32'hFFEF_3200	: 	begin s3.RW	=  m2.RW;	s3.addr = m2.addr;	s3.DataToSlave 	=  m2.DataToSlave; m2.DataFromSlave =  s3.DataFromSlave; 	s0.sel	= 'b0;	s1.sel	= 'b0;	s2.sel	= 'b0;	s3.sel	= 'b1;	end	
										default			:  	begin s0.sel = 'b0;		s1.sel  = 'b0;		s2.sel = 'b0;		s3.sel = 'b0;	end									
								endcase				
							end
				4'b1000	: 	begin
								case (m3.addr)
										32'hFFEF_0200	: 	begin s0.RW	=  m3.RW;	s0.addr = m3.addr;	s0.DataToSlave 	=  m3.DataToSlave; m3.DataFromSlave =  s0.DataFromSlave; 	s0.sel	= 'b1;	s1.sel	= 'b0;	s2.sel	= 'b0;	s3.sel	= 'b0;	end
										32'hFFEF_1200	: 	begin s1.RW	=  m3.RW;	s1.addr = m3.addr;	s1.DataToSlave 	=  m3.DataToSlave; m3.DataFromSlave =  s1.DataFromSlave; 	s0.sel	= 'b0;	s1.sel	= 'b1;	s2.sel	= 'b0;	s3.sel	= 'b0;	end
										32'hFFEF_2200	: 	begin s2.RW	=  m3.RW;	s2.addr = m3.addr;	s2.DataToSlave 	=  m3.DataToSlave; m3.DataFromSlave =  s2.DataFromSlave; 	s0.sel	= 'b0;	s1.sel	= 'b0;	s2.sel	= 'b1;	s3.sel	= 'b0;	end		
										32'hFFEF_3200	: 	begin s3.RW	=  m3.RW;	s3.addr = m3.addr;	s3.DataToSlave 	=  m3.DataToSlave; m3.DataFromSlave =  s3.DataFromSlave; 	s0.sel	= 'b0;	s1.sel	= 'b0;	s2.sel	= 'b0;	s3.sel	= 'b1;	end		
										default			:  	begin s0.sel = 'b0;		s1.sel  = 'b0;		s2.sel = 'b0;		s3.sel = 'b0;	end	
								endcase				
							end
				default : 	begin end
			endcase
		end
		
		
//count M0 ( 	input clk, input rst,	input [3:0] bid,	input granted,		output reg [9:0] balance	); 
//count M0 ( 	m0.clk, m0.rst,	bid[0],	master_grant[0], balance[0]); 
//count M1 ( 	m1.clk, m1.rst,	bid[1],	master_grant[1], balance[1]); 
//count M2 ( 	m2.clk, m2.rst,	bid[2],	master_grant[2], balance[2]); 
//count M3 ( 	m3.clk, m3.rst,	bid[3]	master_grant[3], balance[3]); 

granting G1 ( m0.clk, m0.rst, bid[0], bid[1], bid[2], bid[3], master_grant);

endmodule
