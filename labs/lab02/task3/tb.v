// tb_comp2.v
// Self-checking testbench for the 2-bit unsigned magnitude comparator.
//
// For every combination of A, B (4 x 4 = 16 combos), checks two things:
//  1. Exactly one of {GT, LT, EQ} is 1 (one-hot output) for any input.
//  2. The asserted output matches the actual numeric relationship of A, B.

module tb_comp2;

  reg  [1:0] A, B;
  wire       GT, LT, EQ;
  integer    a, b;
  integer    errors;
  integer    onehot_count;

  comp2 dut (
    .A  (A),
    .B  (B),
    .GT (GT),
    .LT (LT),
    .EQ (EQ)
  );

  initial begin
    errors = 0;

    for (a = 0; a < 4; a = a + 1) begin
      for (b = 0; b < 4; b = b + 1) begin
        A = a;
        B = b;
        #1; // let combinational logic settle

        // Check 1: exactly one of GT, LT, EQ must be 1
        onehot_count = GT + LT + EQ;
        if (onehot_count != 1) begin
          $display("ERROR: A=%0d B=%0d -> GT=%b LT=%b EQ=%b  (expected exactly one of GT/LT/EQ to be 1, got %0d)",
                    A, B, GT, LT, EQ, onehot_count);
          errors = errors + 1;
        end

        // Check 2: the asserted output must match the actual relationship
        if (A > B && !(GT == 1'b1 && LT == 1'b0 && EQ == 1'b0)) begin
          $display("ERROR: A=%0d B=%0d (A>B) -> GT=%b LT=%b EQ=%b  (expected GT=1,LT=0,EQ=0)",
                    A, B, GT, LT, EQ);
          errors = errors + 1;
        end
        else if (A < B && !(GT == 1'b0 && LT == 1'b1 && EQ == 1'b0)) begin
          $display("ERROR: A=%0d B=%0d (A<B) -> GT=%b LT=%b EQ=%b  (expected GT=0,LT=1,EQ=0)",
                    A, B, GT, LT, EQ);
          errors = errors + 1;
        end
        else if (A == B && !(GT == 1'b0 && LT == 1'b0 && EQ == 1'b1)) begin
          $display("ERROR: A=%0d B=%0d (A==B) -> GT=%b LT=%b EQ=%b  (expected GT=0,LT=0,EQ=1)",
                    A, B, GT, LT, EQ);
          errors = errors + 1;
        end
      end
    end

    if (errors == 0)
      $display("ALL TESTS PASSED");
    else
      $display("TESTS FAILED: %0d error(s)", errors);

    $finish;
  end

endmodule