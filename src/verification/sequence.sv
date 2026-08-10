
class fifo_sequence extends uvm_sequence #(trans);
	`uvm_object_utils(fifo_sequence)

	function new(string name="fifo_sequence");
		super.new(name);
	endfunction

	task body();

		repeat(10) begin
		req=trans::type_id::create("req");
		start_item(req);
		assert(req.randomize());
		finish_item(req);
		end
	endtask
endclass

//=========================================================================================================================================

class write_only extends uvm_sequence #(trans);
        `uvm_object_utils(write_only)

        function new(string name="write_only");
                super.new(name);
        endfunction

        task body();
		repeat(10) begin
                req=trans::type_id::create("req");
                start_item(req);
		assert(req.randomize() with {reset==0;wr_cs==1; wr_en==1;});
                finish_item(req);
		end
        endtask
endclass

//===========================================================================================================================================

class read_after_write extends uvm_sequence #(trans);
        `uvm_object_utils(read_after_write)

        function new(string name="read_after_write");
                super.new(name);
        endfunction

        task body();
		begin
			repeat(4)
                        begin
                                req=trans::type_id::create("req");
                                start_item(req);
                                assert(req.randomize() with {reset==1;});
                                finish_item(req);
                        end

			repeat(10)
			begin
                		req=trans::type_id::create("req");
               		 	start_item(req);
				assert(req.randomize() with {reset==0; wr_cs==1; wr_en==1; rd_cs==0; rd_en==0;});
                		finish_item(req);
			end

                        repeat(10)
			begin
				req=trans::type_id::create("req");
				start_item(req);
				assert(req.randomize() with {reset==0; wr_cs==0; wr_en==0; rd_cs==1; rd_en==1;});
				finish_item(req);
			end
		end

        endtask
endclass

//==========================================================================================================================================


class write_read extends uvm_sequence #(trans);
        `uvm_object_utils(write_read)

        function new(string name="write_read");
                super.new(name);
        endfunction

        task body();
		begin
		repeat(2) begin
                req=trans::type_id::create("req");
                start_item(req);
                assert(req.randomize() with {reset==1;});
                finish_item(req);
                end
		
	

		repeat(10) begin
                req=trans::type_id::create("req");
                start_item(req);
			assert(req.randomize() with {reset==0; wr_cs==1;wr_en==1; rd_cs==1; rd_en==1;});
                finish_item(req);
                end

		end
        endtask
endclass

//=========================================================================================================================================

class write_until_full extends uvm_sequence #(trans);
        `uvm_object_utils(write_until_full)

        function new(string name="write_until_full");
                super.new(name);
        endfunction

	task body();
		begin
                repeat(260) begin
                req=trans::type_id::create("req");
                start_item(req);
                        assert(req.randomize() with {reset==1;});
                finish_item(req);
                end
        

       
                repeat(260) begin
                req=trans::type_id::create("req");
                start_item(req);
			assert(req.randomize() with {reset==0;wr_cs==1; wr_en==1;rd_cs==0; rd_en==0;});
                finish_item(req);
                end
		end
        endtask
endclass

//===========================================================================================================================================

class read_until_empty extends uvm_sequence #(trans);
        `uvm_object_utils(read_until_empty)

        function new(string name="read_until_empty");
                super.new(name);
        endfunction

        task body();
                begin
                        repeat(2)
                        begin
                                req=trans::type_id::create("req");
                                start_item(req);
                                assert(req.randomize() with {reset==1;});
                                finish_item(req);
                        end

                        repeat(10)
                        begin
                                req=trans::type_id::create("req");
                                start_item(req);
                                assert(req.randomize() with {reset==0; wr_cs==1; wr_en==1; rd_cs==0; rd_en==0;});
                                finish_item(req);
                        end

                        repeat(11)
                        begin
                                req=trans::type_id::create("req");
                                start_item(req);
                                assert(req.randomize() with {reset==0; wr_cs==0; wr_en==0; rd_cs==1; rd_en==1;});
                                finish_item(req);
                        end
                end

        endtask
endclass

//=========================================================================================================================================


class read_after_write_with_full extends uvm_sequence #(trans);
        `uvm_object_utils(read_after_write_with_full)

        function new(string name="read_after_write_with_full");
                super.new(name);
        endfunction

        task body();
                begin
                        repeat(2)
                        begin
                                req=trans::type_id::create("req");
                                start_item(req);
                                assert(req.randomize() with {reset==1;});
                                finish_item(req);
                        end

                        repeat(10)
                        begin
                                req=trans::type_id::create("req");
                                start_item(req);
                                assert(req.randomize() with {reset==0; wr_cs==1; wr_en==1; rd_cs==0; rd_en==0;});
                                finish_item(req);
                        end

                        repeat(12)
                        begin
                                req=trans::type_id::create("req");
                                start_item(req);
                                assert(req.randomize() with {reset==0; wr_cs==0; wr_en==0; rd_cs==1; rd_en==1;});
                                finish_item(req);
                        end
                end

        endtask
endclass

//===================================================================================================================================================
