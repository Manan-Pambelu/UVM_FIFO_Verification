class fifo_act_agent extends uvm_agent;

	`uvm_component_utils(fifo_act_agent)

	fifo_sequencer sqr_h;
	fifo_driver drv_h;
	fifo_act_monitor act_mon_h;

	function new(string name="fifo_act_agent", uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		sqr_h=fifo_sequencer::type_id::create("sqr_h",this);
		drv_h=fifo_driver::type_id::create("drv_h",this);
		act_mon_h=fifo_act_monitor::type_id::create("act_mon_h",this);

	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		drv_h.seq_item_port.connect(sqr_h.seq_item_export);
	endfunction

endclass
