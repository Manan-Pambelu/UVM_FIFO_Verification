class fifo_pas_agent extends uvm_agent;

        `uvm_component_utils(fifo_pas_agent)

	fifo_pas_monitor pas_mon_h;

        function new(string name="fifo_pas_agent", uvm_component parent);
                super.new(name,parent);
        endfunction

        function void build_phase(uvm_phase phase);
                super.build_phase(phase);
                pas_mon_h=fifo_pas_monitor::type_id::create("pas_mon_h",this);

        endfunction

endclass
