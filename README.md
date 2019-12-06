# NTP-microprocessor



* ## Overview
  
  A real time Microprocessor  impemented in verilog and tested on Xilinx Spartan 3E FPGA.
  It's a RISC based 8 bit 5 stage pilelined proccessor with 28 bit instruction format and 579.67 Mhz clock frequency.
  
  Individual module implementations for:
  * Instruction Fetch
  * Instruction Decode
  * Execution Block
  * Data Memory Block
  * Write Back Block
  * Dependency Check Block
  * Jump Control Block
  * Stall Control Block
  * Register Bank Block

* ## Specifcations and Features

  * 8-bit Processor.
  * Instruction Size 24-bit.
  * 28 Distinct Instructions.
  * Fixed Instruction Size (24 bits).
  * RISC based architecture.
  * 5 Staged pipelined processor.
  * Maximum Clock Frequency 579.374 MHz.
  * 32 Registers.
  * Ideal CPI = 1.
  * Five types of Instruction format (R, I, J, M and I/O type).
  * Harvard type architecture as there are separate storage blocks and signal pathways are provided for data memory and program memory.
  * Two types of addressing modes register direct mode and register immediate addressing mode.
  * Simpler Architecture.
  * CPI = 1.33333333.
  * Program Memory 768 bytes.
  * Data Memory 256 bytes.
  * 21 pins (data_in 8, data_out 8, clk, reset, Vcc, Ground and Interrupt each)
  
* ## Block Diagram

![Block Diagram](/home/parshwa/Desktop/BlockDiagram.png)
![Alt text](/home/parshwa/Desktop/BlockDiagram.png?raw=true "Title")






