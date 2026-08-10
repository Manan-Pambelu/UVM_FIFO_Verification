`include "defines.sv"

class fifo_scoreboard extends uvm_scoreboard;

    `uvm_component_utils(fifo_scoreboard)

    uvm_tlm_analysis_fifo #(trans) inp_fifo;
    uvm_tlm_analysis_fifo #(trans) out_fifo;

    trans inp_packet;
    trans out_packet;
    trans ref_packet;

    function new(string name = "fifo_scoreboard", uvm_component parent);
        super.new(name, parent);

        inp_fifo   = new("inp_fifo", this);
        out_fifo   = new("out_fifo", this);
        ref_packet = new("ref_packet");
        inp_packet = new("input_packet");
        out_packet = new("output_packet");
    endfunction

    task run_phase(uvm_phase phase);
        reg [`DATA_WIDTH-1:0] MEM [0:`RAM_DEPTH-1];
        reg [`ADDR_WIDTH-1:0] rd_pointer;
        reg [`ADDR_WIDTH-1:0] wr_pointer;
        reg [`ADDR_WIDTH:0] status_cnt; //this needs one extra bit to hold

        logic [`DATA_WIDTH-1:0] expected_data_q[$]; // queue is used to handle the delay of data out

        super.run_phase(phase);

        forever begin
            inp_fifo.get(inp_packet);  
            out_fifo.get(out_packet);  

           
            ref_packet.copy(inp_packet);  

           
            if(inp_packet.reset) begin
                rd_pointer = 0;
                wr_pointer = 0;
                status_cnt = 0;
                expected_data_q.delete(); 
                
                ref_packet.data_out = 0;
                ref_packet.empty = 1;
                ref_packet.full = 0;
            end 
            else begin
             
                if (expected_data_q.size() > 0) begin
                    ref_packet.data_out = expected_data_q.pop_front(); // if no read data out hold its previous value
                end

                ref_packet.empty = (status_cnt == 0);
                ref_packet.full  = (status_cnt == `RAM_DEPTH);
            end

            `uvm_info("SCOREBOARD REF", $sformatf("SCOREBOARD \n %s", ref_packet.sprint()), UVM_LOW)
            `uvm_info("SCOREBOARD DUT", $sformatf("SCOREBOARD \n %s", out_packet.sprint()), UVM_LOW)

            if (ref_packet.data_out === out_packet.data_out && ref_packet.empty === out_packet.empty && ref_packet.full === out_packet.full) 
begin
                `uvm_info(get_type_name(), "\n------------------------------------------------------------------------------------\nPASS\n---------------------------------------------------------------------------------\n", UVM_LOW)
            end 
            else begin
             
                `uvm_error(get_type_name(), "\n------------------------------------------------------------------------------------\nFAIL\n---------------------------------------------------------------------------------\n")
            end

       
            if (!inp_packet.reset) begin
                logic write = (inp_packet.wr_en && inp_packet.wr_cs && (status_cnt < `RAM_DEPTH));
                logic read  = (inp_packet.rd_en && inp_packet.rd_cs && (status_cnt > 0));

                if (write && read) begin
                    MEM[wr_pointer] = inp_packet.data_in;
                    expected_data_q.push_back(MEM[rd_pointer]); 
                    wr_pointer++;
                    rd_pointer++;
                end
                else if (write) begin
                    MEM[wr_pointer] = inp_packet.data_in;
                    wr_pointer++;
                    status_cnt++;
                end
                else if (read) begin
                    expected_data_q.push_back(MEM[rd_pointer]); 
                    rd_pointer++;
                    status_cnt--;
                end
            end
        end
    endtask

endclass













