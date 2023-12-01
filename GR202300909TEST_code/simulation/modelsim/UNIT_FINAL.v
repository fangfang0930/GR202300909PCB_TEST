module UNIT_FINAL(
                
                	input	clk,
					input	ad_in,
					output	adclk,
					output  cs_n,
					output	K_1 ,
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
	wire	[15:0]volt;
	
    assign LED1 = LED1_reg;
	assign LED2 = LED2_reg;
	assign LED3 = LED3_reg;
	assign LED4 = LED4_reg;
	assign LED5 = LED5_reg;
	
	initial
	begin
	tri_200us <= 16'b0;
	LED1_reg <=1; 
    LED2_reg <=1; 
	LED3_reg <=1;  
	LED4_reg <=1; 
	LED5_reg <=1;
	end
	
	always@(posedge clk)
	begin
	if(t < 20'hFFFFF)
		t <= t + 1'b1;
	else
		t <= 20'hFFFFF;
	end
	
	
	always@(posedge clk)
	begin
	  if(t < 20'h0FFFF)
		tri_200us <= 16'b0;
	  else 
	   begin
	     if(tri_200us < 16'd7999)
		 tri_200us <= tri_200us + 1'b1;   //hff-200US
	     else
		 begin
		 tri_200us <= 16'b0;
		 end
	   end
	end

/*
	always@(posedge clk)
	 begin
		// if(t>=20'hFFFFF)
		//  begin
			   if ((volt > 16'h1000)&&(volt >= 16'h2000)) 
			   begin  //16'h4ed8) begin   // Check if volt is greater than 2
				 LED1_reg <=1; 
			    end
			   else if((volt > 16'h2000)&&(volt >=16'h3000))
			   begin
				 LED2_reg <=1; 
				 end
			   else if((volt > 16'h3000)&&(volt >=16'h4000))
			   begin
				 LED3_reg <=1; 
				 end
			   else if((volt > 16'h4000)&&(volt >=16'h5000))
			   begin
				 LED4_reg <=1; 
				 end				 
			
			   else 
			   begin
			   LED5_reg <=1; 
			   end
	     // end
		// else 
		  // begin
			//  LED1_reg <=0; 
			  
		  //end
	end
*/
	always@(posedge clk)
	 begin
		// if(t>=20'hFFFFF)
		//  begin
		       if((volt > 16'h0000)&&(volt <=16'h6500))
			   begin
				 LED1_reg <=0; 
				 end
			  if((volt > 16'h6500)&&(volt <=16'h7500))
			   begin
				 LED2_reg <=0; 
				 end
			   else if((volt > 16'h7500)&&(volt <=16'h8500))
			   begin
				 LED3_reg <=0; 
				 end
			   else if((volt > 16'h8500)&&(volt <=16'hFFFF))
			   begin
				 LED4_reg <=0; 
				 end				 
			
			   else 
			   begin
			   LED5_reg <=0; 
			   end
	     // end
		// else 
		  // begin
			//  LED1_reg <=0; 
			  
		  //end
	end
	ad ad(clk, tri_200us, ad_in, adclk, cs_n, volt);
	
endmodule
