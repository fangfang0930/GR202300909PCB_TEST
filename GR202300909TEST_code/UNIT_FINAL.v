module UNIT_FINAL(
                
               input	clk,
					input sys_rst_n,
					input	ad_in,
					output	adclk,
					input   TEM,
					input    rx,
					output   tx,
					output   cs_n,
					output	K_1 ,
					output	K_2 ,
					output	K_3 ,
					output	K_4 ,
					input  fault1,
					input  fault2,
					input  fault3,
					input  fault4,
					output	LED1,
					output	LED2,
					output	LED3,
					output	LED4,
					output	LED5//,
					//output	LED6

				);


	reg		LED1_reg,LED2_reg,LED3_reg,LED4_reg,LED5_reg;
	
	reg		[19:0]t;
	reg		[15:0]tri_200us;
    reg		[15:0]tri_20us;
	reg	 EnableOut;
	reg TEM_prev1;
	//reg      k1_start;
	wire	[15:0]volt;
	wire risingflg;
    assign LED1 = LED1_reg;
	assign LED2 = LED2_reg;
	assign LED3 = LED3_reg;
	assign LED4 = LED4_reg;
	assign LED5 = LED5_reg;
reg	pulse_out_flag;
reg  no_fault;

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
	end
always@(posedge clk) //fault1 0-故障
	begin	
	if((fault1)&(fault2)&(fault3)&(fault4))
	no_fault<=1;
	else no_fault<=0;
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
	
reg [63:0]	tri_10s;
always @(posedge clk) begin
// Detect rising edge of TEM
	if (risingflg && !TEM_prev1) begin
	 tri_10s<=1;
	 end 
	else begin 
	 if((tri_10s < 64'd200_000_000)&&(tri_10s > 0))//40'd400_000)
	   begin	    
		  tri_10s <= tri_10s + 1;
	   end
	  else if (tri_10s == 64'd200_000_000) begin
	    pulse_out_flag<=1;
		 tri_10s <= 0;
	   end
	  else  pulse_out_flag<=0;
	end
	 // Store the previous value of TEM
	 TEM_prev1 <= risingflg;
  end
  

	
DoublePulse DoublePulse1(
	   .enable ( no_fault ),
		.clk ( clk   ),
		.TEM ( pulse_out_flag ),
		.K1 ( K_1   ),
		.K2 ( K_2    )
	);
	
	 
DoublePulse DoublePulse4(
	   .enable ( no_fault ),
		.clk ( clk   ),
		.TEM ( pulse_out_flag ),
		.K1 ( K_3   ),
		.K2 ( K_4   )
		);
		
		
		
	key_filter  key_rd_inst
(
    .sys_clk    (clk    ),  //系统时钟50Mhz
    .sys_rst_n  (1  ),  //全局复位
    .key_in     (TEM     ),  //按键输入信号

    .key_flag   (risingflg  )   //key_flag为1时表示按键有效，0表示按键无效
);

   	   

	
endmodule	
	


