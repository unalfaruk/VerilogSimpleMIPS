`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/14/2017 11:41:24 AM
// Design Name: 
// Module Name: simpleMipsCPU
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


module simpleMipsCPU(
    input clk,
    output [31:0] result,
    output [31:0] word
    );
    
    reg [31:0] generalRegisters [31:0];
    
    wire [31:0] word;
    wire rw=1'b1;
    wire enable=1'b1;
    integer i;
    
    initial begin
        for(i=0;i<32;i=i+1) begin
            generalRegisters[i]=32'd0;
        end
        /*
        Actually, these assignments are not true. Because, according to MIPS Registers,
        we should use r8-r15 as general registers. But we used r1-r11
        */
        generalRegisters[0] = 32'd0; //r0 (always hard wired to 0)
        generalRegisters[1]=32'd48; //r1
        generalRegisters[2]=32'd24; //r2
        generalRegisters[3]=32'd40; //r3
        generalRegisters[4]=32'd4; //r4
        generalRegisters[5]=32'd2; //r5
        
        programCounter=5'd0;
    end  
    
    reg [1:0] doneFlag=0;
    reg [4:0] programCounter;
    reg [31:0] resultTemp;
    
    always @(posedge clk)
    begin
        /*
        This code block will behave like an ALU.
        */
        case(word[5:0])
            6'b100000: generalRegisters[word[15:11]]=generalRegisters[word[25:21]]+generalRegisters[word[20:16]];
            6'b100010: generalRegisters[word[15:11]]=generalRegisters[word[25:21]]-generalRegisters[word[20:16]];
            6'b011010: generalRegisters[word[15:11]]=generalRegisters[word[25:21]]/generalRegisters[word[20:16]];
            6'b011000: generalRegisters[word[15:11]]=generalRegisters[word[25:21]]*generalRegisters[word[20:16]];
            6'b001101: doneFlag=1'b1;
            default: doneFlag=1'b1;
        endcase
        if(doneFlag==0) begin //check the halt status
            programCounter=programCounter + 1;
        end
    end    
    
    simpleMemForCpu simpleMemForCpuOne(programCounter,rw,enable,word);
    
    assign result = (doneFlag == 1)? generalRegisters[11]:32'b0; //if done flag is ok, we can show the result on the output.

endmodule
