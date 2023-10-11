`default_nettype none

/* verilator lint_off UNUSEDSIGNAL */

module tt_um_short_circuit (
    input  wire [7:0] ui_in,    // Dedicated inputs - connected to the input switches
    output wire [7:0] uo_out,   // Dedicated outputs - connected to the 7 segment display
    input  wire [7:0] uio_in,   // IOs: Bidirectional Input path
    output wire [7:0] uio_out,  // IOs: Bidirectional Output path
    output wire [7:0] uio_oe,   // IOs: Bidirectional Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

	assign uo_out = 0;
	assign uio_out = 0;
	assign uio_oe = 0;

	wire magic_smoke;

	(* keep *)
	sky130_fd_sc_hd__ebufn_8 b1 (
`ifdef WITH_POWER
		.VPWR (1'b1),
		.VGND (1'b0),
		.VPB  (1'b1),
		.VNB  (1'b0),
`endif
		.A    (1'b0),
		.TE_B (ena),
		.Z    (magic_smoke)
	);

	(* keep *)
	sky130_fd_sc_hd__ebufn_8 b2 (
`ifdef WITH_POWER
		.VPWR (1'b1),
		.VGND (1'b0),
		.VPB  (1'b1),
		.VNB  (1'b0),
`endif
		.A    (1'b1),
		.TE_B (ena),
		.Z    (magic_smoke)
	);

endmodule
