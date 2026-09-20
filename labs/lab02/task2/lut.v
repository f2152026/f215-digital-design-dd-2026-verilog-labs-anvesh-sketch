// lut.v
// A small parameterized ROM (lookup table): DEPTH words, each WIDTH bits
// wide. dout continuously reflects mem[sel].
//
// YOU complete the two TODOs below. Everything else is given.

module lut #(
  parameter WIDTH = 8,
  parameter DEPTH = 4
) (
  input      [$clog2(DEPTH)-1:0] sel,
  output reg [WIDTH-1:0]         dout
);

  reg [WIDTH-1:0] mem [0:DEPTH-1];

  integer i;

  // Initialize mem[i] = i*i for every i from 0 to DEPTH-1.
  // Done once in an initial block with a for loop -- ROM contents are
  // fixed at "power-up" and never written again.
  initial begin
    for (i = 0; i < DEPTH; i = i + 1)
      mem[i] = i * i;
  end

  // Make dout continuously reflect mem[sel]. This is a combinational
  // read, so use always @(*) with a plain (non-clocked, non-edge)
  // sensitivity list so dout updates any time sel (or mem) changes.
  always @(*) begin
    dout = mem[sel];
  end

endmodule