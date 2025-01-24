module DoublePulse (
  input enable,
  input clk,
  input TEM,
  
  output reg K1,
  output reg K2
);
parameter SHAKE_TIMES=2;//防抖延时时间，单位1us
parameter WORK_DELAY_TIMES=249;//开始检测延时时间，单位1us

initial begin
sigin_syn =0;
cnt_1us =8'd0;
cnt_shake =8'd0;
cnt_lowshake =8'd0;	
K1 =1'b0;
K2 =1'b0;
end

reg [1:0]sigin_syn;
reg [7:0]cnt_work_delay;//工作使能延时计时器
reg [7:0]cnt_1us;
reg [7:0]cnt_shake;//防抖高电平定时器时间
reg [7:0]cnt_lowshake;//防抖低电平定时器时间

always@(posedge clk)
begin 
	sigin_syn<={sigin_syn[0],TEM};
end 
//-------------1us定时器
always@(posedge clk)
begin
	if(sigin_syn[0]!=sigin_syn[1])
	cnt_1us<=8'd0;
	else if(cnt_1us==8'd99)
	cnt_1us<=8'd0;
	else 
	cnt_1us<=cnt_1us+1'b1;
end 

always@(posedge clk)  //信号变高时间计算
begin 
	if(~sigin_syn[1])
	cnt_shake<=8'd0;
	else if(cnt_shake<8'd250&&cnt_1us==8'd99)
	cnt_shake<=cnt_shake +1'b1;
end

always@(posedge clk)  //信号变低时间计算
begin 
	if(sigin_syn[1])
	cnt_lowshake<=8'd0;
	else if(cnt_lowshake<8'd250&&cnt_1us==8'd99)
	cnt_lowshake<=cnt_lowshake +1'b1;
end

 
always@(posedge clk)
begin 
	if((cnt_shake>(SHAKE_TIMES))) begin
		K1<=1'b0;
		K2<=1'b0;	
	end
	else if((cnt_lowshake>(SHAKE_TIMES)))begin
		K1 <= 1'b1;
		K2 <= 1'b1;	
	end
	
end 
// reg risingflg;
// reg TEM_prev1;
 
//   // State definition
//  // State definition
//   reg [1:0] state;
//   parameter IDLE_STATE = 2'b00;
//   parameter HIGH_STATE = 2'b01;
//   parameter LOW_STATE = 2'b10;
//   parameter HIGH2_STATE = 2'b11;

//   // Internal signals
//   reg [31:0] dblcount;
//    initial begin
//      state=IDLE_STATE;
// 	 risingflg=0;
// 	 K2=0;
//       // Add more stimulus as needed

//       //#1000 $finish; // Finish simulation after a certain time
//    end
	
//   always @(posedge clk) begin
//       // Detect rising edge of TEM
//       if (TEM && !TEM_prev1) begin
// 		risingflg<=1;
//       end 
//       else begin
// 	  risingflg<=0;    
//       end
//     // Store the previous value of TEM
//     TEM_prev1 <= TEM;
//   end
//    // Internal signals
//   //reg [31:0] count;

//   // State machine logic
//   always @(posedge clk) begin
//   if(enable) begin 
// 		case (state)
// 		  IDLE_STATE: begin
// 			if (risingflg) begin
// 			  state <= HIGH_STATE;
// 			  dblcount <= 0;
// 			  K1 <= 1;		  
// 			end
// 			else begin
// 			state <= IDLE_STATE;
// 			K1 <= 0;
// 			end
// 		  end

// 		  HIGH_STATE: begin
// 			if (dblcount < 31'd800) begin // 30us high	
// 			   K1 <= 1;	      
// 			  dblcount <= dblcount + 1;
// 			end
// 			else begin
// 			  K1 <= 0;
// 			  state <= LOW_STATE;
// 			  dblcount <= 0;
// 			end
// 		  end

// 		  LOW_STATE: begin
// 			if (dblcount < 31'd400) begin // 20us low
// 			  dblcount <= dblcount + 1;
// 			end 
// 			else begin
// 			  state <= HIGH2_STATE;
// 			  dblcount <= 0;
// 			end
// 		  end
// 		  HIGH2_STATE: begin
// 			if (dblcount < 31'd800) begin // 30us high	
// 			   K1 <= 1;		 
// 			  dblcount <= dblcount + 1;
// 			end
// 			else begin
// 			  K1 <= 0;
// 			  state <= IDLE_STATE;
// 			  dblcount <= 0;
// 			end
// 		  end
		  
// 		 endcase
// 	 end
// 	else begin
// 		K1 <= 0;
// 		K2 <= 0;
// 	end	
//   end


endmodule
