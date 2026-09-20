// tb.v
// Starter testbench template -- YOU complete this file.
//
// Goal: apply all 8 combinations of I0, I1, S (5 time units apart) to DUT
// and observe the output. Fill in every TODO below.

module tb;

  // DUT inputs are driven by procedural code, so they must be variables (reg).
  reg   t_i0, t_i1, t_s;
  // DUT output is driven by the DUT's internal logic, so it must be a net (wire).
  wire  t_y;

  // Instantiate DUT, connecting t_i0, t_i1, t_s, t_y to its ports
  DUT DUT (
    .I0 (t_i0),
    .I1 (t_i1),
    .S  (t_s),
    .Y  (t_y)
  );

  // Waveform dump configuration
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  initial begin
    // Apply all 8 combinations of t_i0, t_i1, t_s, 5 time units apart
    t_i0 = 0; t_i1 = 0; t_s = 0;
    #5;
    t_i0 = 0; t_i1 = 0; t_s = 1;
    #5;
    t_i0 = 0; t_i1 = 1; t_s = 0;
    #5;
    t_i0 = 0; t_i1 = 1; t_s = 1;
    #5;
    t_i0 = 1; t_i1 = 0; t_s = 0;
    #5;
    t_i0 = 1; t_i1 = 0; t_s = 1;
    #5;
    t_i0 = 1; t_i1 = 1; t_s = 0;
    #5;
    t_i0 = 1; t_i1 = 1; t_s = 1;
    #5;
    $finish;
  end

  initial
    $monitor($time, " I0=%b I1=%b S=%b | Y=%b", t_i0, t_i1, t_s, t_y);

endmodule