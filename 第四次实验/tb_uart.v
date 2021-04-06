`timescale  1ns / 1ps

module tb_uart;

// UART_MEM Parameters
parameter PERIOD        = 10       ;
// Baud rate=1M
parameter CLKS_PER_BIT  = 16'd100;
parameter MEM_SIZE      = 512      ;

// UART_MEM Inputs
reg   clk                                  = 0 ;
reg   rst                                  = 1 ;
reg   mem2uart                             = 0 ;
reg   Rx_Serial                            = 0 ;

// UART_MEM Outputs
wire  recv_done                            ;
wire  send_done                            ;
wire  Tx_Serial                            ;

// UART_RX_SHOW
wire  s_Rx_DV                              ;
wire [7:0] s_Rx_Byte                       ;

// data
reg [7:0] send_data[4095:0]                ;
reg [7:0] ref_data[2047:0]                 ;
reg [7:0] output_data[2047:0]              ;
reg [12:0] count=0                         ;
reg [12:0] cnt=0                           ;
reg correct=1                              ;

initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD*2) rst  =  0;
end

UART_MEM #(
    .CLKS_PER_BIT ( CLKS_PER_BIT ),
    .MEM_SIZE     ( MEM_SIZE     ))
 u_UART_MEM (
    .clk                     ( clk         ),
    .rst                     ( rst         ),
    .mem2uart                ( mem2uart    ),
    .Rx_Serial               ( Rx_Serial   ),

    .recv_done               ( recv_done   ),
    .send_done               ( send_done   ),
    .Tx_Serial               ( Tx_Serial   )
);

//define a uart_rx to receive the data sent by UART_MEM
uart_rx #(.CLKS_PER_BIT(CLKS_PER_BIT)) UART_RX_SHOW
    (.i_Clock(clk),
     .i_Rx_Serial(Tx_Serial),
     .o_Rx_DV(s_Rx_DV),
     .o_Rx_Byte(s_Rx_Byte)
     );

// read and receive data
initial
begin
    $readmemh("C:/Users/lenovo/send.txt", send_data);
    $readmemh("C:/Users/lenovo//ref.txt",ref_data);
    for (count = 0; count<13'd4096 ; count = count+1'd1) begin
        Rx_Serial = 0;
        #(PERIOD*CLKS_PER_BIT) Rx_Serial=send_data[count][0];
        #(PERIOD*CLKS_PER_BIT) Rx_Serial=send_data[count][1];
        #(PERIOD*CLKS_PER_BIT) Rx_Serial=send_data[count][2];
        #(PERIOD*CLKS_PER_BIT) Rx_Serial=send_data[count][3];
        #(PERIOD*CLKS_PER_BIT) Rx_Serial=send_data[count][4];
        #(PERIOD*CLKS_PER_BIT) Rx_Serial=send_data[count][5];
        #(PERIOD*CLKS_PER_BIT) Rx_Serial=send_data[count][6];
        #(PERIOD*CLKS_PER_BIT) Rx_Serial=send_data[count][7];
        #(PERIOD*CLKS_PER_BIT) Rx_Serial=1;
        #(PERIOD*CLKS_PER_BIT); 
    end
end

//Recieve done and change to send data
always @(posedge recv_done) begin
    $display("Receive Done!");
    mem2uart = 1;
end

always @(posedge s_Rx_DV) begin
    if (cnt<13'd2048) begin
        output_data[cnt] = s_Rx_Byte;
        cnt = cnt+1'd1;
    end
end

//Validate
always @(posedge send_done) begin
    $display("Send done!");
    for(count=0; count<13'd2048; count=count+1) begin
        if(ref_data[count]!=output_data[count])begin
            $display("The %d is not correct!",count);
            $display("Ref:%d",ref_data[count]);
            $display("Output:%d",output_data[count]);
            correct = 0;
        end
    end
    if (correct == 0) begin
        $display("Test not pass!Something is wrong!");
    end 
    else begin
        $display("Test pass!All is correct!");
    end
    #(PERIOD*8000000)
    $stop;
end
endmodule
