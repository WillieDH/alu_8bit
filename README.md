# 8-bit Arithmetic Logic Unit (ALU) with UVM

## Project Overview

This repository showcases an 8-bit Arithmetic Logic Unit (ALU) designed in Verilog, with a Universal Verification Methodology (UVM) testbench. The ALU is a fundamental component of a CPU, capable of performing a wide range of arithmetic and logical operations. It is meant to be one piece of a future project.

---

## Features

The 8-bit ALU includes 5 modules:

### 1. Adder/Subtractor Module
- **Unsigned Addition & Subtraction**: Performs standard 8-bit unsigned arithmetic.
- **Signed Addition & Subtraction**: Supports 8-bit two's complement signed arithmetic.
- **Overflow Flags**: Provides dedicated overflow flags for both unsigned (carry-out) and signed operations (detecting incorrect sign changes).
- **Control Bits**: OP[1:0] controls both signed vs. unsigned and add vs. subtraction. OP[0] is 0 for unsigned and 1 for signed, while OP[1] is 0 for addition and 1 for subtraction.
- **Output**: The 16-bit output resultF is parsed like this: [0:7] -> SUM, [8] -> carry-out, [9] -> v_flag. All other bits are 0. 

### 2. Multiplier Module
- **Unsigned Multiplication**: Performs 8-bit unsigned multiplication, producing a 16-bit product.
- **Signed Multiplication**: Supports 8-bit two's complement signed multiplication, yielding a 16-bit signed product.
- **Control Bits**: OP[0] controls signed vs. unsigned. OP[0] is 0 for unsigned and 1 for signed.
- **Output**: The 16-bit output resultF is just the full product. 

### 3. Logic Module
- **AND**: Bitwise logical AND.
- **OR**: Bitwise logical OR.
- **NOT**: Bitwise logical NOT (on input A).
- **XOR**: Bitwise logical XOR.
- **Control Bits**: OP[1:0] controls the logical operations: 00 for AND, 01 for OR, 10 for XOR, 11 for NOT.
- **Output**: The 16-bit output resultF is parsed like this: [7:0] -> result of logical operation. All other bits are 0.

### 4. Shifter Module
- **Logical Left Shift**: Shifts bits to the left, filling with zeros.
- **Logical Right Shift**: Shifts bits to the right, filling with zeros.
- **Arithmetic Right Shift**: Shifts bits to the right, preserving the sign bit.
- **Rotate Left**: Rotates bits to the left.
- **Rotate Right**: Rotates bits to the right.
- **Control Bits**: OP[2:0] controls shift direction, type, and rotation enable. OP[0] is 0 for left and 1 for right. OP[1] is 0 for logical and 1 for arithmetic. OP[2] is 0 for rotate not enabled and 1 for rotate enabled.
- **Output**: The 16-bit output resultF is parsed like this: [0:7] -> shifted result. All other bits are 0.

### 5. Comparator Module
- **Equal To (==)**: Checks if two inputs are equal.
- **Unsigned Greater Than (>)**: Compares two unsigned inputs.
- **Unsigned Less Than (<)**: Compares two unsigned inputs.
- **Signed Greater Than (>)**: Compares two signed inputs.
- **Signed Less Than (<)**: Compares two signed inputs.
- **Control Bits**: OP[2:0] controls comparison type and unsigned vs. signed. OP[1:0] is 00 for equal to, 01 for greater than, and 10/11 for less than. OP[2] is 0 for unsigned and 1 for signed.
- **Output**: The 16-bit output resultF is parsed like this: [0] -> result of comparison. All other bits are 0.
---

## Design Overview

The top-level `alu_8bit` module instantiates and controls the individual functional units:

- `adder_8bit`: Performs all addition and subtraction operations, including overflow detection. It utilizes `full_adder` and `half_adder` sub-modules. (000)
- `multiplier_8bit`: Performs both unsigned and signed 8-bit multiplication. (001)
- `logic_8bit`: Performs bitwise logical operations. (011)
- `shifter_8bit`: Performs various shift and rotate operations. (010)
- `comparator_8bit`: Performs various compare operations. (100)
A 6-bit `OP` (operation) input selects the desired function and mode (e.g., signed/unsigned, shift type). Bits [5:3] are used to select which module to use. 

---

## Verification Methodology (UVM Testbench)

A comprehensive UVM testbench has been developed to verify the functionality of the 8-bit ALU.

### Testbench Components

- **`my_transaction`**: Defines the data packet (`A`, `B`, `OP`) that flows through the testbench.
- **`my_sequence`**: Generates randomized stimulus for all ALU operations.
- **`my_driver`**: Drives the generated transactions onto the DUT's interface (`my_if`).
- **`my_monitor`**: Observes the activity on the DUT's interface and converts it back into transaction objects.
- **`my_scoreboard`**: Contains a behavioral reference model that predicts the expected output and compares it against the DUT output.
- **`my_subscriber`**: Implements functional coverage using SystemVerilog `covergroup` constructs.
- **`my_agent`**: Encapsulates the driver, monitor, and sequencer.
- **`my_env`**: Integrates the agent, scoreboard, and subscriber.
- **`my_test`**: Top-level test class that orchestrates the simulation.
- **`my_pkg`**: Package to organize all UVM components.

### Verification Strategy

- The testbench employs **Constrained Random Verification (CRV)**.
- `my_sequence` generates randomized inputs (`A`, `B`) and iterates through all defined OP codes.
- `my_scoreboard` serves as a **golden reference model**.
- **Functional coverage** is collected to assess test suite completeness.

---

## Software Used

I used Vivado 2023.2. 

---
## Contact
LinkedIn: https://www.linkedin.com/in/williehedrickce/

