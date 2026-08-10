class fifo_subscriber extends uvm_subscriber#(trans);
	`uvm_component_utils(fifo_subscriber)



	uvm_analysis_imp #(trans,fifo_subscriber) cov_port;
	trans tx;
	int coverage;

	covergroup cg;
		cp_rs : coverpoint tx.reset;
				
		cp_we : coverpoint tx.wr_en{
			bins wr_bin0 ={0};
			bins wr_bin1 ={1};
					}
		cp_wc : coverpoint tx.wr_cs{
	                bins wc_bin0 ={0};
	                bins wc_bin1 ={1};
	                                }
		cp_re : coverpoint tx.rd_en{
                        bins re_bin0 ={0};
                        bins re_bin1 ={1};
                                        }
		cp_rc : coverpoint tx.rd_cs{
                        bins rc_bin0 ={0};
                        bins rc_bin1 ={1};
                                        }
		cr_wc : cross cp_we,cp_wc;
		cr_rc : cross cp_re,cp_rc;
	endgroup

	        function new(string name ="fifo_subscriber", uvm_component parent);
                	super.new(name,parent);
			cov_port=new("cov_port",this);
			cg=new();
        	endfunction

		function void write(trans t);
			tx=t;
			cg.sample();
		endfunction

		function void extract_phase(uvm_phase phase);
			super.extract_phase(phase);
			coverage=cg.get_coverage();
		endfunction

		function void report_phase(uvm_phase phase);
			super.report_phase(phase);
			`uvm_info(get_type_name(),$sformatf("FIFO coverage is ----> %0.2f",coverage),UVM_LOW)
		endfunction
endclass





			


