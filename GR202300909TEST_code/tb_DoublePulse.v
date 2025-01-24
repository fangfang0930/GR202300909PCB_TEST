`timescale 1ns/1ps

module testbench;

  // Inputs
  reg enable;
  reg clk;
  reg TEM;

  // Outputs
  wire K1, K2;

  // Instantiate the module
  DoublePulse dut (
    .enable(enable),
    .clk(clk),
    .TEM(TEM),
    .K1(K1),
    .K2(K2)
  );

  // Clock generation
  reg clk_tb = 0;
  always #5 clk_tb = ~clk_tb;

  // Initial block
  initial begin
    // Initialize inputs
    enable = 1;
    clk = 0;
    TEM = 0;

    // Apply a reset (optional)
    #10 enable = 0;

    // Run simulation for 100 clock cycles
   // #1000 $finish;
  end

  // Clocking and stimuli
  always #1 clk = clk_tb;

  // Stimulus generation
  initial begin
    // Apply stimulus to TEM after some delay
    #20 TEM = 1;
    #50 TEM = 0;
  end

  // Monitor and display results
  always @(posedge clk) begin
    $display("Time=%0t: K1=%b, K2=%b", $time, K1, K2);
  end

endmodule
