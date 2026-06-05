# RISC-V 64-Bit Single-Cycle Processor Core

A hardware implementation of a single-cycle RISC-V 64-bit processor core designed in behavioral and structural Verilog. This processor natively parses machine code instructions, executes datapath arithmetic, performs memory-mapped loads/stores, and handles conditional relative branch offsets.

## 🚀 Key Features & Architectural Highlights
* **64-bit Architecture:** Data paths, ALU buses, internal registers, and data memory addresses are optimized for full 64-bit execution.
* **Single-Cycle Execution:** Every instruction decodes, executes, and writes back within a single clock cycle.
* **Internal Write-First Forwarding:** The Register File includes combinational bypass/forwarding logic to prevent simulation race conditions during simultaneous read/write cycles to the same register.
* **Doubleword-Aligned Memory Layout:** The data memory configuration features byte-to-doubleword truncation addressing (`Address[12:3]`), ensuring robust structural alignment.

---
## 📐 Processor Architecture & Datapath Layout
The Processor follows **Harvard Architecture** with separate Memories for Instruction and Data fetching.This provides facility to read instruction and access data in memory in the same clock cycle
Below is the structural topography followed for this 64-bit single-cycle implementation, tracing the complete instruction execution flow from the Program Counter to the Writeback multiplexer network:



## ⚡ Design Considerations & Core Optimizations

### 1. Simulation-Edge Race Condition Mitigation
During simulation testing, back-to-back instructions accessing the same registers introduced clock-edge timing races common in behavioral Verilog environments. To maintain a strict single-cycle execution target without adding pipeline stages, a **combinational write-first bypass network** was designed into the register file. If a read address matches an active write-back address on the same cycle, the internal memory array is bypassed to route the data straight to the output ports.

### 2. Critical Path Awareness
The primary critical path of this single-cycle architecture runs from the **Program Counter $\rightarrow$ Instruction Memory $\rightarrow$ Register File $\rightarrow$ ALU $\rightarrow$ Data Memory $\rightarrow$ Writeback MUX**. To minimize propagation delays across this long path, the ALU uses flat bitwise operations instead of deeply nested conditional statements, keeping the combinational settling time as low as possible.

### 3. Verification & Settlement Windows
The verification architecture utilizes an automated, self-checking testbench framework. To prevent false negatives caused by signals transitioning exactly at the clock edge, the testbench incorporates a small propagation settlement delay (`#2`) after the rising edge. This ensures all combinational control signals and data buses are completely stable before assertions evaluate them.

---

## 🛠️ Instruction Set Architecture (ISA) Support

The processor core currently decodes and executes the following core RISC-V instructions:

| Instruction Category | Assembly Mnemonic | Description |
| :--- | :--- | :--- |
| **I-Type (Arithmetic)** | `addi rd, rs1, imm` | Add Immediate |
| | `andi rd, rs1, imm` | Bitwise AND Immediate |
| | `ori rd, rs1, imm`  | Bitwise OR Immediate |
| | `xori rd, rs1, imm` | Bitwise XOR Immediate |
| **R-Type (Arithmetic)** | `add rd, rs1, rs2`  | Add Registers |
| | `sub rd, rs1, rs2`  | Subtract Registers |
| **R-Type (Bitwise)** | `and rd, rs1, rs2`  | Bitwise AND Registers |
| | `or rd, rs1, rs2`   | Bitwise OR Registers |
| | `xor rd, rs1, rs2`  | Bitwise XOR Registers |
| **S-Type (Memory Write)**| `sd rs2, offset(rs1)`| Store Doubleword (64-bit) |
| **I-Type (Memory Read)** | `ld rd, offset(rs1)` | Load Doubleword (64-bit) |
| **B-Type (Control Flow)**| `beq rs1, rs2, offset`| Branch if Equal (PC Relative) |
| | `bne rs1, rs2, offset`| Branch if Not Equal (PC Relative) |

---

## 📂 Repository Structure

* `/src`
  * `CPU_Top.v`
  * `Instruction_Memory.v`
  * `Data_Memory.v`
  * `/CPU_Core`
    * `CPU_Core.v`
    * `/Top_Control_Unit`
      * `Top_Control_Unit.v`
      * `MainControlUnit.v`
      * `ALU_Control.v`
    * `/Datapath`
      * `Program_Counter.v`
      * `PC_InputController.v`
      * `RegisterFile.v`
      * `ImmGen.v`
      * `ALU_mux.v`
      * `ALU.v`
      * `Output_MUX.v`
* `/sim`
  * `CPU_Top_Assembly_tb.v`

---

## 💻 Simulation Instructions

This design is validated using Xilinx Vivado . Design has passed synthesis with **0 DRC violations**.


