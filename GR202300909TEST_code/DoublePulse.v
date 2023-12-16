module DoublePulse (
  input enable,
  input clk,
  input TEM,
  
  output reg K1,
  output reg K2
);

//reg risingflg;
//reg TEM_prev1;
 
  // State definition
 // State definition
  reg [2:0] state;
  parameter IDLE_STATE = 3'd0;
  parameter HIGH1_STATE = 3'd1;
  parameter LOW1_STATE = 3'd2;
  parameter HIGH2_STATE = 3'd3;

  parameter LOW2_STATE = 3'd4;
  parameter HIGH3_STATE = 3'd5;
  // Internal signals
  reg [63:0] dblcount;
  
  initial begin
     state=IDLE_STATE;
	
	 K2<=0;

   end
	



  // State machine logic

  always @(posedge clk) begin

		case (state)
		  IDLE_STATE: begin
			if (TEM) begin
			  state <= HIGH1_STATE;
			  dblcount <= 0;
			  K1 <= 1;		  
			end
			else begin
			state <= IDLE_STATE;
			K1 <= 0;
			end
		  end

		  HIGH1_STATE: begin
			if (dblcount < 63'd1200) begin // 30us high
			//   if(enable)	
			   K1 <= 1;	
           // else K1 <= 0;		
			  dblcount <= dblcount + 1;
			end
			else begin
			  K1 <= 0;
			  state <= LOW1_STATE;
			  dblcount <= 0;
			end
		  end

		  LOW1_STATE: begin
			if (dblcount < 63'd800)begin //5US//d800) begin // 20us low
			  dblcount <= dblcount + 1;
			   K1 <= 0;	
			end 
			else begin
			  state <= HIGH2_STATE;
			  dblcount <= 0;
			end
		  end
		  HIGH2_STATE: begin
			if (dblcount < 63'd1200) begin // 30us high	
				if(enable)	
			    K1 <= 1;
		      else K1<=0;		 
			   dblcount <= dblcount + 1;
			end
			else begin
			  K1 <= 0;
			  state <= LOW2_STATE;
			  dblcount <= 0;
			end
		  end
		  LOW2_STATE:begin //5s		  
			  if (dblcount < 63'd200_000_000) begin // 5s
						
					K1 <= 0;		 
					dblcount <= dblcount + 1;
				end
				else begin
				  K1 <= 0;
				  state <=IDLE_STATE ;
				  dblcount <= 0;
				end
		  end
		 endcase
	// end
	//else begin
	//	K1 <= 0;
	//	K2 <= 0;
	//end	
  end
   always @(posedge clk) begin
	 K2 <= 0;
	end
  /*
 always @(posedge clk) begin
		case (state)
		  IDLE_STATE: begin
			if (TEM) begin
			  state <= HIGH1_STATE;
			  dblcount <= 0;
			  K1 <= 1;		  
			end
			else begin
			state <= IDLE_STATE;
			K1 <= 0;
			end
		  end

		  HIGH1_STATE: begin
			if (dblcount < 31'd200) begin // 5us high
			//   if(enable)	
			   K1 <= 1;	
           // else K1 <= 0;		
			  dblcount <= dblcount + 1;
			end
			else begin
			  K1 <= 0;
			  state <= LOW1_STATE;
			  dblcount <= 0;
			end
		  end

		  LOW1_STATE: begin
			if (dblcount < 31'd4000)begin //100us low
			  dblcount <= dblcount + 1;
			end 
			else begin
			  state <= HIGH2_STATE;
			  dblcount <= 0;
			end
		  end
		  HIGH2_STATE: begin // 30us high
			if (dblcount < 31'd1200) begin // 30us high	
				if(enable)	
			    K1 <= 1;
		      else  K1 <= 0;		 
			   dblcount <= dblcount + 1;
			end
			else begin
			  K1 <= 0;
			  state <= LOW2_STATE;
			  dblcount <= 0;
			end
			end
		 LOW2_STATE: begin // 20US LOW
			if (dblcount < 31'd800) begin // 	
					 
			   dblcount <= dblcount + 1;
			end
			else begin
			  K1 <= 0;
			  state <= HIGH3_STATE;
			  dblcount <= 0;
			end
		  end
		 HIGH3_STATE: begin // 30us high
			if (dblcount < 31'd1200) begin // 30us high	
				if(enable)	
			    K1 <= 1;
		       else 		  K1 <= 0;
			   dblcount <= dblcount + 1;
			end
			else begin
			  K1 <= 0;
			  state <= IDLE_STATE;
			  dblcount <= 0;
			end
		end
		  
		 endcase
	// end
	//else begin
	//	K1 <= 0;
	//	K2 <= 0;
	//end	
  end

*/
endmodule
