// and_beh_before.v
// AND gate, BEHAVIORAL style, with delay control BEFORE the assignment.
//
// Because #5 appears before "y = a & b;", the always block wakes up when
// a/b change, waits 5 time units, and only THEN reads a and b -- using
// whatever values they happen to have at that later time, not the values
// that originally triggered it. If a/b change again during the wait,
// this produces stale/incorrect results.

module and_beh_before (
  input      a,
  input      b,
  output reg y
);

  always @(*) begin
    #5 y = a & b;
  end

endmodule