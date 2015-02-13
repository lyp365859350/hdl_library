//============================================================================//
//                                                                            //
//      Parameterize FIFO Delay                                               //
//                                                                            //
//      Module name: fifo_delay                                               //
//      Desc: parameterized FIFO delay, which creates a varible length delay  //
//            of variable width                                               //
//      Date: April 2012                                                      //
//      Developer: Wesley New                                                 //
//      Licence: GNU General Public License ver 3                             //
//      Notes:                                                                //
//                                                                            //
//============================================================================//

module fifo_delay #(
      //=============
      // Parameters
      //=============
      parameter DATA_WIDTH   = 32,
      parameter DELAY_CYCLES = 1
   ) (
      //=====================
      // Input/Output Ports
      //=====================
      input                   clk,
      input  [DATA_WIDTH-1:0] din,
      output [DATA_WIDTH-1:0] dout,
      //TODO: implement dvalid
      output                  dvalid
   );

   //=================
   // Delay Register
   //=================
   reg [DATA_WIDTH*DELAY_CYCLES-1:0] delay;

   // Syncronous shifting of the data through the register
   always @ (posedge clk) begin
      delay[DATA_WIDTH-1:0] <= din  [DATA_WIDTH-1:0];
      if (DELAY_CYCLES > 1) begin
         delay[DATA_WIDTH*DELAY_CYCLES-1:DATA_WIDTH] <= delay[DATA_WIDTH*(DELAY_CYCLES-1):0];
      end
   end
   
   // Assign last slice of register to the data out
   assign dout[DATA_WIDTH-1:0] = delay[DATA_WIDTH*DELAY_CYCLES-1:DATA_WIDTH*(DELAY_CYCLES-1)];
    
endmodule 
