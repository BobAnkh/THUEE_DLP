module bcd7(
    input [3:0] din,
    input en,
    output reg [6:0] dout
);

always @(*)
begin
    if (en==1'b0) dout<=7'b0;
    else if(din==4'h0) dout<=7'b0111111;
    else if(din==4'h1) dout<=7'b0000110;
    else if(din==4'h2) dout<=7'b1011011;
    else if(din==4'h3) dout<=7'b1001111;
    else if(din==4'h4) dout<=7'b1100110;
    else if(din==4'h5) dout<=7'b1101101;
    else if(din==4'h6) dout<=7'b1111101;
    else if(din==4'h7) dout<=7'b0000111;
    else if(din==4'h8) dout<=7'b1111111;
    else if(din==4'h9) dout<=7'b1101111;
    else dout<=7'b0;
end
endmodule

