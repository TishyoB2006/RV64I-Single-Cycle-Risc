
# 🛠️ Simulation Working & Execution Analysis(Explanation for Sim2.png)

This document traces the hardware execution profile verified across the processor core simulation waveforms.

## 📊 Sim1: Assembly Code Verification

The processor was initialized and loaded with a custom diagnostic program designed to exercise computational arithmetic, bitwise logic operations, data memory routing, and relative branching mechanisms:

```assembly
addi x1, x0, 10    # Load immediate value 10 into register x1
addi x2, x0, 20    # Load immediate value 20 into register x2 
add  x3, x1, x2    # Add x1 and x2, store result (30) in x3
sub  x4, x2, x1    # Subtract x1 from x2, store result (10) in x4
and  x5, x1, x2    # Bitwise AND x1 and x2, store result (0) in x5
or   x6, x1, x2    # Bitwise OR x1 and x2, store result (30) in x6
sd   x3, 0(x0)     # Store the 64-bit value of x3 (30) at Data Memory address 0
ld   x7, 0(x0)     # Load the 64-bit value from Data Memory address 0 into x7
beq  x7, x3, +8    # If x7 == x3, skip the next instruction by jumping +8 bytes
addi x8, x0, 99    # Target instruction to be bypassed by the conditional branch

```

---

## 🔍 Simulation Waveform Explanation

1. **Clock Generation:** The **blue waveform** depicts the master clock cycle running through the single-cycle core pipeline.
2. **Program Counter State:** The **pink waveform** depicts the Program Counter (PC). It correctly increments sequentially by `4` bytes after each standard instruction and jumps by `8` bytes when the `beq` branch condition resolves to true.
3. **Instruction Stream:** The waveform tracking directly below the PC displays the raw instructions currently being passed into the central decoder of the processor.
4. **ALU Control:** The **dark blue waveform** represents the decoded output of the ALU Control module, showing the precise operation codes dispatched during execution.
5. **Architectural Registers:** The final seven waveform lines map out the live contents of registers `x1` through `x7` directly within the Register File matrix.

---

## 💡 Step-by-Step Hardware Behavior

* **Single-Cycle Flow:** Because this architecture is a pure single-cycle RISC-V implementation, a second instruction starts its decoding path only after the preceding instruction completes its writeback execution cycle.
* **Arithmetic & Logic Computations:**
* `x1 = x0 + 10 = 10`
* `x2 = x0 + 20 = 20`
* `x3 = x1 + x2 = 30`
* `x4 = x2 - x1 = 10`
* `x5 = x1 & x2 (bitwise) = 0`
* `x6 = x1 | x2 (bitwise) = 30`


* **Data Memory Handshake:** The active contents of register `x3` are transferred out of the datapath and stored at memory address zero (`sd`). On the following cycle, that exact word is loaded from address zero back into register `x7` (`ld`), resulting in `x7 = 30`.
* **Branch Bypassing Execution:** As the `beq` statement executes, the processor evaluates `x7` against `x3`. Since `30 == 30`, the branch triggers. The PC skips the subsequent instruction (`addi x8, x0, 99`) entirely by incrementing by `8` bytes instead of `4`, ensuring it is never executed.

```

```
