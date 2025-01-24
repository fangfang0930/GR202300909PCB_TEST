module UNIT_FINAL(
                
               input	clk,
					input sys_rst_n,
					input	ad_in,
					output	adclk,
					input   TEM,
					input    rx,

					input [3:0]ERR,//left igbt err   1 active 

					output   tx,
					output   cs_n,
					output	K_1 ,
					output	K_2 ,
					output	K_3 ,
					output	K_4 ,
					output	LED1,
					output	LED2,
					output	LED3,
					output	LED4,
					output	LED5,//,
					output	LED7,//,
					output	LED8,//,
					output	LED9,//,
					output	LED10//,
					//output	LED6

				);


	reg		LED1_reg,LED2_reg,LED3_reg,LED4_reg,LED5_reg;
	
	reg		[19:0]t;
	reg		[15:0]tri_200us;
    reg		[15:0]tri_20us;
	reg	 EnableOut;
	//reg      k1_start;
	wire	[15:0]volt;
	
    assign LED1 = LED1_reg;
	assign LED2 = LED2_reg;
	assign LED3 = LED3_reg;
	assign LED4 = LED4_reg;
	assign LED5 = LED5_reg;
wire [3:0] igbt_err;
assign LED7=~igbt_err[3];//ERR[0];	
assign LED8=~igbt_err[2];
assign LED9=~igbt_err[1];	
assign LED10=~igbt_err[0];//
	
	
	
	initial
	begin
	tri_200us <= 16'b0;
	LED1_reg <=1; 
    LED2_reg <=1; 
	LED3_reg <=1;  
	LED4_reg <=1; 
	LED5_reg <=1;
	EnableOut<=0;
	//K_1<=0;
	cnt_time<=0;
	cnt_time1ms<=0;
    cnt_time100ns <= 0;

	end

	///
always@(posedge clk)
	begin
	if(t < 20'hFFFFF)
		t <= t + 1'b1;
	else
		t <= 20'hFFFFF;
	end
	
	
always@(posedge clk)
	begin
	  if(t < 20'h0FFF)
		tri_200us <= 16'b0;
	  else 
	   begin
	     if(tri_200us < 16'd7999)//hff-200US
		 tri_200us <= tri_200us + 1'b1;   
	     else
		 begin
		 tri_200us <= 16'b0;
		 end
	   end
	end

	ad ad
	(   .clk      (clk     ),   
		.t_data(tri_200us),
		.ad_in    (ad_in   ),
		.adclk    (adclk   ),
		.cs_n     (cs_n    ),
 		.volt     (volt    )
	);
		always@(posedge clk)
	 begin
		 if(t>=20'hFFFF)
		    begin
		       if((volt > 16'h0000)&&(volt <=16'h0860))
			   begin
				  LED4_reg <=0; 
				  EnableOut<=0;
				 end		
			   else if((volt > 16'h800)&&(volt <=16'h8b0))//<670v
			   begin
			      LED1_reg <=1; 
				  LED2_reg <=1; 
				
				  LED4_reg <=1; 
				  LED5_reg <=1;
				  LED3_reg <=0; 
				  EnableOut<=0;
				 end
			   else if((volt > 16'h8b0)&&(volt <=16'hc0c))//660v~900v  670v-8cc
			   begin
			      LED1_reg <=1; 
				 
				  LED3_reg <=1; 
				  LED4_reg <=1; 
				  LED5_reg <=1;
				  LED2_reg <=0; 
				  EnableOut<=1;
				 end				 
			  else if(volt > 16'hc0c)///900v
			   begin
			   
				  LED2_reg <=1; 
				  LED3_reg <=1; 
				  LED4_reg <=1; 
				  LED5_reg <=1;
				  LED1_reg <=0; 
				  
				  EnableOut<=0;
				 end
			  else 
			   begin
			      LED1_reg <=1; 
				  LED2_reg <=1; 
				  LED3_reg <=1; 
				  LED4_reg <=1; 
				  LED5_reg <=1;  
				  EnableOut<=0;
			end   end
	      
		 else 
		   begin
			  LED1_reg <=1; 
			  LED2_reg <=1; 
			  LED3_reg <=1; 
			  LED4_reg <=1; 
			  LED5_reg <=1; 
			  EnableOut<=0;
		  end
	end
DoublePulse DoublePulse1(
	    .enable ( 1   ),
		.clk ( clk   ),
		.TEM ( TEM   ),
		.K1 ( K_1   ),
		.K2 ( K_2    )
	);
	
	 
	DoublePulse DoublePulse4(
		.enable ( 1   ),
		.clk ( clk   ),
		.TEM ( TEM   ),
		.K1 ( K_3   ),
		.K2 ( K_4   )
		);

   	   
   rs232  rs232
(
   . sys_clk   (clk  ) ,   //系统时钟50MHz
   . sys_rst_n (sys_rst_n) ,   //全局复位
   . rx        (rx       ) ,   //串口接收数据
   . tx        (tx       )     //串口发送数据
);
  
wire time_1us;
wire time_1ms;	
wire time_100ns;

parameter COUNT_1US=39;
parameter COUNT_1MS=999;
parameter COUNT_100NS = 3;

reg [5:0]cnt_time;
reg	[10:0]cnt_time1ms;
reg [3:0] cnt_time100ns;

always@(posedge clk)
begin 
	if(cnt_time==COUNT_1US)
	cnt_time<=0;
	else 
	cnt_time<=cnt_time+1'b1;
end 

always@(posedge clk)
begin 
	if(cnt_time1ms==COUNT_1MS)
	cnt_time1ms<=0;
	else if(cnt_time==COUNT_1US) 
	cnt_time1ms<=cnt_time1ms+1'b1;
end 

always @(posedge clk)
begin
    if (cnt_time100ns == COUNT_100NS)
        cnt_time100ns <= 0;
    else
        cnt_time100ns <= cnt_time100ns + 1'b1;
end

assign time_1us = (cnt_time>6'd19)?1'b1:1'b0;
assign time_1ms = (cnt_time1ms>11'd499)?1'b1:1'b0; 
//assign time_100ns = (cnt_time100ns == 4'd3) ? 1'b1 : 1'b0;
assign time_100ns = (cnt_time100ns > 4'd3) ? 1'b1 : 1'b0;

err_high_detect err1(
						.clk(clk),
						.rst_n(rst_n),
						.time_1us(time_100ns),//time_1us),
						.reset_unit(reset_unit),
						.signal_in(~ERR[0]),
						.signal_out(igbt_err[0]),
						.delay_tims(1)//输入范围为1~16383 
						);
err_high_detect err2(
						.clk(clk),
						.rst_n(rst_n),
						.time_1us(time_100ns),//time_1us),
						.reset_unit(reset_unit),
						.signal_in(~ERR[1]),
						.signal_out(igbt_err[1]),
						.delay_tims(1)//输入范围为1~16383 
						);
err_high_detect err3(
						.clk(clk),
						.rst_n(rst_n),
						.time_1us(time_100ns),//time_1us),
						.reset_unit(reset_unit),
						.signal_in(~ERR[2]),
						.signal_out(igbt_err[2]),
						.delay_tims(1)//输入范围为1~16383 
						);
err_high_detect err4(
						.clk(clk),
						.rst_n(rst_n),
						.time_1us(time_100ns),//time_1us),
						.reset_unit(reset_unit),
						.signal_in(~ERR[3]),
						.signal_out(igbt_err[3]),
						.delay_tims(1)//输入范围为1~16383 
						);	
endmodule	
	


