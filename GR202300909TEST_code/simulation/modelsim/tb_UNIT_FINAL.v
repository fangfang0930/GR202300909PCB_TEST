`timescale 1ns/1ns

module tb_UNIT_FINAL();

   reg clk;
   reg ad_in;
   wire adclk, cs_n, K_1, LED1, LED2, LED3, LED4, LED5;
   wire [15:0] volt;

   // Instantiate UNIT_FINAL module
   UNIT_FINAL uut (
      .clk(clk),
      .ad_in(ad_in),
      .adclk(adclk),
      .cs_n(cs_n),
      .K_1(K_1),
      .LED1(LED1),
      .LED2(LED2),
      .LED3(LED3),
      .LED4(LED4),
      .LED5(LED5),
      .volt(volt)
   );

   // Clock generation
   initial begin
      clk = 0;
      forever #5 clk = ~clk;
   end

   // Test stimulus
   initial begin
      ad_in = 0; // Set initial value for ad_in

      // Apply stimulus
      #10 ad_in = 1; // Example: Change ad_in value after 10 time units
      #20 ad_in = 0;

      // Add more stimulus as needed

      //#1000 $finish; // Finish simulation after a certain time
   end

   // Monitor outputs
   always @(posedge clk) begin
      // Display outputs
      $display("Time=%0t adclk=%b cs_n=%b K_1=%b LED1=%b LED2=%b LED3=%b LED4=%b LED5=%b volt=%h",
               $time, adclk, cs_n, K_1, LED1, LED2, LED3, LED4, LED5, volt);
   end

endmodule
