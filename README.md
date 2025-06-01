# RISC-V Single-Cycle Core

This project implements a simple single-cycle RISC-V processor core.  
It is adapted from the excellent educational design by [merldsu](https://github.com/merldsu/RISCV_Single_Cycle_Core).

## 🔧 Project Structure

- `RTL_Codes/Single_Cycle_Top.v`: Main Verilog module for the processor core.
- `README.md`: Project overview and attribution.
- `LICENSE`: Open-source MIT License.
- `.gitignore`: Ignores simulation artifacts and temporary files.

## 📘 How to Use

1. Open the project in a Verilog simulator (like ModelSim, Vivado, or Icarus Verilog).
2. Add a testbench and memory model.
3. Simulate and analyze the single-cycle behavior of the core.

## 💡 Attribution

This project is based on:
- **Original repo:** [merldsu/RISCV_Single_Cycle_Core](https://github.com/merldsu/RISCV_Single_Cycle_Core)  
- **License:** MIT License

## 📄 License

This repository is licensed under the MIT License. See `LICENSE` for details.

## 📊 Simulation Results

The waveform below shows the output of the RISC-V single-cycle processor simulation:

![Waveform](Waveforms/Itype1.png)
![Waveform](Waveforms/Itype2.png)

