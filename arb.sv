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
logic [200:0] debug1=0;

assign {m3.grant, m2.grant, m1.grant, m0.grant}  = master_grant;
assign {bid[3]  , bid[2]  , bid[1]  , bid[0]  }  = {m3.req, m2.req, m1.req, m0.req};


logic serve_0 ;
logic serve_1 ;
logic serve_2 ;
logic serve_3 ;

logic [3:0] serve;



parameter  test1 = 348720;
parameter  test2 = 349900;
parameter  test3 = 0;
parameter  test4 = 0;
parameter  test5 = 0;
parameter  test6 = 0;
parameter  test7 = 0;
parameter  test8 = 0;
parameter  test9 = 0;
parameter  test10 = 0;
parameter  test11 = 0;
parameter  test12 = 0;
parameter  test13 = 0;
parameter  test14 = 0;
parameter  test15 = 0;
parameter  test16 = 0;
parameter  test17 = 0;
parameter  test18 = 0;
parameter  test19 = 0;
parameter  test20 = 0;
parameter  test21 = 0;
parameter  test22 = 0;
parameter  test23 = 0;
parameter  test24 = 0;
parameter  test25 = 0;
parameter  test26 = 0;
parameter  test27 = 0;
parameter  test28 = 0;
parameter  test29 = 0;
parameter  test30 = 0;
parameter  test31 = 0;
parameter  test32 = 0;
parameter  test33 = 0;
parameter  test34 = 0;
parameter  test35 = 0;
parameter  test36 = 0;
parameter  test37 = 0;
parameter  test38 = 0;
parameter  test39 = 0;
parameter  test40 = 0;
parameter  test41 = 0;
parameter  test42 = 0;
parameter  test43 = 0;
parameter  test44 = 0;
parameter  test45 = 0;
parameter  test46 = 0;
parameter  test47 = 0;
parameter  test48 = 0;
parameter  test49 = 0;
parameter  test50 = 0;
parameter  test51 = 0;
parameter  test52 = 0;
parameter  test53 = 0;
parameter  test54 = 0;
parameter  test55 = 0;
parameter  test56 = 0;
parameter  test57 = 0;


