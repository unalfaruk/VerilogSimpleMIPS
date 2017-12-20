`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/14/2017 11:46:57 AM
// Design Name: 
// Module Name: simpleMipsCPU_tb
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


module simpleMipsCPU_tb(

    );
    
    reg clk;
    wire [31:0] result;
    wire [31:0] receivedDataFromMemory;
    
    simpleMipsCPU mipsSimple(clk,result,receivedDataFromMemory);
    
    initial begin
        clk=0; 
        forever #100 clk=~clk;
    end
endmodule
