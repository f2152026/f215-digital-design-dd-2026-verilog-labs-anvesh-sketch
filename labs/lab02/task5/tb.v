// tb_alu.v
// Self-checking testbench for the 1-bit-opcode ALU.
//
// Checks two things across all 4-bit a, b combinations for both opcodes:
//  1. Correctness: result matches expected add/sub (mod 16, wraps like real HW).
//  2. Reactivity: result actually updates when op changes even if a,b don't
//     (catches an incomplete sensitivity list).

module tb_alu;

  reg  [3:0] a, b;
  reg        op;
  wire [3:0] result;
  integer    errors;
  reg  [3:0] expected;

  alu dut (
    .a      (a),
    .b      (b),
    .op     (op),
    .result (result)
  );

  task check_expected;
    begin
      #1; // let combinational logic settle
      expected = op ? (a - b) : (a + b); // 4-bit wraparound arithmetic
      if (result !== expected) begin
        $display("ERROR: a=%0d b=%0d op=%0d -> result=%0d (expected=%0d)",
                  a, b, op, result, expected);
        errors = errors + 1;
      end
    end
  endtask

  integer ai, bi;
  initial begin
    errors = 0;

    // --- Correctness sweep: all a,b combos, both opcodes ---
    for (ai = 0; ai < 16; ai = ai + 1) begin
      for (bi = 0; bi < 16; bi = bi + 1) begin
        a = ai; b = bi;
        op = 0; check_expected;  // add
        op = 1; check_expected;  // sub
      end
    end

    // --- Sensitivity-list-specific check ---
    // Hold a and b fixed, only toggle op, and make sure result updates.
    a = 4'd5; b = 4'd3;
    op = 0; #1;
    if (result !== (a + b)) begin
      $display("ERROR (sensitivity): a=%0d b=%0d op=0 -> result=%0d (expected=%0d)",
                a, b, result, a + b);
      errors = errors + 1;
    end
    op = 1; #1; // a,b unchanged -- only op changes
    if (result !== (a - b)) begin
      $display("ERROR (sensitivity): a=%0d b=%0d op=1 -> result=%0d (expected=%0d) -- did result update when only op changed?",
                a, b, result, a - b);
      errors = errors + 1;
    end

    if (errors == 0)
      $display("ALL TESTS PASSED");
    else
      $display("TESTS FAILED: %0d error(s)", errors);

    $finish;
  end

endmodule