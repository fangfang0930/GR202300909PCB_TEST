`timescale 1ns/1ns

module tb_UNIT_FINAL();

   reg clk;
   reg ad_in;
   wire adclk, cs_n, K_1, K_2, LED1, LED2, LED3, LED4, LED5;
   wire [15:0] volt;
  reg     TEM  ;
  reg fault1, fault2	, fault3	, fault4;
   // Clock generation
   initial begin
      clk = 0;
      forever #2 clk = ~clk;
	 
   end
  // always #50000 TEM <= {$random} % 2; /*取模求余数，产生非负随机数0、1
                                      //每隔10ns产生一次随机数*/
   // Instantiate UNIT_FINAL module
   UNIT_FINAL uut (
      .clk(clk),
      .ad_in(ad_in),
      .adclk(adclk),
      .cs_n(cs_n),
	  .TEM(TEM),
      .K_1(K_1),
	  .K_2(K_2),
      .LED1(LED1),
      .LED2(LED2),
      .LED3(LED3),
      .LED4(LED4),
      .LED5(LED5)
      //.volt(volt)
   );
  

   // Test stimulus
   initial begin
      ad_in = 0; // Set initial value for ad_in
      #10  fault1=1;
		  fault2=1;
		  fault3=1;
		  fault4=1;
      // Apply stimulus
		
      #10 ad_in = 1; // Example: Change ad_in value after 10 time units
      #20 ad_in = 0;
	 #100   TEM = 0;
      #100   TEM = 1;
      // Add more stimulus as needed

      //#1000 $finish; // Finish simulation after a certain time
   end

   // Monitor outputs
   always @(posedge clk) begin
      // Display outputs
      $display("Time=%0t adclk=%b cs_n=%b K_1=%b LED1=%b LED2=%b LED3=%b LED4=%b LED5=%b volt=%h",
               $time, adclk, cs_n, K_1, K_2,LED1, LED2, LED3, LED4, LED5, volt);
   end

endmodule
