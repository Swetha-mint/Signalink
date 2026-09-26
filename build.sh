#!/bin/bash

# =====================================================================
# Project: SIGNALINK (Sense. Process. Communicate. Assist.)
# Script: build.sh
# Description: One-command helper to execute the software sensor
#              pipeline and compile/verify the Verilog RTL stack.
# =====================================================================

set -u

GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${BLUE}=======================================================${NC}"
echo -e "${BLUE}🛰  SIGNALINK INTEGRATED AUTOMATION ENGINE STARTED${NC}"
echo -e "${BLUE}=======================================================${NC}"

echo -e "\n${CYAN}[1/3] Running Sensory Processing Quantization Simulation...${NC}"
if [ -f "Sensory Processing/hardware_bridge_sim.py" ]; then
    python3 "Sensory Processing/hardware_bridge_sim.py" || exit 1
else
    echo "❌ hardware_bridge_sim.py not found in Sensory Processing directory."
    exit 1
fi

echo -e "\n${CYAN}[2/3] Compiling RTL Processing & Communication Core Layers...${NC}"
mkdir -p build_output

iverilog -o build_output/signalink_sim \
    "RTL / Digital Processing/toffoli_gate.v" \
    "RTL / Digital Processing/alu_core.v" \
    "RTL / Digital Processing/register_file.v" \
    "RTL / Digital Processing/clock_divider.v" \
    "RTL / Digital Processing/uart_tx.v" \
    "RTL / Digital Processing/uart_rx.v" \
    "RTL / Digital Processing/i2c_master.v" \
    "System Integration/signalink_core.v" \
    "System Integration/tb_signalink_loopback.v"

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ RTL Compilation Successful. Binary generated in build_output/.${NC}"
else
    echo "❌ RTL Compilation Failed. Please check the Verilog source and paths."
    exit 1
fi

echo -e "\n${CYAN}[3/3] Executing Closed-Loop Verification Test...${NC}"
vvp build_output/signalink_sim

if [ $? -eq 0 ]; then
    echo -e "\n${GREEN}=======================================================${NC}"
    echo -e "${GREEN}🎉 ALL SIGNALINK SIMULATIONS COMPLETE! READY TO LOG${NC}"
    echo -e "${GREEN}=======================================================${NC}"
else
    echo "❌ Loopback verification failed. Review the simulation output."
    exit 1
fi
