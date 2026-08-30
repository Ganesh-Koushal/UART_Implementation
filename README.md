# UART Transmitter using Verilog HDL

## Project Overview

This project implements a **UART (Universal Asynchronous Receiver Transmitter) Transmitter** in Verilog HDL, developed and validated during the **VLSI-CAD 2026 Internship**, Department of Electronics and Communication Engineering, **NIT Rourkela**.

The project covers the complete digital design flow — RTL design and simulation, FPGA implementation on the **Boolean Board**, and real-world serial communication validation using **Tera Term** (laptop) and a **Bluetooth Serial Terminal** app (mobile). Unlike simulation-only projects, this work involved actual hardware deployment and protocol-level validation.

---

## Objectives

- Design a UART transmitter in Verilog HDL
- Implement button-controlled serial data transmission
- Verify functionality using a dedicated testbench
- Deploy the design on FPGA hardware
- Validate UART communication via external terminal applications
- Gain hands-on experience with FPGA prototyping and hardware debugging

---

## UART Protocol Basics

UART is one of the most widely used serial communication protocols in embedded systems, microcontrollers, and FPGA-based systems. It is **asynchronous** — no shared clock line is needed between transmitter and receiver.

A UART frame consists of:

| Field | Value |
|---|---|
| Start Bit | Logic 0 |
| Data Bits | 8 bits, LSB first |
| Stop Bit | Logic 1 |

```
Start Bit → D0 → D1 → D2 → D3 → D4 → D5 → D6 → D7 → Stop Bit
```

---

## Repository Structure

```
UART/
├── Source_code/
│   ├── top.v
│   ├── transmit_debouncingg.v
│   └── transmitter.v
├── Testbench/
│   └── top_tb.v
└── README.md
```

---

## Module Description

### `top.v` — Top-Level Integration
- Connects FPGA switches to UART data input
- Interfaces push-button controls with the transmitter
- Instantiates the debouncing and transmitter modules
- Provides debug outputs for signal monitoring

**Inputs:** `clk`, `btn0` (Reset), `btn1` (Transmit Trigger), `sw[7:0]` (Data Input)
**Outputs:** `TxD`, Debug Signals

### `transmit_debouncingg.v` — Button Debouncing
Mechanical push-buttons produce unwanted signal transitions ("bouncing"). This module cleans that up:
- Synchronizes the button signal using a two flip-flop synchronizer
- Filters glitches with a counter-based debounce mechanism
- Prevents accidental multiple transmissions

**Key concepts:** clock domain synchronization, two flip-flop synchronizer, counter-based debouncing, edge stabilization

### `transmitter.v` — UART Serial Transmission
- Generates UART bit timing via a baud rate generator
- Loads parallel input data and adds start/stop bits
- Serializes data through a shift register
- Controlled by an FSM (**Idle** → **Transmit** → back to **Idle**)

**Internal components:** Baud Rate Generator, Shift Register, Bit Counter, FSM Controller

---

## Verification Strategy

Verified using a dedicated testbench (`top_tb.v`) that generates a 100 MHz clock, applies reset sequences, simulates button presses, and monitors UART output.

| Test Case | Input Data | Expected Output | Purpose |
|---|---|---|---|
| 1 | `0xAA` | `10101010` | Alternating bit transmission |
| 2 | `0x55` | `01010101` | Complementary alternating pattern |
| 3 | `0x00` | `00000000` | All-zero transmission |
| 4 | `0xFF` | `11111111` | All-one transmission |

---

## FPGA Implementation

After successful simulation, the design was synthesized, implemented, and programmed onto the **Boolean FPGA Board**.

- RTL synthesis → implementation → bitstream generation → FPGA programming → hardware debugging
- **Hardware inputs:** switches (8-bit data entry), push-button (transmit trigger), reset button

---

## Hardware Validation

The UART transmitter was validated through two independent real-world interfaces:

**Tera Term (Laptop)**
- Correct reception of transmitted characters
- Stable serial communication
- Proper UART frame generation

**Bluetooth Serial Terminal (Mobile)**
- Successful wireless serial communication
- Correct data reception on the mobile app
- Behavior consistent with the hardware implementation

This confirmed the transmitter's correctness beyond simulation, across both wired and wireless interfaces.

---

## Key Concepts Demonstrated

Verilog RTL Design · FSM Design · UART Communication Protocol · Shift Register Design · Baud Rate Generation · Counter Design · Button Debouncing · Clock Synchronization · Testbench Development · Functional Verification · FPGA Implementation Flow · Hardware Debugging · Serial Communication Validation

---

## Practical Learning Outcomes

- Designed a communication protocol in Verilog end-to-end
- Converted parallel data into serial data streams
- Implemented an FSM-controlled digital system
- Developed and executed functional verification testbenches
- Understood hardware–software interaction through serial terminals
- Deployed an RTL design onto FPGA hardware and debugged it in the field
- Validated functionality using both PC and mobile interfaces

---

## Career Relevance

This project demonstrates practical skills relevant to:

- RTL Design Engineer
- FPGA Design Engineer
- Digital Design Engineer
- Entry-Level Design Verification Engineer

It showcases the complete engineering flow — from RTL development and simulation to FPGA implementation and hardware validation — and complements FSM-based digital design work and processor-level projects such as [RISC-V_32bit](https://github.com/Ganesh-Koushal/RISC-V_32bit).

---

## Tools Used

- Verilog HDL
- Vivado Design Suite
- Boolean FPGA Board
- Tera Term
- Bluetooth Serial Terminal Application
- Waveform Analysis Tools
