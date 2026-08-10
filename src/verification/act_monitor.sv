class fifo_act_monitor extends uvm_monitor;
        `uvm_component_utils(fifo_act_monitor)
        uvm_analysis_port #(trans) act_mon_aport;
        virtual fifo_if vif;

        trans tx;

        function new(string name ="fifo_act_monitor",uvm_component parent);
                super.new(name,parent);
        endfunction

        function void build_phase(uvm_phase phase);
                super.build_phase(phase);
                act_mon_aport=new("fifo_mon_aport", this);
                if(!uvm_config_db#(virtual fifo_if)::get(this,"","fifo_if",vif))
                        `uvm_fatal(get_type_name(),"accesing virtual interface in monitor failed")
        endfunction

        task run_phase(uvm_phase phase);
                super.run_phase(phase);

                forever
                begin
			@(posedge vif.act_mon_cb)
			tx=trans::type_id::create("tx");

			tx.reset=vif.reset;
                        tx.wr_cs=vif.wr_cs;
                        tx.rd_cs=vif.rd_cs;
                        tx.wr_en=vif.wr_en;
                        tx.rd_en=vif.rd_en;
                        tx.data_in=vif.data_in;
               
                        act_mon_aport.write(tx);
			
		

                end
        endtask
endclass
