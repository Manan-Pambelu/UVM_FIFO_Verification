`include "defines.sv"
`include "uvm_macros.svh"
import uvm_pkg ::*;

class trans extends uvm_sequence_item;
	

	rand bit wr_cs;
	rand bit rd_cs;
	rand bit wr_en;
	rand bit rd_en;
	rand bit [`DATA_WIDTH-1:0] data_in;
	rand bit reset;

	bit [`DATA_WIDTH-1:0] data_out;
	bit full;
	bit empty;


	function new(string name = "trans");
		super.new(name);
	endfunction

	`uvm_object_utils_begin(trans)
		`uvm_field_int(wr_cs,UVM_BIN | UVM_ALL_ON)
		`uvm_field_int(rd_cs,UVM_BIN | UVM_ALL_ON)
		`uvm_field_int(wr_en,UVM_BIN | UVM_ALL_ON)
		`uvm_field_int(rd_en,UVM_BIN | UVM_ALL_ON)
		`uvm_field_int(reset,UVM_BIN | UVM_ALL_ON)
		`uvm_field_int(data_in,UVM_HEX | UVM_ALL_ON)
		`uvm_field_int(data_out,UVM_HEX | UVM_ALL_ON)
		`uvm_field_int(full,UVM_BIN | UVM_ALL_ON)
		`uvm_field_int(empty,UVM_BIN | UVM_ALL_ON)
	`uvm_object_utils_end


endclass





