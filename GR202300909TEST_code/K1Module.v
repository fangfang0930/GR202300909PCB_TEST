


module K1Module(
  input enable,
  input clk,
  input TEM,
  output reg K1,
  output reg K2
);

  reg [31:0] k1count;
  reg TEM_prev;
  reg startflag;
 initial begin
      startflag=0;	
      K2=0;	  
   end
 always @(posedge clk) begin
    // Reset the counter on every rising edge of the clock
    if ((k1count == 32'hFFFFFFFF)||(startflag==1)) begin
      k1count <= 0;
    end 
    else begin
      k1count <= k1count + 1;
	  end
 end
	
  always @(posedge clk) begin
      // Detect rising edge of TEM
      if (TEM && !TEM_prev) begin
		startflag<=1;
      end 
      else begin
	  startflag<=0;    
      end
    // Store the previous value of TEM
    TEM_prev <= TEM;
  end
  
  always @(posedge clk) begin
	  if(enable) begin
			if(	startflag==1)
			  K1 <= 1;
			else if (K1 &&(k1count < 31'd4000)) // 2us pulse duration
				  K1 <= 1;
			else if (K1 && (k1count >= 31'd4000)) // Ensure K1 is 0 after pulse
				  K1 <= 0;
			else  K1 <= 0;
	   end
	   else begin
	     K1 <= 0;
		 K2 <= 0;
	   end
	   
   end
endmodule

