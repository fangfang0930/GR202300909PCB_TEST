module DoublePulse (
  input enable,
  input clk,
  input TEM,
  
  output reg K1,
  output reg K2
);

reg risingflg;
reg TEM_prev1;
 
  // State definition
 // State definition
  reg [1:0] state;
  parameter IDLE_STATE = 2'b00;
  parameter HIGH_STATE = 2'b01;
  parameter LOW_STATE = 2'b10;
  parameter HIGH2_STATE = 2'b11;

  // Internal signals
  reg [31:0] dblcount;
   initial begin
     state=IDLE_STATE;
	 risingflg=0;
	 K2=0;
      // Add more stimulus as needed

      //#1000 $finish; // Finish simulation after a certain time
   end
	
  always @(posedge clk) begin
      // Detect rising edge of TEM
      if (TEM && !TEM_prev1) begin
		risingflg<=1;
      end 
      else begin
	  risingflg<=0;    
      end
    // Store the previous value of TEM
    TEM_prev1 <= TEM;
  end
   // Internal signals
  //reg [31:0] count;

  // State machine logic
  always @(posedge clk) begin
  if(enable) begin 
		case (state)
		  IDLE_STATE: begin
			if (risingflg) begin
			  state <= HIGH_STATE;
			  dblcount <= 0;
			  K1 <= 1;		  
			end
			else begin
			state <= IDLE_STATE;
			K1 <= 0;
			end
		  end

		  HIGH_STATE: begin
			if (dblcount < 31'd800) begin // 20us high	
			   K1 <= 1;	      
			  dblcount <= dblcount + 1;
			end
			else begin
			  K1 <= 0;
			  state <= LOW_STATE;
			  dblcount <= 0;
			end
		  end

		  LOW_STATE: begin
			if (dblcount < 31'd520) begin // 13us low
			  dblcount <= dblcount + 1;
			end 
			else begin
			  state <= HIGH2_STATE;
			  dblcount <= 0;
			end
		  end
		  HIGH2_STATE: begin
			if (dblcount < 31'd800) begin // 20us high	
			   K1 <= 1;		 
			  dblcount <= dblcount + 1;
			end
			else begin
			  K1 <= 0;
			  state <= IDLE_STATE;
			  dblcount <= 0;
			end
		  end
		  
		 endcase
	 end
	else begin
		K1 <= 0;
		K2 <= 0;
	end	
  end


endmodule
