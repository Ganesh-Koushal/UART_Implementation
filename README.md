UART Transmitter using Verilog HDL
Project Overview

This project implements a UART (Universal Asynchronous Receiver Transmitter) Transmitter using Verilog HDL. The design was developed and validated as part of the VLSI-CAD 2026 Internship conducted by the Department of Electronics and Communication Engineering, NIT Rourkela.

The project demonstrates the complete digital design flow, beginning from RTL design and simulation, progressing through FPGA implementation on the Boolean Board, and finally validating serial communication using both Tera Term on a laptop and a Bluetooth Serial Terminal application on a mobile device.

Unlike simulation-only projects, this work provided practical exposure to real hardware implementation, FPGA deployment, and communication protocol validation.

Objectives
Design a UART transmitter using Verilog HDL.
Implement button-controlled serial data transmission.
Perform functional verification using a dedicated testbench.
Deploy the design on FPGA hardware.
Validate UART communication through external terminal applications.
Gain hands-on experience with FPGA prototyping and hardware debugging.
UART Protocol Basics

UART is one of the most commonly used serial communication protocols in embedded systems, microcontrollers, FPGA-based systems, and industrial electronics.

A UART frame consists of:

1 Start Bit (Logic 0)
8 Data Bits (LSB First)
1 Stop Bit (Logic 1)

Transmission occurs asynchronously, meaning no separate clock line is required between the transmitter and receiver.

Example UART Frame:

Start Bit → Data[0] → Data[1] → Data[2] → Data[3] → Data[4] → Data[5] → Data[6] → Data[7] → Stop Bit

Project Architecture

The design consists of three RTL modules integrated through a top-level module.

UART/
│
├── Source_code/
│ ├── top.v
│ ├── transmit_debouncingg.v
│ └── transmitter.v
│
├── Testbench/
│ └── top_tb.v
│
└── README.md

Module Description
1. top.v

This is the top-level integration module.

Responsibilities:

Connects FPGA switches to UART data input.
Interfaces push-button controls with the transmitter.
Instantiates the debouncing module.
Instantiates the UART transmitter module.
Provides debug outputs for monitoring signals.

Inputs:

clk
btn0 (Reset)
btn1 (Transmit Trigger)
sw[7:0] (Data Input)

Outputs:

TxD
Debug Signals
2. transmit_debouncingg.v

Mechanical push-buttons generate unwanted signal transitions known as switch bouncing.

This module:

Synchronizes the push-button signal using two flip-flops.
Filters glitches using a counter-based debounce mechanism.
Generates a clean transmit signal.
Prevents accidental multiple UART transmissions.

Key Concepts Used:

Clock Domain Synchronization
Two Flip-Flop Synchronizer
Counter-Based Debouncing
Edge Stabilization
3. transmitter.v

This module performs UART serial transmission.

Responsibilities:

Generates UART bit timing.
Loads parallel input data.
Adds start and stop bits.
Serializes data using a shift register.
Controls transmission through a finite state machine.

Internal Components:

Baud Rate Generator
Shift Register
Bit Counter
FSM Controller

FSM States:

Idle State:

Waits for transmit signal.

Transmit State:

Shifts data bits serially through TxD.
Tracks transmitted bits.
Returns to Idle after frame completion.
Verification Strategy

The design was verified using a dedicated Verilog testbench.

Testbench File:

top_tb.v

Verification Scenarios:

Test Case 1

Data: 0xAA

Expected Pattern:
10101010

Purpose:
Verify alternating bit transmission.

Test Case 2

Data: 0x55

Expected Pattern:
01010101

Purpose:
Verify complementary alternating pattern.

Test Case 3

Data: 0x00

Expected Pattern:
00000000

Purpose:
Verify all-zero transmission.

Test Case 4

Data: 0xFF

Expected Pattern:
11111111

Purpose:
Verify all-one transmission.

The testbench:

Generates a 100 MHz clock.
Applies reset sequences.
Simulates button presses.
Verifies debounce operation.
Monitors UART output behavior.
Generates waveform files for debugging and analysis.
FPGA Implementation

After successful simulation, the UART transmitter was implemented on the FPGA development board during the internship.

Implementation Activities:

RTL synthesis
Design implementation
Bitstream generation
FPGA programming
Hardware debugging

Hardware Inputs:

Switches used for entering 8-bit data.
Push-button used to trigger transmission.
Reset button for system reset.
Hardware Validation

The UART transmitter was validated through real serial communication interfaces.

Validation using Tera Term

The FPGA UART output was connected to a laptop.

Observed:

Correct reception of transmitted characters.
Stable serial communication.
Proper UART frame generation.
Validation using Bluetooth Serial Terminal Application

The UART output was also tested using a Bluetooth serial interface connected to a mobile phone.

Observed:

Successful wireless serial communication.
Correct data reception on the mobile application.
Consistent behavior with hardware implementation.

This provided practical confirmation that the UART transmitter functioned correctly beyond simulation environments.

Key Concepts Demonstrated
Verilog RTL Design
Finite State Machine (FSM) Design
UART Communication Protocol
Shift Register Design
Baud Rate Generation
Counter Design
Button Debouncing
Clock Synchronization
Testbench Development
Functional Verification
FPGA Implementation Flow
Hardware Debugging
Serial Communication Validation
Practical Learning Outcomes

This project provided hands-on exposure to the complete FPGA and digital design workflow.

Key takeaways include:

Designing communication protocols in Verilog.
Converting parallel data into serial data streams.
Implementing FSM-controlled digital systems.
Developing and executing functional verification testbenches.
Understanding hardware-software interaction through serial terminals.
Deploying RTL designs onto FPGA hardware.
Debugging real-world digital systems.
Validating functionality using both PC and mobile interfaces.
Career Relevance

This project demonstrates practical skills relevant to:

RTL Design Engineer
FPGA Design Engineer
Digital Design Engineer
Entry-Level Design Verification Engineer

The project showcases the complete engineering flow from RTL development and simulation to FPGA implementation and hardware validation.
Combined with FSM-based digital design projects and future processor-level projects such as RISC-V, this work strengthens core competencies required in VLSI design and verification domains.

Tools Used
Verilog HDL
Vivado Design Suite
Boolean FPGA Board
Tera Term
Bluetooth Serial Terminal Application
Waveform Analysis Tools
