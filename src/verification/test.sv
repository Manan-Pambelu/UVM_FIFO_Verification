class fifo_test extends uvm_test;
	`uvm_component_utils(fifo_test)

	fifo_env env_h;
	virtual fifo_if vif;

	function new(string name="fifo_test", uvm_component parent);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		env_h=fifo_env::type_id::create("env_h",this);

		if(!uvm_config_db #(virtual fifo_if)::get(this,"","fifo_if",vif))
			`uvm_fatal(get_type_name(),"configuration failed")
	endfunction

	function void end_of_elaboration_phase(uvm_phase phase);
		super.end_of_elaboration_phase(phase);
		uvm_top.print_topology();
	endfunction
endclass

//=====================================================================================================================================================================================================

class test1 extends fifo_test;
	`uvm_component_utils(test1)
	fifo_sequence basic_seq_h;

	function new(string name="test1", uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		
		phase.raise_objection(this);


		basic_seq_h=fifo_sequence::type_id::create("basic_seq_h");
		basic_seq_h.start(env_h.act_agt_h.sqr_h);


		phase.drop_objection(this);
	endtask
endclass



//=============================================================================================================================================================================================

class test2 extends fifo_test;
        `uvm_component_utils(test2)

        write_only wr_only;

        function new(string name="test2", uvm_component parent);
                super.new(name,parent);
        endfunction

        function void build_phase(uvm_phase phase);
                super.build_phase(phase);
        endfunction

        task run_phase(uvm_phase phase);
                super.run_phase(phase);

                phase.raise_objection(this);

                wr_only=write_only::type_id::create("wr_only");
                wr_only.start(env_h.act_agt_h.sqr_h);


                phase.drop_objection(this);
        endtask
endclass

//===============================================================================================================================================================================================

class test3 extends fifo_test;
        `uvm_component_utils(test3)

        read_after_write war;

        function new(string name="test3", uvm_component parent);
                super.new(name,parent);
        endfunction

        function void build_phase(uvm_phase phase);
                super.build_phase(phase);
        endfunction

        task run_phase(uvm_phase phase);
                super.run_phase(phase);

                phase.raise_objection(this);

                war=read_after_write::type_id::create("war");
                war.start(env_h.act_agt_h.sqr_h);


                phase.drop_objection(this);
        endtask
endclass

//====================================================================================================================================================================================================

class test4 extends fifo_test;
        `uvm_component_utils(test4)
        write_until_full wuf;

        function new(string name="test4", uvm_component parent);
                super.new(name,parent);
        endfunction

        function void build_phase(uvm_phase phase);
                super.build_phase(phase);
        endfunction

        task run_phase(uvm_phase phase);
                super.run_phase(phase);

                phase.raise_objection(this);

		wuf=write_until_full::type_id::create("wuf");
                wuf.start(env_h.act_agt_h.sqr_h);


                phase.drop_objection(this);
        endtask
endclass

//=====================================================================================================================================================================================================

class test5 extends fifo_test;
        `uvm_component_utils(test5)
        read_until_empty rue;

        function new(string name="test5", uvm_component parent);
                super.new(name,parent);
        endfunction

        function void build_phase(uvm_phase phase);
                super.build_phase(phase);
        endfunction

        task run_phase(uvm_phase phase);
                super.run_phase(phase);

                phase.raise_objection(this);


                rue=read_until_empty::type_id::create("rue");
                rue.start(env_h.act_agt_h.sqr_h);


                phase.drop_objection(this);
        endtask
endclass

//=========================================================================================================================================================================================================

class test6 extends fifo_test;
        `uvm_component_utils(test6)
        read_after_write_with_full rwf;

        function new(string name="test6", uvm_component parent);
                super.new(name,parent);
        endfunction

        function void build_phase(uvm_phase phase);
                super.build_phase(phase);
        endfunction

        task run_phase(uvm_phase phase);
                super.run_phase(phase);

                phase.raise_objection(this);


                rwf=read_after_write_with_full::type_id::create("rwf");
                rwf.start(env_h.act_agt_h.sqr_h);


                phase.drop_objection(this);
        endtask
endclass

//==================================================================================================================================================================

class regression_test extends fifo_test;
        `uvm_component_utils(regression_test)


        read_after_write_with_full rwf;
	fifo_sequence basic_seq_h;
	write_only wr_only;
	read_after_write war;
	write_until_full wuf;
	read_until_empty rue;
	write_read wr;


function new(string name="regression_test", uvm_component parent);
                super.new(name,parent);
        endfunction

        function void build_phase(uvm_phase phase);
		super.build_phase(phase);
        endfunction

        task run_phase(uvm_phase phase);
                super.run_phase(phase);

                phase.raise_objection(this);

		
                rwf=read_after_write_with_full::type_id::create("rwf");
		basic_seq_h=fifo_sequence::type_id::create("basic_seq_h");
		wr_only=write_only::type_id::create("wr_only");
		war=read_after_write::type_id::create("war");
		wuf=write_until_full::type_id::create("wuf");
		rue=read_until_empty::type_id::create("rue");
		wr=write_read::type_id::create("wr");

                basic_seq_h.start(env_h.act_agt_h.sqr_h);
		rwf.start(env_h.act_agt_h.sqr_h);
		wr_only.start(env_h.act_agt_h.sqr_h);
		war.start(env_h.act_agt_h.sqr_h);
		wuf.start(env_h.act_agt_h.sqr_h);
		rue.start(env_h.act_agt_h.sqr_h);
		wr.start(env_h.act_agt_h.sqr_h);


                phase.drop_objection(this);
        endtask
endclass


