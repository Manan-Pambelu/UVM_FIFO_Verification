class fifo_driver extends uvm_driver #(trans);
    `uvm_component_utils(fifo_driver)

    virtual fifo_if vif;

    function new(string name="fifo_driver", uvm_component parent);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual fifo_if)::get(this,"","fifo_if",vif))
            `uvm_fatal(get_type_name(), "virtual interface config failed")
    endfunction

    task run_phase(uvm_phase phase);
        super.run_phase(phase);

	    forever begin
            seq_item_port.get_next_item(req);

	    vif.driver_cb.reset <= req.reset;
	    vif.driver_cb.wr_cs <= req.wr_cs;
            vif.driver_cb.rd_cs <= req.rd_cs;
            vif.driver_cb.wr_en <= req.wr_en;
            vif.driver_cb.rd_en <= req.rd_en;

            vif.data_in  <= req.data_in;

		`uvm_info(get_type_name(), $sformatf("\nDriving -> reset:%b | wr_cs: %b | rd_cs: %b | wr_en: %b | rd_en: %0d | data_in: %0d |\n",req.reset, req.wr_cs, req.rd_cs, req.wr_en, req.rd_en, req.data_in),UVM_LOW) 

	   @(posedge vif.driver_cb)

            seq_item_port.item_done();
        end
    endtask
endclass
