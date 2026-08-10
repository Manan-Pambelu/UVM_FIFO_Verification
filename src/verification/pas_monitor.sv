class fifo_pas_monitor extends uvm_monitor;
        `uvm_component_utils(fifo_pas_monitor)
        uvm_analysis_port #(trans) pas_mon_aport;
        virtual fifo_if vif;

        trans tx;

        function new(string name ="alu_pas_monitor",uvm_component parent);
                super.new(name,parent);
        endfunction

        function void build_phase(uvm_phase phase);
                super.build_phase(phase);
                pas_mon_aport=new("pas_mon_aport", this);
                if(!uvm_config_db#(virtual fifo_if)::get(this,"","fifo_if",vif))
                        `uvm_fatal(get_type_name(),"accesing virtual interface in monitor failed")
        endfunction

        task run_phase(uvm_phase phase);
                super.run_phase(phase);

                forever
                begin
			@(posedge vif.pas_mon_cb);
			begin
			tx=trans::type_id::create("tx");
			
			tx.data_out=vif.pas_mon_cb.data_out;
			tx.full = vif.pas_mon_cb.full;
			tx.empty = vif.pas_mon_cb.empty;
			tx.data_in=vif.data_in;
 			
				`uvm_info(get_type_name(), $sformatf("pas_mon -> rst: %b | wr_cs: %b | rd_cs: %b | wr_en: %0d | rd_en: %b | data_in: %0d | data_out: %0d | full: %b | empty: %0d",vif.reset, vif.wr_cs, vif.rd_cs, vif.wr_en, vif.rd_en, tx.data_in,tx.data_out, tx.full, tx.empty), UVM_LOW)
                        pas_mon_aport.write(tx);
			end
                end
        endtask
endclass
