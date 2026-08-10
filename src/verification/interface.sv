`include "defines.sv"
interface fifo_if(input bit clk);
        logic wr_cs;
        logic rd_cs;
        logic wr_en;
        logic rd_en;
        logic [`DATA_WIDTH-1:0] data_in;

        logic reset;

        logic [`DATA_WIDTH-1:0] data_out;
        logic full;
        logic empty;

	clocking driver_cb @(posedge clk);
		output reset;
		output wr_cs;
		output rd_cs;
		output wr_en;
		output rd_en;
		output data_in;
	endclocking

	clocking act_mon_cb @(posedge clk);
		 input reset;
		 input wr_cs;
		 input rd_cs;
		 input wr_en;
		 input rd_en;
		 input data_in;
	endclocking

	clocking pas_mon_cb @(posedge  clk);
		input data_out;
		input full;
		input empty;
	endclocking


	modport DRIVER(clocking driver_cb);
	modport ACT_MON(clocking act_mon_cb);
	modport PAS_MON(clocking pas_mon_cb);



	//Assertion

	property p1;
		@(posedge clk)
		reset|->empty;
	endproperty

	property p2;
                @(posedge clk)
                reset|->!full;
        endproperty

	property p3;
                @(posedge clk) disable iff(reset)
                (wr_en && wr_cs && full && !(rd_en && rd_cs))|=>full;
        endproperty

	property p4;
                @(posedge clk)
                  !(empty && full);
        endproperty

        assert property(p1)
                $display("assertion passed when reset is 1 empty is 1");
        else
                $display("assertion failed when reset is 1 empty didnot asserted 1");


        assert property(p2)
                $display("assertion passed when reset is 1 full is 0");
        else
                $display("assertion failed when reset is 1 full is 1");

        assert property(p3)
                $display("assertion passed full flag is high,when write enable and chip select is high and full flag is asserted but read has not been done");
        else
                $display("assertion passed full flag is high,when write enable and chip select is high and full flag is asserted but read has not been done");

        assert property(p4)
                $display("assertion passed, read and empty flags are not high at the same time");
	else
		$display("assertion failed, read and empty flags are high at the same time");


endinterface