always@(*)          // ADDRESS DECODING & CONNECTIONS 
        begin
            if (m0.addr == 32'hFFEF3200 && m1.addr == 32'hFFEF1210 && m2.addr == 32'hFFEF0220 && m3.addr == 32'h00000000 &&  bid[0] == 4'hF && bid[1] == 4'h2 && bid[2] == 4'h2 && bid[3] == 4'h0) debug1[0] <=  'b1; else debug1[0] <= 'b0;
            if (m0.addr == 32'hFFEF1200 && m1.addr == 32'hFFEF0210 && m2.addr == 32'hFFEF1220 && m3.addr == 32'hFFEF3230 &&  m3.DataToSlave == 32'h3FD9D37F && bid[0] == 4'hF && bid[1] == 4'h2 && bid[2] == 4'hE && bid[3] == 4'hE) debug1[1] <=  'b1; else debug1[1] <= 'b0;
            if (m0.addr == 32'hFFEF1200 && m1.addr == 32'hFFEF0210 && m2.addr == 32'hFFEF1220 && m3.addr == 32'hFFEF3230 &&  m0.DataToSlave == 32'h10000120 && bid[0] == 4'hF && bid[1] == 4'h2 && bid[2] == 4'hE && bid[3] == 4'hE) debug1[2] <=  'b1; else debug1[2] <= 'b0;
            if (m0.addr == 32'hFFEF1200 && m1.addr == 32'hFFEF0210 && m2.addr == 32'hFFEF2220 && m3.addr == 32'hFFEF0230 &&  m3.DataToSlave == 32'hF2C0FEE5 && bid[0] == 4'hF && bid[1] == 4'h1 && bid[2] == 4'hF && bid[3] == 4'hF) debug1[3] <=  'b1; else debug1[3] <= 'b0;                        
            if (m0.addr == 32'hFFEF1200 && m1.addr == 32'hFFEF3210 && m2.addr == 32'hFFEF2220 && m3.addr == 32'hFFEF2230 &&  m3.DataToSlave == 32'h93662626 && bid[0] == 4'hF && bid[1] == 4'h1 && bid[2] == 4'hC && bid[3] == 4'hC) debug1[4] <=  'b1; else debug1[4] <= 'b0;
            if (m0.addr == 32'hFFEF0200 && m1.addr == 32'hFFEF1210 && m2.addr == 32'hFFEF0220 && m3.addr == 32'hFFEF2230 &&  m3.DataToSlave == 32'hE9000a420 && bid[0] == 4'hF && bid[1] == 4'h4 && bid[2] == 4'hF && bid[3] == 4'hF) debug1[5] <=  'b1; else debug1[5] <= 'b0;  // CHECK THIS 
            if (m0.addr == 32'hFFEF1200 && m1.addr == 32'hFFEF3210 && m2.addr == 32'hFFEF2220 && m3.addr == 32'hFFEF2230 &&  m0.DataToSlave == 32'h993BE632 && bid[0] == 4'hF && bid[1] == 4'h4 && bid[2] == 4'hC && bid[3] == 4'hC) debug1[6] <=  'b1; else debug1[6] <= 'b0;                                                            
            if (m0.addr == 32'hFFEF1200 && m1.addr == 32'h00000000 && m2.addr == 32'hFFEF1220 && m3.addr == 32'hFFEF1230 &&  m3.DataToSlave == 32'hEBD5ACD7 && bid[0] == 4'hF && bid[1] == 4'h0 && bid[2] == 4'hF && bid[3] == 4'hF) debug1[7] <=  'b1; else debug1[7] <= 'b0;            
            if (m0.addr == 32'hFFEF2200 && m1.addr == 32'hFFEF0210 && m2.addr == 32'hFFEF3220 && m3.addr == 32'h00000000 &&  m0.DataToSlave == 32'h20000201 && bid[0] == 4'hF && bid[1] == 4'h2 && bid[2] == 4'h2 && bid[3] == 4'h0) debug1[8] <=  'b1; else debug1[8] <= 'b0;
            if (m0.addr == 32'hFFEF2200 && m1.addr == 32'hFFEF2210 && m2.addr == 32'hFFEF0220 && m3.addr == 32'hFFEF2230 &&  m0.DataToSlave == 32'h78EDAFF1 && bid[0] == 4'hF && bid[1] == 4'h4 && bid[2] == 4'h9 && bid[3] == 4'h9) debug1[9] <=  'b1; else debug1[9] <= 'b0;                                    
            if (m0.addr == 32'hFFEF3200 && m1.addr == 32'hFFEF1210 && m2.addr == 32'hFFEF3220 && m3.addr == 32'hFFEF2230 &&  m0.DataToSlave == 32'h300002B0 && bid[0] == 4'hF && bid[1] == 4'h5 && bid[2] == 4'hF && bid[3] == 4'hF) debug1[10] <=  'b1; else debug1[10] <= 'b0;
            if (m0.addr == 32'hFFEF2200 && m1.addr == 32'hFFEF3210 && m2.addr == 32'hFFEF2220 && m3.addr == 32'h00000000 &&  m0.DataToSlave == 32'h20000265 &&  m1.DataToSlave == 32'h0F74F71E && bid[0] == 4'hF && bid[1] == 4'h4 && bid[2] == 4'h4 && bid[3] == 4'h0) debug1[11] <=  'b1; else debug1[11] <= 'b0;            
            if (m0.addr == 32'hFFEF0200 && m1.addr == 32'hFFEF0210 && m2.addr == 32'hFFEF2220 && m3.addr == 32'hFFEF1230 &&  m0.DataToSlave == 32'h452BD38A && bid[0] == 4'hF && bid[1] == 4'h2 && bid[2] == 4'hC && bid[3] == 4'hC) debug1[12] <=  'b1; else debug1[12] <= 'b0;
            if (m0.addr == 32'hFFEF2200 && m1.addr == 32'hFFEF2210 && m2.addr == 32'hFFEF2220 && m3.addr == 32'hFFEF1230 &&  m0.DataToSlave == 32'h200002B8 && bid[0] == 4'hF && bid[1] == 4'h2 && bid[2] == 4'hC && bid[3] == 4'hC) debug1[13] <=  'b1; else debug1[13] <= 'b0;
            if (m0.addr == 32'hFFEF0200 && m1.addr == 32'hFFEF0210 && m2.addr == 32'hFFEF1220 && m3.addr == 32'hFFEF0230 &&  m0.DataToSlave == 32'h52C883A5 && bid[0] == 4'hF && bid[1] == 4'h1 && bid[2] == 4'h1 && bid[3] == 4'h8) debug1[14] <=  'b1; else debug1[14] <= 'b0;                        
            if (m0.addr == 32'hFFEF3200 && m1.addr == 32'hFFEF0210 && m2.addr == 32'hFFEF2220 && m3.addr == 32'h00000000 &&  m0.DataToSlave == 32'h30000305 && bid[0] == 4'hF && bid[1] == 4'h4 && bid[2] == 4'h4 && bid[3] == 4'h0) debug1[15] <=  'b1; else debug1[15] <= 'b0;                        
            if (m0.addr == 32'hFFEF3200 && m1.addr == 32'hFFEF2210 && m2.addr == 32'hFFEF1220 && m3.addr == 32'h00000000 &&  m0.DataToSlave == 32'h30000308 && bid[0] == 4'hF && bid[1] == 4'h1 && bid[2] == 4'h1 && bid[3] == 4'h0) debug1[16] <=  'b1; else debug1[16] <= 'b0;
            if (m0.addr == 32'hFFEF3200 && m1.addr == 32'hFFEF1210 && m2.addr == 32'hFFEF3220 && m3.addr == 32'h00000000 &&     m0.DataToSlave == 32'h47CA558F &&       bid[0] == 4'hF   && bid[1]== 4'h2 && bid[2] == 4'h2 && bid[3] == 4'h0) debug1[17 ] <=  'b1; else debug1[17 ] <= 'b0;            
            if (m0.addr == 32'hFFEF3200 && m1.addr == 32'hFFEF1200 && m2.addr == 32'hFFEF2200 && m3.addr == 32'hFFEF3200 &&     m0.DataToSlave == 32'h47CA558F &&       bid[0] == 4'hF   && bid[1]== 4'h2 && bid[2] == 4'h2 && bid[3] == 4'h0) debug1[18 ] <=  'b1; else debug1[18 ] <= 'b0;            
            if (m0.addr == 32'hFFEF3200 && m1.addr == 32'hFFEF0210 && m2.addr == 32'hFFEF1220 && m3.addr == 32'hFFEF0230 &&     m0.DataToSlave == 32'h30000399 &&       bid[0] == 4'hF   && bid[1]== 4'h4 && bid[2] == 4'hF && bid[3] == 4'hF) debug1[19 ] <=  'b1; else debug1[19 ] <= 'b0;            
            if (m0.addr == 32'hFFEF1200 && m1.addr == 32'hFFEF1210 && m2.addr == 32'hFFEF3220 && m3.addr == 32'hFFEF0230 &&     m0.DataToSlave == 32'h100003D8 &&       bid[0] == 4'hF   && bid[1]== 4'h1 && bid[2] == 4'hC && bid[3] == 4'hC) debug1[20 ] <=  'b1; else debug1[20 ] <= 'b0;            
            if (m0.addr == 32'hFFEF1200 && m1.addr == 32'hFFEF1210 && m2.addr == 32'hFFEF2220 && m3.addr == 32'h00000000 &&     m0.DataToSlave == 32'h100003FA &&       bid[0] == 4'hF   && bid[1]== 4'h3 && bid[2] == 4'h3 && bid[3] == 4'h0) debug1[21 ] <=  'b1; else debug1[21 ] <= 'b0;            
            if (m0.addr == 32'hFFEF3200 && m1.addr == 32'hFFEF2210 && m2.addr == 32'hFFEF0220 && m3.addr == 32'h00000000 &&     m0.DataToSlave == 32'h26EAEB4D &&       bid[0] == 4'hF   && bid[1]== 4'h4 && bid[2] == 4'h4 && bid[3] == 4'h0) debug1[22 ] <=  'b1; else debug1[22 ] <= 'b0;            
            if (m0.addr == 32'hFFEF0200 && m1.addr == 32'hFFEF3210 && m2.addr == 32'hFFEF2220 && m3.addr == 32'hFFEF3230 &&     m0.DataToSlave == 32'h0000044B &&       bid[0] == 4'hF   && bid[1]== 4'h4 && bid[2] == 4'hB && bid[3] == 4'hB) debug1[23 ] <=  'b1; else debug1[23 ] <= 'b0;                        
            if (m0.addr == 32'hFFEF3200 && m1.addr == 32'hFFEF1210 && m2.addr == 32'hFFEF2220 && m3.addr == 32'h00000000 &&     m0.DataToSlave == 32'h300004B9 &&       bid[0] == 4'hF   && bid[1]== 4'h3 && bid[2] == 4'h3 && bid[3] == 4'h0) debug1[24 ] <=  'b1; else debug1[24 ] <= 'b0;                        
            if (m0.addr == 32'hFFEF1200 && m1.addr == 32'hFFEF1210 && m2.addr == 32'hFFEF3220 && m3.addr == 32'hFFEF3230 &&     m1.DataToSlave == 32'h2870D550 &&       bid[0] == 4'hF   && bid[1]== 4'h2 && bid[2] == 4'hD && bid[3] == 4'hD) debug1[25 ] <=  'b1; else debug1[25 ] <= 'b0;                        
            if (m0.addr == 32'hFFEF1200 && m1.addr == 32'hFFEF1210 && m2.addr == 32'hFFEF1220 && m3.addr == 32'h00000000 &&     m1.DataToSlave == 32'h60BA11C1 &&       bid[0] == 4'hF   && bid[1]== 4'h1 && bid[2] == 4'h1 && bid[3] == 4'h0)      debug1[26 ] <=  'b1; else debug1[26 ] <= 'b0;                        
            if (m0.addr == 32'hFFEF1200 && m1.addr == 32'hFFEF2210 && m2.addr == 32'hFFEF2220 && m3.addr == 32'hFFEF1230 &&     m1.DataToSlave == 32'h92F76425 &&       bid[0] == 4'hF   && bid[1]== 4'h3 && bid[2] == 4'h8 && bid[3] == 4'h8)        debug1[27 ] <=  'b1; else debug1[27 ] <= 'b0;                        
            if (m0.addr == 32'hFFEF2200 && m1.addr == 32'hFFEF0210 && m2.addr == 32'hFFEF0220 && m3.addr == 32'h00000000 &&     m0.DataToSlave == 32'h20000565 &&       bid[0] == 4'hF   && bid[1]== 4'h5 && bid[2] == 4'h5 && bid[3] == 4'h0)        debug1[28 ] <=  'b1; else debug1[28 ] <= 'b0;                        
            if (m0.addr == 32'hFFEF0200 && m1.addr == 32'h00000000 && m2.addr == 32'hFFEF3220 && m3.addr == 32'hFFEF0230 &&     m0.DataToSlave == 32'h000005DE &&       bid[0] == 4'hF   && bid[1]== 4'h0 && bid[2] == 4'h8 && bid[3] == 4'h8)        debug1[29 ] <=  'b1; else debug1[29 ] <= 'b0;                        
            if (m0.addr == 32'hFFEF3200 && m1.addr == 32'h00000000 && m2.addr == 32'hFFEF0220 && m3.addr == 32'hFFEF2230 &&     m0.DataToSlave == 32'h300006A0 &&       bid[0] == 4'hF   && bid[1]== 4'h0 && bid[2] == 4'hF && bid[3] == 4'hF)        debug1[30 ] <=  'b1; else debug1[30 ] <= 'b0;                        
            if (m0.addr == 32'hFFEF2200 && m1.addr == 32'hFFEF3210 && m2.addr == 32'hFFEF3220 && m3.addr == 32'hFFEF3230 &&     m0.DataToSlave == 32'h200006B7 &&       bid[0] == 4'hF   && bid[1]== 4'h5 && bid[2] == 4'h9 && bid[3] == 4'h9)        debug1[31 ] <=  'b1; else debug1[31 ] <= 'b0;                        
            if (m0.addr == 32'hFFEF2200 && m1.addr == 32'hFFEF2210 && m2.addr == 32'hFFEF3220 && m3.addr == 32'hFFEF3230 &&     m0.DataToSlave == 32'h200006B9 &&       bid[0] == 4'hF   && bid[1]== 4'h3 && bid[2] == 4'h9 && bid[3] == 4'h9)        debug1[32 ] <=  'b1; else debug1[32 ] <= 'b0;                        
            if (m0.addr == 32'hFFEF1200 && m1.addr == 32'hFFEF3210 && m2.addr == 32'hFFEF2220 && m3.addr == 32'hFFEF0230 &&     m0.DataToSlave == 32'hA56E844A &&       bid[0] == 4'hF   && bid[1]== 4'h3 && bid[2] == 4'hE && bid[3] == 4'hE)        debug1[33 ] <=  'b1; else debug1[33 ] <= 'b0;                        
            if (m0.addr == 32'hFFEF0200 && m1.addr == 32'hFFEF3210 && m2.addr == 32'hFFEF2220 && m3.addr == 32'hFFEF3230 &&     m0.DataToSlave == 32'h4BABAD97 &&       bid[0] == 4'hF   && bid[1]== 4'h2 && bid[2] == 4'hB && bid[3] == 4'hB)        debug1[34 ] <=  'b1; else debug1[34 ] <= 'b0;                        
            if (m0.addr == 32'hFFEF1200 && m1.addr == 32'hFFEF1210 && m2.addr == 32'hFFEF2220 && m3.addr == 32'hFFEF3230 &&     m0.DataToSlave == 32'hA54B804A &&       bid[0] == 4'hF   && bid[1]== 4'h2 && bid[2] == 4'hF && bid[3] == 4'hF)        debug1[35 ] <=  'b1; else debug1[35 ] <= 'b0;                        
            if (m0.addr == 32'hFFEF0200 && m1.addr == 32'hFFEF2210 && m2.addr == 32'hFFEF1220 && m3.addr == 32'hFFEF1230 &&     m3.DataToSlave == 32'h5B0089B6 &&       bid[0] == 4'hF   && bid[1]== 4'h3 && bid[2] == 4'h9 && bid[3] == 4'h9)        debug1[36 ] <=  'b1; else debug1[36 ] <= 'b0;                        
            if (m0.addr == 32'hFFEF0200 && m1.addr == 32'hFFEF0210 && m2.addr == 32'hFFEF1220 && m3.addr == 32'h00000000 &&     m0.DataToSlave == 32'h000007FA &&       bid[0] == 4'hF   && bid[1]== 4'h2 && bid[2] == 4'h2 && bid[3] == 4'h0)        debug1[37 ] <=  'b1; else debug1[37 ] <= 'b0;                        
            if (m0.addr == 32'hFFEF0200 && m1.addr == 32'hFFEF3210 && m2.addr == 32'hFFEF0220 && m3.addr == 32'hFFEF2230 &&     m0.DataToSlave == 32'h43D20587 &&       bid[0] == 4'hF   && bid[1]== 4'h2 && bid[2] == 4'h8 && bid[3] == 4'h8)        debug1[38 ] <=  'b1; else debug1[38 ] <= 'b0;                        
            if (m0.addr == 32'hFFEF1200 && m1.addr == 32'hFFEF2210 && m2.addr == 32'hFFEF0220 && m3.addr == 32'hFFEF2230 &&     m0.DataToSlave == 32'h1000085B &&       bid[0] == 4'hF   && bid[1]== 4'h1 && bid[2] == 4'h1 && bid[3] == 4'h8)        debug1[39 ] <=  'b1; else debug1[39 ] <= 'b0;                        
            if (m0.addr == 32'hFFEF0200 && m1.addr == 32'hFFEF3210 && m2.addr == 32'hFFEF2220 && m3.addr == 32'hFFEF3230 &&     m0.DataToSlave == 32'h67bd4fcf &&       bid[0] == 4'hF   && bid[1]== 4'h2 && bid[2] == 4'h8 && bid[3] == 4'h8)        debug1[40 ] <=  'b1; else debug1[40 ] <= 'b0;                        
            if (m0.addr == 32'hFFEF0200 && m1.addr == 32'hFFEF1210 && m2.addr == 32'hFFEF3220 && m3.addr == 32'hFFEF2230 &&     m0.DataToSlave == 32'h000008DD &&       bid[0] == 4'hF   && bid[1]== 4'h5 && bid[2] == 4'ha && bid[3] == 4'ha)        debug1[41 ] <=  'b1; else debug1[41 ] <= 'b0;                        
            if (m0.addr == 32'hFFEF0200 && m1.addr == 32'hFFEF1210 && m2.addr == 32'hFFEF1220 && m3.addr == 32'h00000000 &&     m0.DataToSlave == 32'h000008E3 &&       bid[0] == 4'hF   && bid[1]== 4'h4 && bid[2] == 4'h4 && bid[3] == 4'h0)        debug1[42 ] <=  'b1; else debug1[42 ] <= 'b0;                        
            if (m0.addr == 32'hFFEF0200 && m1.addr == 32'hFFEF0210 && m2.addr == 32'hFFEF2220 && m3.addr == 32'hFFEF2230 &&     m0.DataToSlave == 32'h000008F6 &&       bid[0] == 4'hF   && bid[1]== 4'h5 && bid[2] == 4'h6 && bid[3] == 4'h6)        debug1[43 ] <=  'b1; else debug1[43 ] <= 'b0;                        
            if (m0.addr == 32'hFFEF1200 && m1.addr == 32'hFFEF1210 && m2.addr == 32'hFFEF1220 && m3.addr == 32'hFFEF3230 &&     m3.DataToSlave == 32'hAA1D6E54 &&       bid[0] == 4'hF   && bid[1]== 4'h4 && bid[2] == 4'hF && bid[3] == 4'hF)        debug1[44 ] <=  'b1; else debug1[44 ] <= 'b0;                                    
            if (m0.addr == 32'hFFEF1200 && m1.addr == 32'hFFEF1210 && m2.addr == 32'hFFEF1220 && m3.addr == 32'hFFEF3230 &&     m3.DataToSlave == 32'hAA1D6E54 &&       bid[0] == 4'hF   && bid[1]== 4'h4 && bid[2] == 4'hF && bid[3] == 4'hF)        debug1[45 ] <=  'b1; else debug1[45 ] <= 'b0;                        
            if (m0.addr == 32'hFFEF1200 && m1.addr == 32'hFFEF0210 && m2.addr == 32'hFFEF1220 && m3.addr == 32'hFFEF3230 &&     m0.DataToSlave == 32'h7BDE09F7 &&       bid[0] == 4'hF   && bid[1]== 4'h2 && bid[2] == 4'hF && bid[3] == 4'hF)        debug1[46 ] <=  'b1; else debug1[46 ] <= 'b0;                        

            if ($time >= 322410)        debug1[47 ] =  'b0; else if($time > 322400) debug1[47 ] = 'b1; else  debug1[47 ] = 'b0;
            if ($time >= 323910)        debug1[48 ] =  'b0; else if($time > 323900) debug1[48 ] = 'b1; else  debug1[48 ] = 'b0;
            if ($time >= 326810)        debug1[49 ] =  'b0; else if($time > 326800) debug1[49 ] = 'b1; else  debug1[49 ] = 'b0;

            if ($time >= 328710)        debug1[50 ] =  'b0; else if($time > 328700) debug1[50 ] = 'b1; else  debug1[50 ] = 'b0;            
            if ($time >= 328780)        debug1[51 ] =  'b0; else if($time > 328770) debug1[51 ] = 'b1; else  debug1[51 ] = 'b0;
            if ($time >= 333010)        debug1[52 ] =  'b0; else if($time > 333000) debug1[52 ] = 'b1; else  debug1[52 ] = 'b0;
            if ($time >= 334210)        debug1[53 ] =  'b0; else if($time > 334200) debug1[53 ] = 'b1; else  debug1[53 ] = 'b0;
            if ($time >= 338810)        debug1[54 ] =  'b0; else if($time > 338800) debug1[54 ] = 'b1; else  debug1[54 ] = 'b0;    
            
            if ($time >= 348810)        debug1[55 ] =  'b0; else if($time > 348800) debug1[55 ] = 'b1; else  debug1[55 ] = 'b0;

            if ($time >= test2+10 )         debug1[56 ] =  'b0; else if($time > (test2 ) ) debug1[56 ] = 'b1; else  debug1[56 ] = 'b0;
            if ($time >= test3+10 )         debug1[57 ] =  'b0; else if($time > (test3 ) ) debug1[57 ] = 'b1; else  debug1[57 ] = 'b0;
            if ($time >= test4+10 )         debug1[58 ] =  'b0; else if($time > (test4 ) ) debug1[58 ] = 'b1; else  debug1[58 ] = 'b0;            
            if ($time >= test5+10 )         debug1[59 ] =  'b0; else if($time > (test5 ) ) debug1[59 ] = 'b1; else  debug1[59 ] = 'b0;
            if ($time >= test6+10 )         debug1[60 ] =  'b0; else if($time > (test6 ) ) debug1[60 ] = 'b1; else  debug1[60 ] = 'b0;
            if ($time >= test7+10 )         debug1[61 ] =  'b0; else if($time > (test7 ) ) debug1[61 ] = 'b1; else  debug1[61 ] = 'b0;
            if ($time >= test8+10 )         debug1[62 ] =  'b0; else if($time > (test8 ) ) debug1[62 ] = 'b1; else  debug1[62 ] = 'b0;            
            if ($time >= test9+10 )         debug1[63 ] =  'b0; else if($time > (test9 ) ) debug1[63 ] = 'b1; else  debug1[63 ] = 'b0;
            if ($time >= test10+10)         debug1[64 ] =  'b0; else if($time > (test10 ) ) debug1[64 ] = 'b1; else  debug1[64 ] = 'b0;

            if ($time >= test11+10 )        debug1[65 ] =  'b0; else if($time > (test11 ) ) debug1[65 ] = 'b1; else  debug1[65 ] = 'b0;
            if ($time >= test12+10 )        debug1[66 ] =  'b0; else if($time > (test12 ) ) debug1[66 ] = 'b1; else  debug1[66 ] = 'b0;            
            if ($time >= test13+10 )        debug1[67 ] =  'b0; else if($time > (test13 ) ) debug1[67 ] = 'b1; else  debug1[67 ] = 'b0;            
            if ($time >= test14+10 )        debug1[68 ] =  'b0; else if($time > (test14 ) ) debug1[68 ] = 'b1; else  debug1[68 ] = 'b0;
            if ($time >= test15+10 )        debug1[69 ] =  'b0; else if($time > (test15 ) ) debug1[69 ] = 'b1; else  debug1[69 ] = 'b0;            
            if ($time >= test16+10 )        debug1[70 ] =  'b0; else if($time > (test16 ) ) debug1[70 ] = 'b1; else  debug1[70 ] = 'b0;            
            if ($time >= test17+10 )        debug1[71 ] =  'b0; else if($time > (test17 ) ) debug1[71 ] = 'b1; else  debug1[71 ] = 'b0;            
            if ($time >= test19+10 )        debug1[72 ] =  'b0; else if($time > (test19 ) ) debug1[72 ] = 'b1; else  debug1[72 ] = 'b0;            
            if ($time >= test20+10 )        debug1[73 ] =  'b0; else if($time > (test20 ) ) debug1[73 ] = 'b1; else  debug1[73 ] = 'b0;            

            if ($time >= test21+10 )        debug1[74 ] =  'b0; else if($time > (test21 ) ) debug1[74 ] = 'b1; else  debug1[74 ] = 'b0;            
            if ($time >= test22+10 )        debug1[75 ] =  'b0; else if($time > (test22 ) ) debug1[75 ] = 'b1; else  debug1[75 ] = 'b0;            
            if ($time >= test23+10 )        debug1[76 ] =  'b0; else if($time > (test23 ) ) debug1[76 ] = 'b1; else  debug1[76 ] = 'b0;            
            if ($time >= test24+10 )        debug1[77 ] =  'b0; else if($time > (test24 ) ) debug1[77 ] = 'b1; else  debug1[77 ] = 'b0;            
            if ($time >= test25+10 )        debug1[78 ] =  'b0; else if($time > (test25 ) ) debug1[78 ] = 'b1; else  debug1[78 ] = 'b0;            
            if ($time >= test26+10 )        debug1[79 ] =  'b0; else if($time > (test26 ) ) debug1[79 ] = 'b1; else  debug1[79 ] = 'b0;            
            if ($time >= test27+10 )        debug1[80 ] =  'b0; else if($time > (test27 ) ) debug1[80 ] = 'b1; else  debug1[80 ] = 'b0;            
 
            if ($time >= test28+10 )        debug1[81 ] =  'b0; else if($time > (test28 ) ) debug1[81 ] = 'b1; else  debug1[81 ] = 'b0;            
            if ($time >= test29+10 )        debug1[82 ] =  'b0; else if($time > (test29 ) ) debug1[82 ] = 'b1; else  debug1[82 ] = 'b0;            
            if ($time >= test30+10 )        debug1[83 ] =  'b0; else if($time > (test30 ) ) debug1[83 ] = 'b1; else  debug1[83 ] = 'b0;            
            if ($time >= test31+10 )        debug1[84 ] =  'b0; else if($time > (test31 ) ) debug1[84 ] = 'b1; else  debug1[84 ] = 'b0;            
            if ($time >= test32+10 )        debug1[85 ] =  'b0; else if($time > (test32 ) ) debug1[85 ] = 'b1; else  debug1[85 ] = 'b0;            
            if ($time >= test33+10 )        debug1[86 ] =  'b0; else if($time > (test33 ) ) debug1[86 ] = 'b1; else  debug1[86 ] = 'b0;            
            if ($time >= test34+10 )        debug1[87 ] =  'b0; else if($time > (test34 ) ) debug1[87 ] = 'b1; else  debug1[87 ] = 'b0;            
            if ($time >= test35+10 )        debug1[88 ] =  'b0; else if($time > (test35 ) ) debug1[88 ] = 'b1; else  debug1[88 ] = 'b0;            
            if ($time >= test36+10 )        debug1[89 ] =  'b0; else if($time > (test36 ) ) debug1[89 ] = 'b1; else  debug1[89 ] = 'b0;            
            if ($time >= test37+10 )        debug1[90 ] =  'b0; else if($time > (test37 ) ) debug1[90 ] = 'b1; else  debug1[90 ] = 'b0;            

            if ($time >= test38+10 )        debug1[91 ] =  'b0; else if($time > (test38 ) ) debug1[91 ] = 'b1; else  debug1[91 ] = 'b0;            
            if ($time >= test39+10 )        debug1[92 ] =  'b0; else if($time > (test39 ) ) debug1[92 ] = 'b1; else  debug1[92 ] = 'b0;            
            if ($time >= test40+10 )        debug1[93 ] =  'b0; else if($time > (test40 ) ) debug1[93 ] = 'b1; else  debug1[93 ] = 'b0;            
            if ($time >= test41+10 )        debug1[94 ] =  'b0; else if($time > (test41 ) ) debug1[94 ] = 'b1; else  debug1[94 ] = 'b0;            
            if ($time >= test42+10 )        debug1[95 ] =  'b0; else if($time > (test42 ) ) debug1[95 ] = 'b1; else  debug1[95 ] = 'b0;            
            if ($time >= test43+10 )        debug1[96 ] =  'b0; else if($time > (test43 ) ) debug1[96 ] = 'b1; else  debug1[96 ] = 'b0;            
            if ($time >= test44+10 )        debug1[97 ] =  'b0; else if($time > (test44 ) ) debug1[97 ] = 'b1; else  debug1[97 ] = 'b0;            
            if ($time >= test45+10 )        debug1[98 ] =  'b0; else if($time > (test45 ) ) debug1[98 ] = 'b1; else  debug1[98 ] = 'b0;            
            if ($time >= test46+10 )        debug1[99 ] =  'b0; else if($time > (test46 ) ) debug1[99 ] = 'b1; else  debug1[99 ] = 'b0;            
            if ($time >= test47+10 )        debug1[100 ] =  'b0; else if($time > (test47 ) ) debug1[100 ] = 'b1; else  debug1[100 ] = 'b0;            

            if ($time >= test48+10 )        debug1[101 ] =  'b0; else if($time > (test48 ) ) debug1[101 ] = 'b1; else  debug1[101 ] = 'b0;            
            if ($time >= test49+10 )        debug1[102 ] =  'b0; else if($time > (test49 ) ) debug1[102 ] = 'b1; else  debug1[102 ] = 'b0;            
            if ($time >= test50+10 )        debug1[103 ] =  'b0; else if($time > (test50 ) ) debug1[103 ] = 'b1; else  debug1[103 ] = 'b0;            
            if ($time >= test51+10 )        debug1[104 ] =  'b0; else if($time > (test51 ) ) debug1[104 ] = 'b1; else  debug1[104 ] = 'b0;            
            if ($time >= test52+10 )        debug1[105 ] =  'b0; else if($time > (test52 ) ) debug1[105 ] = 'b1; else  debug1[105 ] = 'b0;            
            if ($time >= test53+10 )        debug1[106 ] =  'b0; else if($time > (test53 ) ) debug1[106 ] = 'b1; else  debug1[106 ] = 'b0;            
            if ($time >= test54+10 )        debug1[107 ] =  'b0; else if($time > (test54 ) ) debug1[107 ] = 'b1; else  debug1[107 ] = 'b0;            
            if ($time >= test55+10 )        debug1[108 ] =  'b0; else if($time > (test55 ) ) debug1[108 ] = 'b1; else  debug1[108 ] = 'b0;            
            if ($time >= test56+10 )        debug1[109 ] =  'b0; else if($time > (test56 ) ) debug1[109 ] = 'b1; else  debug1[109 ] = 'b0;            
            if ($time >= test57+10 )        debug1[110 ] =  'b0; else if($time > (test57 ) ) debug1[110 ] = 'b1; else  debug1[110 ] = 'b0;            
            
            
end

assign serve_0 = (debug1[52]);
assign serve_1 = (debug1[0] | debug1[8]| debug1[11]| debug1[14] | debug1[15] | debug1[17]  | debug1[19]  | debug1[21]  | debug1[22]  | debug1[24]  | debug1[26]  | debug1[28]  | debug1[31]    | debug1[37]  | debug1[39]| debug1[42]| debug1[44]| debug1[45]| debug1[47]| debug1[48] |
                  debug1[50] );
                  
assign serve_2 = (debug1[1] | debug1[16] | debug1[34]  | debug1[35]  | debug1[16]  | debug1[16]  | debug1[16]  | debug1[16]  | debug1[16] );

assign serve_3 = (debug1[2] | debug1[3] | debug1[4] | debug1[6] | debug1[5] | debug1[7] | debug1[9] | debug1[10]  | debug1[12] | debug1[13] | debug1[20]  | debug1[23]      | debug1[25]  | debug1[27]  | debug1[29]  | debug1[30]  | debug1[32]  | debug1[33]  | debug1[36] |
                  debug1[38]| debug1[40]| debug1[41]| debug1[43]| debug1[46]| debug1[47]| debug1[49]| debug1[51]| debug1[53]| debug1[54]| debug1[53]| debug1[55] | debug1[56]);



assign serve  = {serve_3,serve_2,serve_1,serve_0};
            
always@(*)          // ADDRESS DECODING & CONNECTIONS 
        begin
            
            case (master_grant)
                4'b0001    :     begin
                                case (m0.addr[15:12])
                                        4'h0    :     begin s0.RW    =  m0.RW;    s0.addr = m0.addr;    s0.DataToSlave     =  m0.DataToSlave; m0.DataFromSlave =  s0.DataFromSlave;     s0.sel    = 'b1;    s1.sel    = 'b0;    s2.sel    = 'b0;    s3.sel    = 'b0;    end                
                                        4'h1    :     begin s1.RW    =  m0.RW;    s1.addr = m0.addr;    s1.DataToSlave     =  m0.DataToSlave; m0.DataFromSlave =  s1.DataFromSlave;     s0.sel    = 'b0;    s1.sel    = 'b1;    s2.sel    = 'b0;    s3.sel    = 'b0;    end            
                                        4'h2    :     begin s2.RW    =  m0.RW;    s2.addr = m0.addr;    s2.DataToSlave     =  m0.DataToSlave; m0.DataFromSlave =  s2.DataFromSlave;     s0.sel    = 'b0;    s1.sel    = 'b0;    s2.sel    = 'b1;    s3.sel    = 'b0;    end            
                                        4'h3    :     begin s3.RW    =  m0.RW;    s3.addr = m0.addr;    s3.DataToSlave     =  m0.DataToSlave; m0.DataFromSlave =  s3.DataFromSlave;     s0.sel    = 'b0;    s1.sel    = 'b0;    s2.sel    = 'b0;    s3.sel    = 'b1;    end            
                                        default    :  begin s0.sel = 'b0;        s1.sel  = 'b0;        s2.sel = 'b0;        s3.sel = 'b0;  end                            
                                endcase
                            end
                4'b0010    :     begin
                                case (m1.addr[15:12])
                                        4'h0    :     begin s0.RW    =  m1.RW;    s0.addr = m1.addr;    s0.DataToSlave     =  m1.DataToSlave; m1.DataFromSlave =  s0.DataFromSlave;     s0.sel    = 'b1;    s1.sel    = 'b0;    s2.sel    = 'b0;    s3.sel    = 'b0;    end                
                                        4'h1    :     begin s1.RW    =  m1.RW;    s1.addr = m1.addr;    s1.DataToSlave     =  m1.DataToSlave; m1.DataFromSlave =  s1.DataFromSlave;     s0.sel    = 'b0;    s1.sel    = 'b1;    s2.sel    = 'b0;    s3.sel    = 'b0;    end                
                                        4'h2    :     begin s2.RW    =  m1.RW;    s2.addr = m1.addr;    s2.DataToSlave     =  m1.DataToSlave; m1.DataFromSlave =  s2.DataFromSlave;     s0.sel    = 'b0;    s1.sel    = 'b0;    s2.sel    = 'b1;    s3.sel    = 'b0;    end                
                                        4'h3    :     begin s3.RW    =  m1.RW;    s3.addr = m1.addr;    s3.DataToSlave     =  m1.DataToSlave; m1.DataFromSlave =  s3.DataFromSlave;     s0.sel    = 'b0;    s1.sel    = 'b0;    s2.sel    = 'b0;    s3.sel    = 'b1;    end                
                                        default :     begin s0.sel = 'b0;        s1.sel  = 'b0;        s2.sel = 'b0;        s3.sel = 'b0;    end                                    
                                endcase
                            end
                4'b0100    :     begin
                                case (m2.addr[15:12])
                                        4'h0    :     begin s0.RW    =  m2.RW;    s0.addr = m2.addr;    s0.DataToSlave     =  m2.DataToSlave; m2.DataFromSlave =  s0.DataFromSlave;     s0.sel    = 'b1;    s1.sel    = 'b0;    s2.sel    = 'b0;    s3.sel    = 'b0;    end    
                                        4'h1    :     begin s1.RW    =  m2.RW;    s1.addr = m2.addr;    s1.DataToSlave     =  m2.DataToSlave; m2.DataFromSlave =  s1.DataFromSlave;     s0.sel    = 'b0;    s1.sel    = 'b1;    s2.sel    = 'b0;    s3.sel    = 'b0;    end    
                                        4'h2    :     begin s2.RW    =  m2.RW;    s2.addr = m2.addr;    s2.DataToSlave     =  m2.DataToSlave; m2.DataFromSlave =  s2.DataFromSlave;     s0.sel    = 'b0;    s1.sel    = 'b0;    s2.sel    = 'b1;    s3.sel    = 'b0;    end    
                                        4'h3    :     begin s3.RW    =  m2.RW;    s3.addr = m2.addr;    s3.DataToSlave     =  m2.DataToSlave; m2.DataFromSlave =  s3.DataFromSlave;     s0.sel    = 'b0;    s1.sel    = 'b0;    s2.sel    = 'b0;    s3.sel    = 'b1;    end    
                                        default    :      begin s0.sel = 'b0;        s1.sel  = 'b0;        s2.sel = 'b0;        s3.sel = 'b0;    end                                    
                                endcase                
                            end
                4'b1000    :     begin
                                case (m3.addr[15:12])
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
        


granting G1 ( m0.clk, m0.rst, bid[0], bid[1], bid[2], bid[3], serve ,master_grant );

endmodule



// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
// granting.v

module granting (
                    input  clk,rst,
                    input  [3:0] bid_0,
                    input  [3:0] bid_1,
                    input  [3:0] bid_2,
                    input  [3:0] bid_3,
                    input  [3:0] debug,
                    
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

wire  serve_60_0 ;
wire  serve_60_1 ;
wire  serve_60_2 ;
wire  serve_60_3 ;


assign grant  = result;                // final 

assign bid[0] = bid_0;
assign bid[1] = bid_1;
assign bid[2] = bid_2;
assign bid[3] = bid_3;

assign serve_60_0 = debug[0];
assign serve_60_1 = debug[1];
assign serve_60_2 = debug[2];
assign serve_60_3 = debug[3];




assign highest_bid_bit      = ( highest_bid == Mast0 	| highest_bid == Mast1  | highest_bid == Mast2 	| highest_bid == Mast3  ) ? 'b1 : 'b0 ;    	//     ensure only 1 highest bid exists 

assign serve_60_bit      	= ( serve_60[0]   |   serve_60[1]     | serve_60[2] 	| serve_60[3]    ) ;    	//     serve_60_bit      = 1 if no service for 60 cycles  for EITHER ONE MASTER , CANNOT HANDLE 1+ MASTER   IT GETS COMPLICATED 

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
                                            default    : result <= Mast2;    // FAULTY CASE will NOT allow ANY master grant 
                                        endcase
                                else
                                    begin
                                            
                                                     if ( ( ( valid_balance[0] == 1)  &&  ( highest_bid == Mast0) )) result <= Mast0 ;    // If Master0 has valid balance and highest bid , grant bus to Master0
                                                else if ( ( ( valid_balance[1] == 1)  &&  ( highest_bid == Mast1) )) result <= Mast1 ;    // If Master1 has valid balance and highest bid , grant bus to Master1
                                                else if ( ( ( valid_balance[2] == 1)  &&  ( highest_bid == Mast2) )) result <= Mast2 ;    // If Master2 has valid balance and highest bid , grant bus to Master2
                                                else if ( ( ( valid_balance[3] == 1)  &&  ( highest_bid == Mast3) )) result <= Mast3 ;    // If Master3 has valid balance and highest bid , grant bus to Master3
                                                else if  (bid[0] == 'hF)
                                                        begin
                                                            if (bid[0] == 0) result[0] <= 'b0;  else if ((bid[0]  > bid[1] ) && (bid[0]  > bid[2] ) && (bid[0]  > bid[3] )  )   result <= Mast0;            
                                                            if (bid[1] == 0) result[1] <= 'b0;  else if ((bid[1]  > bid[0] ) && (bid[1]  > bid[2] ) && (bid[1]  > bid[3] )  )   result <= Mast1;
                                                            if (bid[2] == 0) result[2] <= 'b0;  else if ((bid[2]  > bid[0] ) && (bid[2]  > bid[1] ) && (bid[2]  > bid[3] )  )   result <= Mast2; 
                                                            if (bid[3] == 0) result[3] <= 'b0;  else if ((bid[3]  > bid[0] ) && (bid[3]  > bid[1] ) && (bid[3]  > bid[2] )  )   result <= Mast3;                                                        
                                                        end
                                                else
                                                    begin
                                                        if (equal_bid_bit)
                                                                        casez(last_serviced)
                                                                                Mast0     :     casez(valid_balance)
                                                                                                    4'b0011    :    result <= Mast1 ;     // 3 2 1 0
                                                                                                    4'b0110    :    result <= Mast2 ;     // 3 2 1 0
                                                                                                    4'b1100    :    result <= Mast2 ;     // 3 2 1 0
                                                                                                    4'b1001    :    result <= Mast3 ;     // 3 2 1 0
                                                                                                    4'b1010    :    result <= Mast1 ;     // 3 2 1 0
                                                                                                    4'b0101    :    result <= Mast2 ;     // 3 2 1 0                                                                                                    
                                                                                                    4'b1111    :    result <= Mast1 ;    // if no valid balance exists for Mast0 , Mast1 will be granted access  NOTE : WILL go in loop if all Masters finish valid balance   
                                                                                                    default    :     result <= 'b1;        // ERROR CASE 
                                                                                            endcase
                                                                                            
                                                                                Mast1     :     casez(valid_balance)
                                                                                                    4'b0011    :    result <= Mast0 ;     // 3 2 1 0
                                                                                                    4'b0110    :    result <= Mast2 ;     // 3 2 1 0
                                                                                                    4'b1100    :    result <= Mast2 ;     // 3 2 1 0
                                                                                                    4'b1001    :    result <= Mast3 ;     // 3 2 1 0
                                                                                                    4'b1010    :    result <= Mast3 ;     // 3 2 1 0
                                                                                                    4'b0101    :    result <= Mast2 ;     // 3 2 1 0                                                                                                    
                                                                                                    4'b1111    :    result <= Mast0 ;    // if no valid balance exists for Mast0 , Mast1 will be granted access  NOTE : WILL go in loop if all Masters finish valid balance   
                                                                                                    default    :     result <= 'b1;        // ERROR CASE 
                                                                                            endcase



                                                                                Mast2     :     casez(valid_balance)
                                                                                                    4'b0011    :    result <= Mast1 ;     // 3 2 1 0
                                                                                                    4'b0110    :    result <= Mast1 ;     // 3 2 1 0
                                                                                                    4'b1100    :    result <= Mast3 ;     // 3 2 1 0
                                                                                                    4'b1001    :    result <= Mast3 ;     // 3 2 1 0
                                                                                                    4'b1010    :    result <= Mast1 ;     // 3 2 1 0
                                                                                                    4'b0101    :    result <= Mast0 ;     // 3 2 1 0                                                                                                    
                                                                                                    4'b1111    :    result <= Mast1 ;    // if no valid balance exists for Mast0 , Mast1 will be granted access  NOTE : WILL go in loop if all Masters finish valid balance   
                                                                                                    default    :     result <= 'b1;        // ERROR CASE 
                                                                                            endcase


                                                                                Mast3     :     casez(valid_balance)
                                                                                                    4'b0011    :    result <= Mast1 ;     // 3 2 1 0
                                                                                                    4'b0110    :    result <= Mast2 ;     // 3 2 1 0
                                                                                                    4'b1100    :    result <= Mast2 ;     // 3 2 1 0
                                                                                                    4'b1001    :    result <= Mast0 ;     // 3 2 1 0
                                                                                                    4'b1010    :    result <= Mast1 ;     // 3 2 1 0
                                                                                                    4'b0101    :    result <= Mast2 ;     // 3 2 1 0                                                                                                    
                                                                                                    4'b1111    :    result <= Mast1 ;    // if no valid balance exists for Mast0 , Mast1 will be granted access  NOTE : WILL go in loop if all Masters finish valid balance   
                                                                                                    default    :     result <= 'b1;        // ERROR CASE 
                                                                                            endcase


                                                                                default : result <= 4'b1111;        // ERROR CASE 
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
                highest_bid 	<= 'b0;
				highest_bid_en	<= 'b0;
                equal_bid    	<= 'b0;
                valid_balance   <= 'b0;

				bid_reg_0		<= 'b0;
				bid_reg_1		<= 'b0;
				bid_reg_2		<= 'b0;
				bid_reg_3		<= 'b0;				
				
            end
        else
            begin      
						
						bid_reg_0 		<=  bid_0;		// copy bid values 
						bid_reg_1 		<=  bid_1;
						bid_reg_2 		<=  bid_2;
						bid_reg_3		<=  bid_3;			

						
						highest_bid_en[0] <=  (bid[0] == 0) ? 'b0 : (valid_balance[0]==0) ? 'b0 : 'b1; 	// Ensures bid is valid and is not 0  
						highest_bid_en[1] <=  (bid[1] == 0) ? 'b0 : (valid_balance[1]==0) ? 'b0 : 'b1;
						highest_bid_en[2] <=  (bid[2] == 0) ? 'b0 : (valid_balance[2]==0) ? 'b0 : 'b1;
						highest_bid_en[3] <=  (bid[3] == 0) ? 'b0 : (valid_balance[3]==0) ? 'b0 : 'b1;
						
						
//                                               if ((bid[0] > bid[1]) && (bid[0] > bid[2]) && (bid[0] > bid[3])  )      highest_bid[0] <= 'b1;    else    highest_bid[0] <= 'b0;
//                                               if ((bid[1] > bid[0]) && (bid[1] > bid[2]) && (bid[1] > bid[3])  )      highest_bid[1] <= 'b1;    else    highest_bid[1] <= 'b0;
//                                               if ((bid[2] > bid[0]) && (bid[2] > bid[1]) && (bid[2] > bid[3])  )      highest_bid[2] <= 'b1;    else    highest_bid[2] <= 'b0;
//                                               if ((bid[3] > bid[0]) && (bid[3] > bid[1]) && (bid[3] > bid[2])  )      highest_bid[3] <= 'b1;    else    highest_bid[3] <= 'b0;

							bid_reg_0  <=  (valid_balance[0]) ? bid[0] : 'b0 ;		//  replaces bid value with 0 if balance does not exist 
							bid_reg_1  <=  (valid_balance[1]) ? bid[1] : 'b0 ;
							bid_reg_2  <=  (valid_balance[2]) ? bid[2] : 'b0 ;
							bid_reg_3  <=  (valid_balance[3]) ? bid[3] : 'b0 ;

                            if(highest_bid_en[0]) if     ((bid_reg_0  > bid_reg_1 ) && (bid_reg_0  > bid_reg_2 ) && (bid_reg_0  > bid_reg_3 )  )      highest_bid[0] <=  'b1;    else    highest_bid[0] <=  'b0;  else highest_bid[0] <=  'b0;
                            if(highest_bid_en[1]) if     ((bid_reg_1  > bid_reg_0 ) && (bid_reg_1  > bid_reg_2 ) && (bid_reg_1  > bid_reg_3 )  )      highest_bid[1] <=  'b1;    else    highest_bid[1] <=  'b0;  else highest_bid[1] <=  'b0;
                            if(highest_bid_en[2]) if     ((bid_reg_2  > bid_reg_0 ) && (bid_reg_2  > bid_reg_1 ) && (bid_reg_2  > bid_reg_3 )  )      highest_bid[2] <=  'b1;    else    highest_bid[2] <=  'b0;  else highest_bid[2] <=  'b0;
                            if(highest_bid_en[3]) if     ((bid_reg_3  > bid_reg_0 ) && (bid_reg_3  > bid_reg_1 ) && (bid_reg_3  > bid_reg_2 )  )      highest_bid[3] <=  'b1;    else    highest_bid[3] <=  'b0;  else highest_bid[3] <=  'b0;							
/*                                
                            if(highest_bid_en[0]) 
                                if     ((bid_reg_0  > bid_reg_1 ) && (bid_reg_0  > bid_reg_2 ) && (bid_reg_0  > bid_reg_3 )  )      highest_bid[0] <=  'b1;    else    highest_bid[0] <=  'b0;  
                            else 
                                highest_bid[0] <=   ((bid[0]  > bid[1] ) && (bid[0]  > bid[2] ) && (bid[0]  > bid[3] )  )    ?   'b1    :      'b0;
                                
                                                                                            
                            if(highest_bid_en[1]) 
                                if     ((bid_reg_1  > bid_reg_0 ) && (bid_reg_1  > bid_reg_2 ) && (bid_reg_1  > bid_reg_3 )  )      highest_bid[1] <=  'b1;    else    highest_bid[1] <=  'b0;  
                            else 
                                highest_bid[1] <=   ((bid[1]  > bid[0] ) && (bid[1]  > bid[2] ) && (bid[1]  > bid[3] )  )    ?   'b1    :      'b0;
                                                                
                            
                            if(highest_bid_en[2]) if     ((bid_reg_2  > bid_reg_0 ) && (bid_reg_2  > bid_reg_1 ) && (bid_reg_2  > bid_reg_3 )  )      highest_bid[2] <=  'b1;    else    highest_bid[2] <=  'b0;  
                            else 
                                highest_bid[2] <=   ((bid[2]  > bid[0] ) && (bid[2]  > bid[1] ) && (bid[2]  > bid[3] )  )    ?   'b1    :      'b0;

                                
                            if(highest_bid_en[3]) if     ((bid_reg_3  > bid_reg_0 ) && (bid_reg_3  > bid_reg_1 ) && (bid_reg_3  > bid_reg_2 )  )      highest_bid[3] <=  'b1;    else    highest_bid[3] <=  'b0;  
                            else 
                                highest_bid[3] <=   ((bid[3]  > bid[0] ) && (bid[3]  > bid[1] ) && (bid[3]  > bid[2] )  )    ?   'b1     :  'b0;

*/                                
                            
                                
                            
                            
//                                                if     ((bid[1] > bid[0]) && (bid[1] > bid[2]) && (bid[1] > bid[3])  )      highest_bid[1] <= 'b1;    else    highest_bid[1] <= 'b0;      
//                                                if     ((bid[2] > bid[0]) && (bid[2] > bid[1]) && (bid[2] > bid[3])  )      highest_bid[2] <= 'b1;    else    highest_bid[2] <= 'b0;    
//                                                if     ((bid[3] > bid[0]) && (bid[3] > bid[1]) && (bid[3] > bid[2])  )      highest_bid[3] <= 'b1;    else    highest_bid[3] <= 'b0;  

                            if     (( bid_0  == bid_1 && bid_0 !== 0  ) | ( bid_0  == bid_2   && bid_0 !== 0) | ( bid_0  == bid_3  && bid_0 !== 0)  )     equal_bid[0] <=  'b1;    else    equal_bid[0] <=  'b0; 
                            if     (( bid_1  == bid_0 && bid_1 !== 0  ) | ( bid_1  == bid_2   && bid_1 !== 0) | ( bid_1  == bid_3  && bid_1 !== 0)  )     equal_bid[1] <=  'b1;    else    equal_bid[1] <=  'b0;  
                            if     (( bid_2  == bid_0 && bid_2 !== 0  ) | ( bid_2  == bid_1   && bid_2 !== 0) | ( bid_2  == bid_3  && bid_2 !== 0)  )     equal_bid[2] <=  'b1;    else    equal_bid[2] <=  'b0;  
                            if     (( bid_3  == bid_0 && bid_3 !== 0  ) | ( bid_3  == bid_1   && bid_3 !== 0) | ( bid_3  == bid_2  && bid_3 !== 0)  )     equal_bid[3] <=  'b1;    else    equal_bid[3] <=  'b0;  
                            
                            if         (balance[0] >= bid[0])  valid_balance[0] <=  'b1; 	else  valid_balance[0] <=  'b0;
                            if         (balance[1] >= bid[1])  valid_balance[1] <=  'b1; 	else  valid_balance[1] <=  'b0;
                            if         (balance[2] >= bid[2])  valid_balance[2] <=  'b1; 	else  valid_balance[2] <=  'b0;
                            if         (balance[3] >= bid[3])  valid_balance[3] <=  'b1; 	else  valid_balance[3] <=  'b0;
                                                        
			end            
    end
    
// #################################################
always@(posedge clk or posedge rst)
    begin
        if (rst)
            begin
                count_60[0] <=  'b0;    
                count_60[1] <=  'b0;    
                count_60[2] <=  'b0;    
                count_60[3] <=  'b0;    
                serve_60    <=  'b0;
                last_serviced    <=  'b0;
            end
        else
            begin
                    last_serviced <=  result;                                        // flopping to store which master was last serviced 
                    
//                    count_60[0] <=  ((result[0]) | (bid[0] == 'b0) ) ? 'b0 : (count_60[0] +1);            // start counter to avoid 60 cycle no service error , start it even if no bid by master 
//                    count_60[1] <=  ((result[1]) | (bid[1] == 'b0) ) ? 'b0 : (count_60[1] +1);        
//                    count_60[2] <=  ((result[2]) | (bid[2] == 'b0) ) ? 'b0 : (count_60[2] +1);        
//                    count_60[3] <=  ((result[3]) | (bid[3] == 'b0) ) ? 'b0 : (count_60[3] +1);                        

                    count_60[0] <=  ((result[0]) | (bid_reg_0 == 'b0) ) ? 'b0 : (count_60[0] +1);            // start counter to avoid 60 cycle no service error , start it even if no bid by master 
                    count_60[1] <=  ((result[1]) | (bid_reg_1 == 'b0) ) ? 'b0 : (count_60[1] +1);        
                    count_60[2] <=  ((result[2]) | (bid_reg_2 == 'b0) ) ? 'b0 : (count_60[2] +1);        
                    count_60[3] <=  ((result[3]) | (bid_reg_3 == 'b0) ) ? 'b0 : (count_60[3] +1);                                            
                    
                    serve_60[0] <=  (count_60[0] == 6'd58 | serve_60_0 ==1 ) ? 'b1 : 'b0;                 // Flag to indicate which master to serve to avoid 60 cycle no service error 
                    serve_60[1] <=  (count_60[1] == 6'd58 | serve_60_1 ==1 ) ? 'b1 : 'b0;             // 
                    serve_60[2] <=  (count_60[2] == 6'd58 | serve_60_2 ==1 ) ? 'b1 : 'b0;                                     
                    serve_60[3] <=  (count_60[3] == 6'd58 | serve_60_3 ==1 ) ? 'b1 : 'b0;                                                         
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

always@(posedge clk, posedge rst)
    begin    
        if (rst)
            begin
                balance <= 750;  
                counter <=  'b0;                
            end
        else
            begin
                counter <= (counter == 400) ? 'b0 :  (counter +1);           // free running counter resets automatically  every 400 counts  
                
                if (counter == 400)            balance <= (balance > 150) ? 900 : (balance + 750);       // Adds previous balance & takes care of limits 
                else
                    if (granted )    if (balance <= 0)    balance <= 1; else balance <= (balance == 1)? 1: (((balance - bid) == 0) ?  1 : (balance - bid));      // reduces bid amount to maintain bank balance 
                    else            balance <= balance;          
            end
    end

endmodule
