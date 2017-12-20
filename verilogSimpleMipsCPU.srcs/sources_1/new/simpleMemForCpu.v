`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/14/2017 11:41:58 AM
// Design Name: 
// Module Name: simpleMemForCpu
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module simpleMemForCpu(    
    input [4:0] address,
    input rw,
    input enable,
    inout [31:0] word
    );
    
    reg [31:0] mem [31:0];
    reg [31:0] word_out;
    integer i;
    initial begin        
        for(i=0;i<32;i=i+1) begin 
            mem[i]=32'd0;
        end
        
        mem[0]=32'b00000000001000100100000000100000; //add r1,r2,r8 //r8=r1+r2
        mem[1]=32'b00000000011001000100100000100010; //sub r3,r4,r9 //r9=r3-r4
        mem[2]=32'b00000001000010010101000000011010; //div r8,r9,r10 //r10=r8/r9
        mem[3]=32'b00000000101010100101100000011000; //mul r5,r10,r11 //r11=r10*r5
        mem[4]=32'b00000011111111111111111111001101; //stop //halt status
    end    
    
    assign word = (enable == 1 && rw == 1)? word_out:32'bz; //if there are enable bit and read bit, the word will behave as output.
    
    always @(rw or enable or address)
    begin
        if(enable ==1) begin //enable mode
            if(rw==1) begin //read mode
                    word_out<=mem[address];
                end
            else //write mode
                begin
                    mem[address]<=word;
                end
        end
    end
endmodule
