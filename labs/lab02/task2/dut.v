// dut.v
// Wrapper so tb.v can instantiate a generic "DUT" for the lut module.

module DUT (
  input      [1:0] sel,
  output     [7:0] dout
);

  lut #(
    .WIDTH (8),
    .DEPTH (4)
  ) U1 (
    .sel  (sel),
    .dout (dout)
  );

endmodule