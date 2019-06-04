module ahb (
            hclk
           ,hresetn
           ,htrans
           ,haddr
           ,hwdata
           ,hready_in
           ,hsel
           ,hwrite
           ,hsize
           ,hresp
           ,hready_out
           ,hrdata
           ,frame_num    
           ,sample_in_frame
           ,com_2_ovl
           ,max_point_fft_core
           ,alpha
           ,quarter
           ,fft_num
           ,fft_stage_number
           ,mel_num
           ,cep_num
           ,trigger
           );
 
input hclk;                      //clk
input hresetn;                   //rst_n
input [1:0]htrans;
input [11:0]haddr;
input [31:0]hwdata;
input hready_in;
input hsel;
input hwrite;
input [2:0]hsize;
output [1:0]hresp;
output hready_out;
output [31:0]hrdata; 
output [31:0]frame_num;           //frame_num register
output [31:0]sample_in_frame;     //sample_in_frame register
output [31:0]com_2_ovl;           //com_2_ovl register
output [31:0]max_point_fft_core;  //max_point_fft_core register
output [31:0]alpha;               //alpha register
output [31:0]quarter;             //quarter register
output [31:0]fft_num;             //fft_num register
output [31:0]fft_stage_number;    //fft_stage_number register
output [31:0]mel_num;             //mel_num register
output [31:0]cep_num;             //cep_num register
output trigger;                   //trigger bit
 
wire hclk;
wire hresetn;
wire [1:0]htrans;
wire [11:0]haddr;
wire [31:0]hwdata;
wire hready_in;
wire hsel;
wire hwrite;
wire [2:0]hsize;
wire [1:0]hresp;
wire hready_out;
reg [31:0]hrdata; 
reg [31:0]frame_num;
reg [31:0]sample_in_frame;
reg [31:0]com_2_ovl;
reg [31:0]max_point_fft_core;
reg [31:0]alpha;
reg [31:0]quarter;
reg [31:0]fft_num;
reg [31:0]fft_stage_number;
reg [31:0]mel_num;
reg [31:0]cep_num;
reg [31:0]trigger_reg;
wire trigger;
 
//Internal signals
  //write register select signals
reg wr_frame_num_sel;          
reg wr_sample_in_frame_sel;
reg wr_com_2_ovl_sel;
reg wr_max_point_fft_core_sel;
reg wr_alpha_sel;
reg wr_quarter_sel;
reg wr_fft_num_sel;
reg wr_fft_stage_number_sel;
reg wr_mel_num_sel;
reg wr_cep_num_sel;
reg wr_trigger_sel;

  //read register select signals
wire rd_frame_num_sel;
wire rd_sample_in_frame_sel;
wire rd_com_2_ovl_sel;
wire rd_max_point_fft_core_sel;
wire rd_alpha_sel;
wire rd_quarter_sel;
wire rd_fft_num_sel;
wire rd_fft_stage_number_sel;
wire rd_mel_num_sel;
wire rd_cep_num_sel;
wire rd_trigger_sel;

  //temp registers
wire [31:0]nxt_frame_num;
wire [31:0]nxt_sample_in_frame;
wire [31:0]nxt_com_2_ovl;
wire [31:0]nxt_max_point_fft_core;
wire [31:0]nxt_alpha;
wire [31:0]nxt_quarter;
wire [31:0]nxt_fft_num;
wire [31:0]nxt_fft_stage_number;
wire [31:0]nxt_mel_num;
wire [31:0]nxt_cep_num;
wire [31:0]nxt_trigger_reg;
 
  //Others
reg [2:0]temp_hsize;
wire [10:0]rd_sel_reg;
reg [31:0]nxt_hrdata;
wire wr_en;
wire rd_en;

//Operations

//1. wr_en & rd_en
assign wr_en = htrans[1] & hready_in & hsel & hwrite;
assign rd_en = htrans[1] & hready_in & hsel & ~hwrite;

//2. Select Registers
// 2.1 For write
    //Select frame_num register
