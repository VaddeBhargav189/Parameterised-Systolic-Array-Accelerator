# Parameterized Systolic Array Accelerator

A parameterized **Verilog implementation of a Systolic Array Accelerator** for matrix multiplication. The design is scalable and configurable through parameters, allowing different array sizes and input data widths without modifying the core RTL.

This project demonstrates RTL design principles, modular hardware architecture, parameterization, and synchronous dataflow commonly used in AI/ML accelerators.

---

# Features

- Parameterized array size (`N × N`)
- Configurable input data width
- Modular RTL architecture
- Scalable Processing Element (PE) array
- Controller-based computation flow
- Fully synthesizable Verilog HDL
- Simulation-ready design

---

# Architecture

The accelerator consists of the following modules:

```text
                  +------------------+
                  |    Controller    |
                  +--------+---------+
                           |
                           v
                  +------------------+
                  | Input Scheduler  |
                  +--------+---------+
                           |
          +----------------+----------------+
          |                                 |
          v                                 v
   +--------------+                 +--------------+
   |   A Buffer   |                 |   B Buffer   |
   +------+-------+                 +------+-------+
          |                                |
          +------------+  +----------------+
                       |  |
                       v  v
                +------------------+
                |     PE Array     |
                |   (N × N PEs)    |
                +--------+---------+
                         |
                         v
                +------------------+
                |  Output Buffer   |
                +------------------+
```

---

# Processing Element (PE)

Each Processing Element performs the following operations every clock cycle:

- Receives one input from the left and one input from the top.
- Performs a Multiply-Accumulate (MAC) operation.
- Forwards the input operands to neighboring Processing Elements.
- Accumulates the partial sum locally.

Operation:

```text
sum = sum + (A × B)
```

---

# Parameterization

The entire design can be scaled by modifying only the following parameters:

| Parameter | Description |
|-----------|-------------|
| `N` | Size of the systolic array (`N × N`) |
| `DATA_WIDTH` | Width of each input data element |

Example:

```verilog
parameter N = 4;
parameter DATA_WIDTH = 8;
```

Changing these parameters automatically scales the complete architecture.

---

# Project Structure

```text
Parameterized-Systolic-Array/
│
├── Architecture/
│   └── Architecture Diagram
│
├── RTL_Design/
│   ├── controller.v
│   ├── input_scheduler.v
│   ├── buffer_in.v
│   ├── pe.v
│   ├── pe_array.v
│   ├── buffer_out.v
│   └── top.v
│
├── Test_Bench/
│   └── top_tb.v
│
├── Simulation_Results/
│   └── simulation_results
│
└── README.md
```

---

# Design Flow

1. The controller initiates the computation.
2. The input scheduler streams matrix elements from the A and B buffers.
3. The PE array performs parallel Multiply-Accumulate (MAC) operations.
4. Partial sums propagate through the array until the final results are generated.
5. The computed output matrix is stored in the output buffer.

---

# Tools Used

- Verilog HDL
-  Xilinix.Vivado
- Visual Studio Code (VS Code)

---

# Applications

- Matrix Multiplication
- AI/ML Accelerators
- Digital Signal Processing (DSP)
- Image Processing
- Linear Algebra Computation

---

# Future Improvements

- Larger systolic array configurations
- Fixed-point and floating-point support
- Performance optimization and pipelining
