# VHDL ALU Project

This project implements an Arithmetic Logic Unit (ALU) in VHDL. It includes various components like adders, subtractors, logic units, shifters, and a PWM module.

## Project Structure

The project is organized into two main directories:

*   `DUT/`: Contains the Design Under Test (DUT) VHDL files.
*   `TB/`: Contains the Testbench VHDL files for simulating the DUT components.

### DUT Files

*   `AdderSub.vhd`: Implements an adder/subtractor unit.
*   `FA.vhd`: Implements a Full Adder, likely used by `AdderSub.vhd`.
*   `Logic.vhd`: Implements logical operations (AND, OR, XOR, NOT).
*   `PLL.vhd`: Implements a Phase-Locked Loop, typically used for clock generation in FPGAs.
*   `Shifter.vhd`: Implements a shifter unit (logical/arithmetic shifts).
*   `alu.vhd`: The main Arithmetic Logic Unit, integrating various arithmetic and logical functions.
*   `alu_fmax.vhd`: Possibly a version of the ALU optimized for maximum frequency (fmax) or a testbench for fmax analysis.
*   `aux_package.vhd`: A VHDL package file likely containing common constants, types, or utility functions used across different modules.
*   `hex_decoder.vhd`: Decodes a binary input to drive a 7-segment hexadecimal display.
*   `pwm.vhd`: Implements a Pulse Width Modulation (PWM) module.
*   `pwm_top.vhd`: A top-level entity for the PWM module, possibly for synthesis or standalone testing.
*   `top.vhd`: The overall top-level design file, likely integrating the ALU and other components for a specific application or FPGA target.
*   `top.vhd.bak`: A backup file of `top.vhd`.

### TB Files

*   `AdderSub_tb.vhd`: Testbench for the `AdderSub.vhd` unit.
*   `Logic_tb.vhd`: Testbench for the `Logic.vhd` unit.
*   `Shifter_tb.vhd`: Testbench for the `Shifter.vhd` unit.
*   `alu_tb.vhd`: Testbench for the main `alu.vhd`.
*   `pwm_tb.vhd`: Testbench for the `pwm.vhd` module.
*   `top_tb.vhd`: Testbench for the top-level design `top.vhd`.