always @(posedge hclk or negedge hresetn) begin
  if (!hresetn) begin
    wr_frame_num_sel <= 1'b0; 
  end
  else begin
    if (wr_en && (haddr[11:0] == 12'h000)) begin      
      wr_frame_num_sel <= 1'b1;
    end
    else begin
      wr_frame_num_sel <= 1'b0;
    end        
  end        
end        
    //Select sample_in_frame register
always @(posedge hclk or negedge hresetn) begin
  if (!hresetn) begin
    wr_sample_in_frame_sel <= 1'b0; 
  end
  else begin
    if (wr_en && (haddr[11:0] == 12'h001)) begin      
      wr_sample_in_frame_sel <= 1'b1;
    end
    else begin
      wr_sample_in_frame_sel <= 1'b0;
    end        
  end        
end        
    //Select com_2_ovl register
always @(posedge hclk or negedge hresetn) begin
  if (!hresetn) begin
    wr_com_2_ovl_sel <= 1'b0; 
  end
  else begin
    if (wr_en && (haddr[11:0] == 12'h002)) begin      
      wr_com_2_ovl_sel <= 1'b1;
    end
    else begin
      wr_com_2_ovl_sel <= 1'b0;
    end        
  end        
end        
    //Select max_point_fft_core register
always @(posedge hclk or negedge hresetn) begin
  if (!hresetn) begin
    wr_max_point_fft_core_sel <= 1'b0; 
  end
  else begin
    if (wr_en && (haddr[11:0] == 12'h003)) begin      
      wr_max_point_fft_core_sel <= 1'b1;
    end
    else begin
      wr_max_point_fft_core_sel <= 1'b0;
    end        
  end        
end        
    //Select alpha register 
always @(posedge hclk or negedge hresetn) begin
  if (!hresetn) begin
    wr_alpha_sel <= 1'b0; 
  end
  else begin
    if (wr_en && (haddr[11:0] == 12'h004)) begin      
      wr_alpha_sel <= 1'b1;
    end
    else begin
      wr_alpha_sel <= 1'b0;
    end        
  end        
end        
    //Select quarter register
always @(posedge hclk or negedge hresetn) begin
  if (!hresetn) begin
    wr_quarter_sel <= 1'b0; 
  end
  else begin
    if (wr_en && (haddr[11:0] == 12'h005)) begin      
      wr_quarter_sel <= 1'b1;
    end
    else begin
      wr_quarter_sel <= 1'b0;
    end        
  end        
end        
    //Select fft_num register
always @(posedge hclk or negedge hresetn) begin
  if (!hresetn) begin
    wr_fft_num_sel <= 1'b0; 
  end
  else begin
    if (wr_en && (haddr[11:0] == 12'h006)) begin      
      wr_fft_num_sel <= 1'b1;
    end
    else begin
      wr_fft_num_sel <= 1'b0;
    end        
  end        
end        
    //Select fft_stage_number register
always @(posedge hclk or negedge hresetn) begin
  if (!hresetn) begin
    wr_fft_stage_number_sel <= 1'b0; 
  end
  else begin
    if (wr_en && (haddr[11:0] == 12'h007)) begin      
      wr_fft_stage_number_sel <= 1'b1;
    end
    else begin
      wr_fft_stage_number_sel <= 1'b0;
    end        
  end        
end        
    //Select mel_num register
always @(posedge hclk or negedge hresetn) begin
  if (!hresetn) begin
    wr_mel_num_sel <= 1'b0; 
  end
  else begin
    if (wr_en && (haddr[11:0] == 12'h008)) begin      
      wr_mel_num_sel <= 1'b1;
    end
    else begin
      wr_mel_num_sel <= 1'b0;
    end        
  end        
end        
    //Select cep_num register
always @(posedge hclk or negedge hresetn) begin
  if (!hresetn) begin
    wr_cep_num_sel <= 1'b0; 
  end
  else begin
    if (wr_en && (haddr[11:0] == 12'h009)) begin      
      wr_cep_num_sel <= 1'b1;
    end
    else begin
      wr_cep_num_sel <= 1'b0;
    end        
  end        
end        
    //Select trigger register 
always @(posedge hclk or negedge hresetn) begin
  if (!hresetn) begin
    wr_trigger_sel <= 1'b0; 
  end
  else begin
    if (wr_en && (haddr[11:0] == 12'h00a)) begin      
      wr_trigger_sel <= 1'b1;
    end
    else begin
      wr_trigger_sel <= 1'b0;
    end        
  end        
end        

// 2.2 For read
assign rd_frame_num_sel =          (rd_en & (haddr[11:0] == 12'h000))? 1'b1:1'b0;
assign rd_sample_in_frame_sel =    (rd_en & (haddr[11:0] == 12'h001))? 1'b1:1'b0;
assign rd_com_2_ovl_sel =          (rd_en & (haddr[11:0] == 12'h002))? 1'b1:1'b0;
assign rd_max_point_fft_core_sel = (rd_en & (haddr[11:0] == 12'h003))? 1'b1:1'b0;
assign rd_alpha_sel =              (rd_en & (haddr[11:0] == 12'h004))? 1'b1:1'b0;
assign rd_quarter_sel =            (rd_en & (haddr[11:0] == 12'h005))? 1'b1:1'b0;
assign rd_fft_num_sel =            (rd_en & (haddr[11:0] == 12'h006))? 1'b1:1'b0;
assign rd_fft_stage_number_sel =   (rd_en & (haddr[11:0] == 12'h007))? 1'b1:1'b0;
assign rd_mel_num_sel =            (rd_en & (haddr[11:0] == 12'h008))? 1'b1:1'b0;
assign rd_cep_num_sel =            (rd_en & (haddr[11:0] == 12'h009))? 1'b1:1'b0;
assign rd_trigger_sel =            (rd_en & (haddr[11:0] == 12'h00a))? 1'b1:1'b0;

//3. Write Data
always @(posedge hclk or negedge hresetn) begin
  if (!hresetn) begin
    temp_hsize <= 3'b0; 
  end
  else begin
    temp_hsize <= hsize; 
  end
end        

assign nxt_frame_num =          (wr_frame_num_sel &          (temp_hsize == 2'h2))? hwdata[31:0]:frame_num;
assign nxt_sample_in_frame =    (wr_sample_in_frame_sel &    (temp_hsize == 2'h2))? hwdata[31:0]:sample_in_frame;
assign nxt_com_2_ovl =          (wr_com_2_ovl_sel &          (temp_hsize == 2'h2))? hwdata[31:0]:com_2_ovl;
assign nxt_max_point_fft_core = (wr_max_point_fft_core_sel & (temp_hsize == 2'h2))? hwdata[31:0]:max_point_fft_core;
assign nxt_alpha =              (wr_alpha_sel &              (temp_hsize == 2'h2))? hwdata[31:0]:alpha;
assign nxt_quarter =            (wr_quarter_sel &            (temp_hsize == 2'h2))? hwdata[31:0]:quarter;
assign nxt_fft_num =            (wr_fft_num_sel &            (temp_hsize == 2'h2))? hwdata[31:0]:fft_num;
assign nxt_fft_stage_number =   (wr_fft_stage_number_sel &   (temp_hsize == 2'h2))? hwdata[31:0]:fft_stage_number;
assign nxt_mel_num =            (wr_mel_num_sel &            (temp_hsize == 2'h2))? hwdata[31:0]:mel_num;
assign nxt_cep_num =            (wr_cep_num_sel &            (temp_hsize == 2'h2))? hwdata[31:0]:cep_num;
assign nxt_trigger_reg =        (wr_trigger_sel &            (temp_hsize == 2'h2))? {31'b0,hwdata[0]}:trigger_reg;

//    frame_num register
always @(posedge hclk or negedge hresetn) begin
  if (!hresetn) begin
    frame_num <= 32'b0; 
  end
  else begin
    frame_num <= nxt_frame_num;
  end        
end        
//    sample_in_frame register
always @(posedge hclk or negedge hresetn) begin
  if (!hresetn) begin
    sample_in_frame <= 32'b0; 
  end
  else begin
    sample_in_frame <= nxt_sample_in_frame;
  end        
end        
//    com_2_ovl register
always @(posedge hclk or negedge hresetn) begin
  if (!hresetn) begin
    com_2_ovl <= 32'b0; 
  end
  else begin
    com_2_ovl <= nxt_com_2_ovl;
  end        
end        
//    max_point_fft_core register
always @(posedge hclk or negedge hresetn) begin
  if (!hresetn) begin
    max_point_fft_core <= 32'b0; 
  end
  else begin
    max_point_fft_core <= nxt_max_point_fft_core;
  end        
end        
//    alpha register
always @(posedge hclk or negedge hresetn) begin
  if (!hresetn) begin
    alpha <= 32'b0; 
  end
  else begin
    alpha <= nxt_alpha;
  end        
end        
//    quarter register
always @(posedge hclk or negedge hresetn) begin
  if (!hresetn) begin
    quarter <= 32'b0; 
  end
  else begin
    quarter <= nxt_quarter;
  end        
end        
//    fft_num register
always @(posedge hclk or negedge hresetn) begin
  if (!hresetn) begin
    fft_num <= 32'b0; 
  end
  else begin
    fft_num <= nxt_fft_num;
  end        
end        
//    fft_stage_number register
always @(posedge hclk or negedge hresetn) begin
  if (!hresetn) begin
    fft_stage_number <= 32'b0; 
  end
  else begin
    fft_stage_number <= nxt_fft_stage_number;
  end        
end        
//    mel_num register
always @(posedge hclk or negedge hresetn) begin
  if (!hresetn) begin
    mel_num <= 32'b0; 
  end
  else begin
    mel_num <= nxt_mel_num;
  end        
end        
//    cep_num register
always @(posedge hclk or negedge hresetn) begin
  if (!hresetn) begin
    cep_num <= 32'b0; 
  end
  else begin
    cep_num <= nxt_cep_num;
  end        
end        
//    trigger register
always @(posedge hclk or negedge hresetn) begin
  if (!hresetn) begin
    trigger_reg <= 32'b0; 
  end
  else begin
    trigger_reg <= nxt_trigger_reg;
  end        
end        
//    trigger bit
assign trigger = trigger_reg[0];

//4. Read Data
assign rd_sel_reg = {rd_trigger_sel,rd_cep_num_sel,rd_mel_num_sel,rd_fft_stage_number_sel,rd_fft_num_sel,rd_quarter_sel,rd_alpha_sel,rd_max_point_fft_core_sel,rd_com_2_ovl_sel,rd_sample_in_frame_sel,rd_frame_num_sel}; 
always @(rd_sel_reg or frame_num or sample_in_frame or com_2_ovl or max_point_fft_core or alpha or quarter or fft_num or fft_stage_number or mel_num or cep_num or trigger_reg) begin
  case (rd_sel_reg)
    11'b000_0000_0001: nxt_hrdata = frame_num;
    11'b000_0000_0010: nxt_hrdata = sample_in_frame;
    11'b000_0000_0100: nxt_hrdata = com_2_ovl;
    11'b000_0000_1000: nxt_hrdata = max_point_fft_core;
    11'b000_0001_0000: nxt_hrdata = alpha;
    11'b000_0010_0000: nxt_hrdata = quarter;
    11'b000_0100_0000: nxt_hrdata = fft_num;
    11'b000_1000_0000: nxt_hrdata = fft_stage_number;
    11'b001_0000_0000: nxt_hrdata = mel_num;
    11'b010_0000_0000: nxt_hrdata = cep_num;
    11'b100_0000_0000: nxt_hrdata = trigger_reg;
    default:           nxt_hrdata = 32'b0;
  endcase        
end        

always @(posedge hclk or negedge hresetn) begin
  if (!hresetn) begin
    hrdata <= 32'b0; 
  end
  else begin
    hrdata <= nxt_hrdata;
  end        
end        

//AHB Responds
assign hresp = 2'b0;
assign hready_out = 1'b1;

endmodule
