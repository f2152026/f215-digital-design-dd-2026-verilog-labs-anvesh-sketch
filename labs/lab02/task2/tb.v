// tb.v
// Starter testbench template -- YOU complete this file.

module tb;

  // DUT input is driven procedurally -> reg. Output is driven by DUT -> wire.
  reg  [1:0] t_sel;
  wire [7:0] t_dout;

  // Instantiate DUT (instance name must be DUT, since $dumpvars below
  // references it by that name)
  DUT DUT (
    .sel  (t_sel),
    .dout (t_dout)
  );

  // Waveform dump configuration (DO NOT CHANGE)
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  initial begin
    // Apply all 4 combinations of t_sel (0 through 3), 5 time units apart
    t_sel = 0; #5;
    t_sel = 1; #5;
    t_sel = 2; #5;
    t_sel = 3; #5;
    $finish;
  end

  initial
    $monitor($time, " sel=%0d | dout=%0d", t_sel, t_dout);

endmodule