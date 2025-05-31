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

## Simulation

To simulate the VHDL designs, you can use a VHDL simulator such as GHDL (open-source) or ModelSim/QuestaSim (commercial).

The general steps for simulation are:

1.  **Compile the VHDL files:** Compile the DUT files first, followed by the testbench files. Ensure that files are compiled in the correct order of dependency (e.g., `FA.vhd` before `AdderSub.vhd` if `AdderSub.vhd` instantiates `FA.vhd`). The `aux_package.vhd` should likely be compiled first or early in the order.
    *   Example with GHDL:
        ```bash
        ghdl -a DUT/aux_package.vhd
        ghdl -a DUT/FA.vhd
        ghdl -a DUT/AdderSub.vhd
        ghdl -a DUT/Logic.vhd
        ghdl -a DUT/Shifter.vhd
        ghdl -a DUT/alu.vhd
        ghdl -a DUT/pwm.vhd
        ghdl -a DUT/hex_decoder.vhd
        ghdl -a DUT/PLL.vhd # May not be directly simulatable without FPGA vendor libraries or models
        ghdl -a DUT/top.vhd
        ghdl -a TB/AdderSub_tb.vhd
        ghdl -a TB/Logic_tb.vhd
        ghdl -a TB/Shifter_tb.vhd
        ghdl -a TB/alu_tb.vhd
        ghdl -a TB/pwm_tb.vhd
        ghdl -a TB/top_tb.vhd
        ```

2.  **Elaborate the top-level testbench:**
    *   Example with GHDL (for `alu_tb`):
        ```bash
        ghdl -e alu_tb
        ```

3.  **Run the simulation:**
    *   Example with GHDL:
        ```bash
        ghdl -r alu_tb --wave=alu_tb.ghw
        ```
        This will generate a waveform file (`alu_tb.ghw`) that can be viewed with GTKWave.

Replace `alu_tb` with the name of the specific testbench you want to run (e.g., `top_tb`, `pwm_tb`).

**Note on `PLL.vhd`:** Simulating PLLs accurately usually requires FPGA vendor-specific libraries or models. A behavioral model in `PLL.vhd` might provide basic clock generation for simulation purposes.

## Synthesis

The top-level files intended for synthesis appear to be `top.vhd` or possibly `pwm_top.vhd` if the PWM module is to be synthesized standalone.

To synthesize the design:

1.  **Choose a synthesis tool:** Tools like Xilinx Vivado, Intel Quartus Prime, or open-source tools like Yosys can be used.
2.  **Set up a new project:** Create a new project in your chosen synthesis tool.
3.  **Add VHDL files:** Add all relevant DUT VHDL files to the project. The tool will typically determine the correct compilation order. Ensure `aux_package.vhd` is included.
4.  **Select the target FPGA/ASIC device:** Choose the specific hardware you are targeting.
5.  **Set constraints:** Define clock constraints, pin assignments, and other timing or physical constraints as needed. The `PLL.vhd` will likely be replaced by an IP core or primitive specific to your target FPGA for actual hardware implementation.
6.  **Run synthesis and implementation:** Follow the tool's workflow to synthesize the design, place and route, and generate a bitstream or GDSII file.

The `top.vhd` file is likely the main top-level entity for the entire ALU system. `pwm_top.vhd` might be used if you only want to synthesize the PWM functionality.
