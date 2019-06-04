module testbench;

parameter DATA_WIDTH = 16;

reg t_clk;
reg t_rst_n;

wire [1:0]htrans;
wire [11:0]haddr;
wire [31:0]hwdata;
wire hready_in;
wire hsel;
wire hwrite;
wire [2:0]hsize;
wire [1:0]hresp;
wire hready_out;
wire [31:0]hrdata;

reg [31:0]data_check;

//CPU Model
cpu_model cpu(
             .hclk                (t_clk)
           , .hresetn             (t_rst_n)
           , .htrans              (htrans)
           , .haddr               (haddr)
           , .hwdata              (hwdata)
           , .hready_in           (hready_in)
           , .hsel                (hsel)
           , .hwrite              (hwrite)
           , .hsize               (hsize)
           , .hresp               (hresp)
           , .hready_out          (hready_out)
           , .hrdata              (hrdata)
    );

//top
ahb ahb_01 ( 
             .hclk                (t_clk)    
           , .hresetn             (t_rst_n)
           , .htrans              (htrans)
           , .haddr               (haddr)
           , .hwdata              (hwdata)
           , .hready_in           (hready_in)
           , .hsel                (hsel)
           , .hwrite              (hwrite)
           , .hsize               (hsize)
           , .hresp               (hresp)
           , .hready_out          (hready_out)
           , .hrdata              (hrdata)
           , .frame_num           ()
           , .sample_in_frame     ()
           , .com_2_ovl           ()
           , .max_point_fft_core  ()
           , .alpha               ()
           , .quarter             ()
           , .fft_num             ()
           , .fft_stage_number    ()
           , .mel_num             ()
           , .cep_num             ()
           , .trigger             ()
           );

always begin
    #0 t_clk = 0;
    #50 t_clk = 1;
    #50;
end

initial begin
    # 0 t_rst_n = 0;
    # 100 t_rst_n = 1;
    # 90000 $finish;
end

//Test
initial begin
    #200 cpu.MOVT(12'h000,32'h5a5a5a5a);
    #200 cpu.MOVF(12'h000,data_check);
    #200 cpu.MOVT(12'h001,32'ha5a5a5a5);
    #200 cpu.MOVF(12'h001,data_check);
    #200 cpu.MOVT(12'h002,32'h5a5a5a5a);
    #200 cpu.MOVF(12'h002,data_check);
    #200 cpu.MOVT(12'h003,32'ha5a5a5a5);
    #200 cpu.MOVF(12'h003,data_check);
    #200 cpu.MOVT(12'h004,32'h5a5a5a5a);
    #200 cpu.MOVF(12'h004,data_check);
    #200 cpu.MOVT(12'h005,32'ha5a5a5a5);
    #200 cpu.MOVF(12'h005,data_check);
    #200 cpu.MOVT(12'h006,32'h5a5a5a5a);
    #200 cpu.MOVF(12'h006,data_check);
    #200 cpu.MOVT(12'h007,32'ha5a5a5a5);
    #200 cpu.MOVF(12'h007,data_check);
    #200 cpu.MOVT(12'h008,32'h5a5a5a5a);
    #200 cpu.MOVF(12'h008,data_check);
    #200 cpu.MOVT(12'h009,32'ha5a5a5a5);
    #200 cpu.MOVF(12'h009,data_check);
    #200 cpu.MOVT(12'h00a,32'ha5a5a5a5);
    #200 cpu.MOVF(12'h00a,data_check);

end

initial begin
    $vcdplusfile("testbench_wave.vpd");
    $vcdpluson();
end

endmodule

