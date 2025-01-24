 
 module err_high_detect (
						clk			,
						rst_n		,
						time_1us    ,
						reset_unit	,
						signal_in	,
						signal_out  ,
						delay_tims	
						);
input clk			;
input rst_n			;
input time_1us    	;
input reset_unit	;
input signal_in	;
output reg signal_out	;
input [13:0]delay_tims;
// //parameter DELAY_TIMES=2;//延时判断设定值，最大为6us
initial begin
	// cnt_delay<=0;
	// signal_out<=1'b0;
    signal_in_dly <= 0;
    count <= 0;
    signal_out <= 0;
end

// reg signal_out;
// reg [13:0]cnt_delay;
// reg [1:0]time_1us_syn;
// always@(posedge clk) time_1us_syn<={time_1us_syn[0],time_1us};
// always@(posedge clk)
// begin 
// 	if(reset_unit)
// 	cnt_delay<=0;
// 	else if(!signal_in)//低电平无效
// 	cnt_delay<=0;
// 	else if(signal_in&&time_1us_syn==2'b10&&cnt_delay<14'd16383)
// 	cnt_delay<=cnt_delay+1'b1;
// end 
// always@(posedge clk)
// begin 
// 	if(reset_unit)
// 	signal_out<=1'b0;
// 	else if(cnt_delay>=delay_tims)
// 	signal_out<=1'b1;
// end 
// 消抖延迟时间设定为 10 微秒, 对应 400 个时钟周期
    parameter DEBOUNCE_TIME = 4;//80;//400;
    reg [8:0] count; // 9 位计数器，最多能计数到 511，足够处理 400

    reg signal_in_dly; // 信号输入的延迟版本，用于稳定检测

    // 同步输入信号
    always @(posedge clk) begin
        
            signal_in_dly <= signal_in;
    end

    // 消抖逻辑，计时器检测稳定信号
    always @(posedge clk) begin
            // 如果信号稳定，计数器开始计时
            if (signal_in == signal_in_dly) begin
                if (count < DEBOUNCE_TIME) begin
                    count <= count + 1;
                end else begin
                    signal_out <= signal_in_dly; // 输出去抖后的信号
                end
            end else begin
                count <= 0; // 如果信号变化，重置计数器
                signal_out <= 0; // 输出清零，表示信号不稳定
            end
    end
endmodule 