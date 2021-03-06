//============================================================================//
//                                                                            //
//      Clock Domain Crosser test bench                                       //
//                                                                            //
//      Module name: clk_domain_crosser_tb                                    //
//      Desc: runs and tests the clk_domain_crosser module                    //
//      Date: Jan 2014                                                        //
//      Developer: Wesley New                                                 //
//      Licence: GNU General Public License ver 3                             //
//      Notes:                                                                //
//                                                                            //
//============================================================================//

module clk_domain_crosser_tb;

   //===================
   // local parameters
   //===================
   localparam LOCAL_DATA_WIDTH = `ifdef DATA_WIDTH `DATA_WIDTH `else 32 `endif;

   //=============
   // local regs
   //=============
   reg in_clk;
   reg out_clk;
   reg rst;
   reg [LOCAL_DATA_WIDTH-1:0] data_in;
   
   //==============
   // local wires
   //==============
   wire [LOCAL_DATA_WIDTH-1:0] data_out;

   //=====================================
   // instance, "(d)esign (u)nder (t)est"
   //=====================================
   clk_domain_crosser #(
      .DATA_WIDTH   (`ifdef DATA_WIDTH `DATA_WIDTH `else 32 `endif)
   ) dut (
      .in_clk    (in_clk),
      .out_clk   (out_clk),
      .rst       (rst),
      .data_in   (data_in),
      .data_out  (data_out)
   );

   //=============
   // initialize
   //=============
   initial begin
      $dumpvars;
      in_clk  = 0;
      out_clk = 0;
      rst     = 0;

      data_in = 32'h1234EFEF;
      #4
      data_in = 32'hEEEEEEEE;
      #4
      data_in = 32'h1F184FE4;
      #4
      data_in = 32'h11111111;
      #4
      data_in = 32'h1F1F1F1F;
      #4
      data_in = 32'h1234EFEF;
      #16
      $finish;
   end

   //====================
   // simulate the clock
   //====================
   always #1 begin
      in_clk = ~in_clk;
   end
   always #2 begin
      out_clk = ~out_clk;
   end

   //===============
   // print output
   //===============
   always @(posedge in_clk) begin
      $display(data_out);
   end
   
endmodule
