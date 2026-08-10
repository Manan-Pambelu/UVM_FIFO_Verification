       `include "package.svh"
	`include "interface.sv"
	`include "../design/DUT.v"
       // `include "../design/ram_dp_ar_aw.v"  

 module top();       
	import uvm_pkg::*;
	import test_pkg::*;

	bit clk;

	fifo_if vif(clk);

   
        syn_fifo DUV(.wr_cs(vif.wr_cs),.rd_cs(vif.rd_cs),.clk(clk),.rst(vif.reset),.wr_en(vif.wr_en),.rd_en(vif.rd_en),
		.data_in(vif.data_in),.data_out(vif.data_out),.full(vif.full),.empty(vif.empty));


 	initial
	begin
		uvm_config_db#(virtual fifo_if)::set(null,"*","fifo_if",vif);
	        run_test("regression_test");
		
	end


	
	initial
	begin
		clk=1'b0;
		forever 
		   #5 clk=~clk;
	end

endmodule

