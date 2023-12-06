/*


module K1Module(
  input enable,
  input clk,
  input TEM,
  output reg K1,
  output reg K2
);

  reg [31:0] k1count;
  reg TEM_prev;
  reg keyflag;
  reg timflag;
  reg [15:0]tim_cnt;
 initial begin
      keyflag=0;
	   timflag=0;	
		//tim_cnt20m's=0;
		K1=0;
      K2=0;	  
   end
 always @(posedge clk) begin
    // Reset the counter on every rising edge of the clock
    if ((k1count == 32'hFFFFFFFF)||(timflag==1)) begin
      k1count <= 0;
    end 
    else begin
      k1count <= k1count + 1;
	  end
 end
	
  always @(posedge clk) begin
      // Detect rising edge of TEM
      if (TEM && !TEM_prev) begin
		 keyflag<=1;
      end 
      else 
		begin
	    keyflag<=keyflag;    
      end
    // Store the previous value of TEM
    TEM_prev <= TEM;
  end
  
  
  
  always @(posedge clk) begin
	  if(enable) begin
			if(timflag==1)
			begin 
			K1 <= 1;
			timflag<=0;
			end 
			  
			else if (K1 &&(k1count < 31'd800)) // 20us pulse duration
				  K1 <= 1;
			else if (K1 && (k1count >= 31'd800)) // Ensure K1 is 0 after pulse
				  K1 <= 0;
			else  K1 <= 0;
	   end
	   else begin
	     K1 <= 0;
		 K2 <= 0;
	   end
	   
   end
	
	//100us发一个脉冲
 always @(posedge clk) begin
   
  if(enable)begin
		 if(keyflag)
			begin
			  tim_cnt <= 16'd1;
			  timflag<=0;
			 
		 end else if((tim_cnt < 16'd4000)&&(tim_cnt>16'd0)) begin 
		 
			  tim_cnt <= tim_cnt + 1'b1;
			  
		 end else if(tim_cnt >= 16'd4000)
			begin 
			 // tim_cnt <= 16'd3999;
			  tim_cnt<=16'd1;
			  timflag<=1;
			 
		 end else 
		  begin 
			timflag<=0;
			tim_cnt<=0;
		 end 
    
	end 
	end

endmodule
*/
/*
module K1Module(
  input enable,
  input clk,
  input TEM,
  output reg K1,
  output reg K2
);

  reg [31:0] k1count;
  reg TEM_prev;
  reg keyflag;
  reg timflag;
  reg [15:0]tim_cnt;

  initial begin
    keyflag = 0;
    timflag = 0;
    K1 = 0;
    K2 = 0;
  end

  always @(posedge clk) begin
    // Reset the counter on every rising edge of the clock
    if ((k1count == 32'hFFFFFFFF) || (timflag == 1)) begin
      k1count <= 0;
    end 
    else begin
      k1count <= k1count + 1;
    end
  end

  always @(posedge clk) begin
    // Detect rising edge of TEM
    if (TEM && !TEM_prev) begin
      keyflag <= 1;
    end 
    else begin
      keyflag <= 0;//keyflag;    
    end
    // Store the previous value of TEM
    TEM_prev <= TEM;
  end

  // Generate a pulse every 100 microseconds
  always @(posedge clk) begin
    if (enable) begin
      if (keyflag) begin
        tim_cnt <= 16'd1;
        timflag <= 0;
      end 
      else if ((tim_cnt < 16'd4000) && (tim_cnt > 16'd0)) begin
        tim_cnt <= tim_cnt + 1'b1;
      end 
      else if (tim_cnt >= 16'd4000) begin
        tim_cnt <= 16'd1;
        timflag <= 1;
      end 
      else begin
        timflag <= 0;
        tim_cnt <= 0;
      end
    end
  end

  // Generate a 20us pulse every 100us
  always @(posedge clk) begin
    if (enable) begin
      if (timflag) begin
        if (k1count < 31'd800) begin
          K1 <= 1;
        end 
        else begin
          K1 <= 0;
        end
      end
      else begin
        K1 <= 0;
      end
    end
    else begin
      K1 <= 0;
      K2 <= 0;
    end
  end
endmodule


module K1Module(
  input enable,
  input clk,
  input TEM,
  output reg K1,
  output reg K2
);

  reg [31:0] k1count;
  reg TEM_prev;
  reg keyflag;
  reg timflag;
  reg [15:0]tim_cnt;

  initial begin
    keyflag = 0;
    timflag = 0;
    K1 = 0;
    K2 = 0;
  end

  always @(posedge clk) begin
    // Reset the counter on every rising edge of the clock
    if ((k1count == 32'hFFFFFFFF) || (timflag == 1)) begin
      k1count <= 0;
    end 
    else begin
      k1count <= k1count + 1;
    end
  end

  always @(posedge clk) begin
    // Detect rising edge of TEM
    if (TEM && !TEM_prev) begin
      keyflag <= 1;
    end 
    else begin
      keyflag <= 0; // Set keyflag to 0 if no rising edge
    end
    // Store the previous value of TEM
    TEM_prev <= TEM;
  end

  // Generate a pulse every 100 microseconds
  always @(posedge clk) begin
    if (enable) begin
      if (keyflag) begin
        tim_cnt <= 16'd1;
        timflag <= 0;
      end 
      else if ((tim_cnt < 16'd4000) && (tim_cnt > 16'd0)) begin
        tim_cnt <= tim_cnt + 1'b1;
      end 
      else if (tim_cnt >= 16'd4000) begin
        tim_cnt <= 16'd1;
        timflag <= 1;
      end 
      else begin
        timflag <= 0;
        tim_cnt <= 0;
      end
    end
  end

  // Generate a 20us pulse every 100us
  always @(posedge clk) begin
    if (enable) begin
      if (timflag) begin
        if (k1count < 31'd800) begin
          K1 <= 1;
        end 
        else begin
          K1 <= 0;
        end
      end
      else begin
        K1 <= 0;
      end
    end
    else begin
      K1 <= 0;
      K2 <= 0;
    end
  end
endmodule

*/

