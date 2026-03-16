# picoMIPS: Area-Optimized 8-bit Processor for Affine Transformation on FPGA

This repository contains the complete design and implementation of a custom **8-bit picoMIPS processor**, specifically crafted to perform affine transformations on graphical pixels. The processor was synthesized and successfully deployed on an **Altera FPGA** with a primary goal of **minimal hardware resource utilization**—demonstrating a cost-effective, application‑specific embedded solution.

---

## 🚀 Project Overview

The affine transformation of a point `(X1, Y1)` to `(X2, Y2)` is described by:

X2 = (A11 * X1 + A12 * Y1) + B1
Y2 = (A21 * X1 + A22 * Y1) + B2


To execute this algorithm efficiently, a dedicated **9‑instruction picoMIPS architecture** was designed from scratch. The processor features an 8‑bit datapath, a 24‑bit instruction width, and a custom datapath that allows direct input from FPGA switches. The entire system was simulated, synthesized, and verified on an Altera board, achieving an extremely compact hardware footprint.

---

## ✨ Key Features

- **Custom Instruction Set** – 9 specialized instructions (ADD, ADDI, ADDF, MUL, MULI, BREL, BABS, NOP) tailored for the affine transformation.
- **Optimised Datapath** – 8‑bit data bus, 24‑bit instruction word (6‑bit opcode + 5‑bit dest reg + 5‑bit src reg + 8‑bit immediate).
- **Minimal Hardware Cost** – Synthesised on Altera FPGA using only **72 Adaptive Logic Modules (ALMs)**, **1 DSP multiplier**, and **0 memory bits**.
- **Input Flexibility** – Supports both signed/unsigned 8‑bit inputs via on‑board switches; includes a multiplexer to feed switch data directly into the ALU.
- **Hardware/Software Co‑Design** – Implements the affine transformation algorithm in assembly‑like machine code stored in program memory.
- **Complete Verification** – Simulated each module (ALU, GPR, Decoder, Program Memory) and the top‑level design using SystemVerilog testbenches.
- **FPGA Proven** – Successfully synthesized, placed, and routed on an Altera board; real‑time operation validated with switch inputs and LED outputs.

---

## 🧠 Architecture

The processor consists of the following main blocks:

- **Program Counter (PC)** – 8‑bit counter addressing the program memory.
- **Program Memory** – 24‑bit wide ROM containing the affine transformation machine code.
- **Instruction Decoder** – Decodes the 6‑bit opcode and generates control signals for the datapath.
- **General Purpose Register File (GPR)** – Eight 32‑bit registers (only four are actively used for the algorithm).
- **ALU** – Performs addition, subtraction, and multiplication; includes flag generation (carry, overflow). Multiplication result is truncated to bits [14:7] as per specification.
- **Input MUX** – Selects between immediate literals (from instruction) and live switch data, controlled by the `ADDF` instruction.

![Block Diagram](images/block_diagram.png)  
*Figure: High‑level block diagram (Green – control path, Red – address, Blue – data path)*

---

## 📜 Instruction Set

| Mnemonic | Format                          | Operation                                      |
|----------|----------------------------------|------------------------------------------------|
| `ADD`    | ADD  %d, %s                      | `%d = %d + %s`                                 |
| `ADDI`   | ADDI %d, %s, imm                 | `%d = %s + imm`                                |
| `ADDF`   | ADDF %d, 0                       | `%d = %s + switch_input` (input from switches) |
| `MUL`    | MUL  %d, %s                      | `%d = %d * %s`                                 |
| `MULI`   | MULI %d, %s, imm                 | `%d = %s * imm`                                |
| `BREL`   | BREL Address                     | Branch if `sw[8] == instruction[7]`            |
| `BABS`   | BABS Address                     | Unconditional jump to address                   |
| `NOP`    | NOP                              | No operation                                   |

All arithmetic operations work on 8‑bit values, with the ALU internally handling 8‑bit results and flags.

---

## ⚙️ Implementation Results

- **Total ALMs** : 72  
- **DSP Multipliers** : 1  
- **Memory Bits** : 0  
- **Max Frequency** : (can be added after timing analysis)  
- **Instruction Width** : 24 bits  
- **Data Width** : 8 bits  
- **Synthesis Optimisation** : "Area" mode in Quartus Prime

> 💡 The design was deliberately optimised for **area**, demonstrating how application‑specific processors can achieve significant hardware savings compared to general‑purpose cores.

---

## 🛠️ Design Flow

1. **RTL Design** – SystemVerilog modules for PC, program memory, decoder, register file, ALU, and top‑level integration.
2. **Simulation** – Individual module testbenches and top‑level simulation using ModelSim/Questa.
3. **Synthesis** – Quartus Prime synthesis with "Area" optimisation target.
4. **Place & Route** – Automatic place‑and‑route on Altera FPGA.
5. **On‑chip Verification** – Clock divider used to slow down the system for manual I/O; inputs provided via switches, outputs observed on LEDs.

---

## 🚦 Getting Started

### Prerequisites
- **Quartus Prime** (for synthesis and FPGA programming)
- **ModelSim/Questa** (for simulation, optional)
- **Altera FPGA board** (e.g., DE-series with switches and LEDs)

### Simulation
1. Clone this repository.
2. Open your simulator and compile all `.sv` files in the `rtl/` directory.
3. Run the provided testbenches (e.g., `tb_alu.sv`, `tb_picoMIPS.sv`) to verify functionality.

### Synthesis & Programming
1. Open the Quartus project file (`picoMIPS.qpf`).
2. Ensure the device is set to your specific Altera FPGA.
3. Compile the design (Analysis & Synthesis → Fitter → Assembler).
4. Program the FPGA using the generated `.sof` file.
5. Use switches to provide `X1` and `Y1` values; observe results on LEDs (or a 7‑segment display if extended).

---

---

## 📈 Future Improvements

- Reduce instruction width to 20 bits (3‑bit register addresses) to further lower cost.
- Add a 7‑segment display output for easier result reading.
- Implement pipelining for higher throughput (though area would increase).
- Extend the instruction set to support more complex graphics algorithms.

---

## 📚 References

- [ELEC6234 Embedded Processor Synthesis Notes](https://secure.ecs.soton.ac.uk/notes/elec6234/) – Dr. Tom J. Kazmierski
- Zwolinski, M., *Digital System Design with SystemVerilog*, Pearson, 2010.

---

## 👤 Author

**Akash Biyani**  
*University of Southampton*  
Project completed as part of the ELEC6234 coursework.

---

## 📄 License

This project is open‑source and available under the MIT License. See the [LICENSE](LICENSE) file for details.

