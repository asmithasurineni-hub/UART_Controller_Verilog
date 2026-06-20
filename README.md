# UART_Controller_Verilog
UART Controller with Full Verification using Verilog HDL and Xilinx Vivado
# UART Controller with Full Verification

## Project Overview

This project implements a Universal Asynchronous Receiver Transmitter (UART) Controller in Verilog HDL using Xilinx Vivado.

The design includes:

* UART Transmitter (TX)
* UART Receiver (RX)
* Baud Rate Generator
* Parity Error Detection
* Framing Error Detection
* Self-Checking Testbench
* Advanced Verification

---

## Specifications

| Parameter       | Value       |
| --------------- | ----------- |
| Clock Frequency | 50 MHz      |
| Baud Rate       | 9600        |
| Data Bits       | 8           |
| Parity          | Even Parity |
| Stop Bits       | 1           |

---

## UART Frame Format

```text
Idle | Start | D0 D1 D2 D3 D4 D5 D6 D7 | Parity | Stop

 1       0      Data Bits (LSB First)     P       1
```

---

## Modules

### uart_tx.v

UART Transmitter implemented using FSM states:

* IDLE
* START
* DATA
* PARITY
* STOP

### uart_rx.v

UART Receiver implemented using FSM states:

* IDLE
* START
* DATA
* PARITY
* STOP

Features:

* Data Reception
* Parity Checking
* Framing Error Detection

### baud_gen.v

Generates a 9600 baud tick from a 50 MHz clock.

### uart_top.v

Integrates:

* UART TX
* UART RX
* Baud Generator

### uart_tb.v

Verification testbench for UART functionality.

---

## Verification

### Normal UART Operation

Verified successful transmission and reception.

Example:

```text
data_in  = B2
data_out = B2
```

Result:

```text
TEST PASSED
```

---

### Parity Error Detection

Parity bit was intentionally corrupted during verification.

Result:

```text
parity_error = 1
```

---

### Framing Error Detection

Invalid stop bit condition was intentionally generated.

Result:

```text
framing_error = 1
```

---

### Advanced Verification

Test Patterns:

```text
00
FF
AA
55
B2
```

Results:

```text
PASS : 00
PASS : FF
PASS : AA
PASS : 55
PASS : B2
```

---

## Tools Used

* Verilog HDL
* Xilinx Vivado
* GitHub

---

## Applications

* Serial Communication
* Embedded Systems
* FPGA-Based Designs
* Microcontroller Interfaces
* Industrial Communication Systems

---

## Author

Asmitha Surineni

Electronics and Communication Engineering

Anurag University