module K1Module(
  input enable,
  input clk,
  input TEM,
  output reg K1,
  output reg K2
);

  reg [31:0] k1count;
  reg [31:0] tim_cnt;
  reg [31:0] pulse_duration; // Counter to control pulse duration
  reg timflg;
  reg keyflag;
  reg startflag;
  reg TEM_prev;
  initial begin
    K1 = 0;
    K2 = 0;
    k1count = 0;
    tim_cnt = 0;
	 //senable=0;
	 timflg=0;
    pulse_duration = 16'h0000; // Set initial pulse duration
  end

  always @(posedge clk) begin
    // Reset the counter on every rising edge of the clock
    if (k1count == 32'hFFFFFFFF) begin
      k1count <= 0;
    end 
    else begin
      k1count <= k1count + 1;
    end
  end

  // Generate a pulse every 100 microseconds
  always @(posedge clk) begin
   // if (enable) begin

	   if (tim_cnt < 32'd800000)begin //&& (tim_cnt > 16'd0)) begin
        tim_cnt <= tim_cnt + 1'b1;
		  timflg <= 0;
      end 
      else if (tim_cnt >= 32'd800000) begin
        tim_cnt <= 16'd0;
		  timflg <=1;
      end 
      else begin
        tim_cnt <= 0;
      end
		
  end

  // Generate a 20us pulse every 100us
  always @(posedge clk) begin
   // if (enable) begin
	if (startflag) begin
      if (timflg==1) begin
        // Reset pulse duration counter at the beginning of each 100us period
        pulse_duration <= 4'b1;
		end
		else if((pulse_duration < 16'd4000) && (pulse_duration > 16'd0)) begin
        pulse_duration <= pulse_duration + 1;
        K1 <= 1; 
		end
		else begin
		  K1<=0;
      end
   end
   else begin
      K1 <= 0;
      K2 <= 0;
    end
   end
  
 always @(posedge clk) begin
    // Detect rising edge of TEM
    if (TEM && !TEM_prev) begin
      keyflag <= 1;
    end 
    else begin
      keyflag <= 0; // Set keyflag to 0 if no rising edge
    end
    // Store the previous value of TEM
    TEM_prev <= TEM;
  end
  
 always @(posedge keyflag) begin
  startflag=1;
  end
  
endmodule
