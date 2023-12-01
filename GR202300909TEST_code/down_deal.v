
module DoublePulse(
  input clk,
  input TEM,
  output reg K1
);

  reg [31:0] dbl_count;
  reg pulse_state;

  always @(posedge clk) begin
    // Counter to measure time
    if (dbl_count == 32'hFFFFFFFF) begin
      dbl_count <= 0;
    end 
	else begin
      dbl_count <= dbl_count + 1;
    end
  end

  always @(posedge TEM) begin
    // On every rising edge of TEM
    if (!pulse_state && (dbl_count <  31'd800 )) begin // 20us high
      K1 <= 1;
    end
	else if (pulse_state && (dbl_count < 31'd520 )) begin // 13us low
      K1 <= 0;
    end
	else if (!pulse_state && (dbl_count < 31'd1320)) begin // 20us high (total 20us + 13us)
      K1 <= 1;
    end 
	else begin
      K1 <= 0;
      pulse_state <= ~pulse_state; // Toggle pulse state
      dbl_count <= 0;
    end
  end

endmodule
	
	