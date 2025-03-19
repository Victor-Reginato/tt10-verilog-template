/*
 * Copyright (c) 2024 Victor Reginato
 * SPDX-License-Identifier: Apache-2.0
 */



`default_nettype none

module project (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // All output pins must be assigned. If not used, assign to 0.
  //assign uo_out  = ui_in + uio_in;  Example: ou_out is the sum of ui_in and uio_in
  //assign uio_out[4:7] = 4'b0000;
  assign uio_oe  = 8'b11110000;
  //assign uio_in[2:7] = 6'b000000;
  // List all unused inputs to prevent warnings
  //wire _unused = &{ena, clk, rst_n, 1'b0};
  always @(posedge clk) begin
    
  end


  SPI_Master spi_inst(
    .i_Clk(clk),
    .i_Rst_L(rst_n),
      //single pins
    .o_SPI_MOSI(uio_out[0]),
    .i_SPI_MISO(uio_in[4]),
    .o_SPI_Clk(uio_out[1]),

    .i_TX_DV(uio_in[5]),
    .o_TX_Ready(uio_out[2]),
    .o_RX_DV(uio_out[3]),
      //bytes 
    .i_TX_Byte(ui_in),
    .o_RX_Byte(uo_out)

  );

endmodule
