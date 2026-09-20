// and_df.v
// AND gate, DATAFLOW style, with a 5-unit inertial delay.
// Continuous assignment delays are inertial: if a/b change and change back
// before the delay elapses, the intermediate transition is filtered out
// and never appears on y.

module and_df (
  input  a,
  input  b,
  output y
);

  assign #5 y = a & b;

endmodule