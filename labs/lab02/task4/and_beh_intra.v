// and_beh_intra.v
// AND gate, BEHAVIORAL style, with an INTRA-ASSIGNMENT delay.
//
// Because #5 appears inside the assignment ("y = #5 a & b;"), the RHS
// (a & b) is evaluated IMMEDIATELY using the values of a/b at the moment
// the always block triggers. Only the update to y is delayed by 5 units.
// This correctly captures the triggering values even if a/b change again
// before the delay elapses.

module and_beh_intra (
  input      a,
  input      b,
  output reg y
);

  always @(*) begin
    y = #5 a & b;
  end

endmodule