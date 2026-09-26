#!/bin/bash

# =====================================================================
# Project: SIGNALINK (Sense. Process. Communicate. Assist.)
# Script: build.sh
# Description: Multi-mode automated engine to compile RTL frameworks,
#              run testbenches, or launch the interactive Block 04 UI.
# =====================================================================

# Color configurations for professional terminal output prints
GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}=======================================================${NC}"
echo -e "${BLUE}🛰  SIGNALINK INTEGRATED MASTER RUNNER ENGINE          ${NC}"
echo -e "${BLUE}=======================================================${NC}"
echo -e "Select workspace action framework mode:"
echo -e "  ${GREEN}[1]${NC} Run RTL Hardware Compilation & Simulation Loop"
echo -e "  ${GREEN}[2]${NC} Launch Block 04 Assistive MVP Dashboard (Local UI)"
echo -e "  ${GREEN}[3]${NC} Run Software Spatial Tokenization Pipelines Only"
echo -e "${BLUE}-------------------------------------------------------${NC}"
read -p "Enter selection number (1-3): " workspace_mode

case $workspace_mode in
    1)
        echo -e "\n${CYAN}⚙️  Compiling RTL Core Processing & Communication Layers...${NC}"
        mkdir -p build_output

        iverilog -o build_output/signalink_sim \
            "RTL / Digital Processing/toffoli_gate.v" \
            "RTL / Digital Processing/alu_core.v" \
            "RTL / Digital Processing/register_file.v" \
            "RTL / Digital Processing/clock_divider.v" \
            "RTL / Digital Processing/uart_tx.v" \
            "RTL / Digital Processing/uart_rx.v" \
            "System Integration/signalink_core.v" \
            "System Integration/tb_signalink_loopback.v"

        if [ $? -eq 0 ]; then
            echo -e "${GREEN}✅ RTL Compilation Successful. Executing loopback simulation...${NC}\n"
            vvp build_output/signalink_sim
        else
            echo -e "${YELLOW}❌ RTL Compilation Failed. Inspect logic tree syntax log.${NC}"
            exit 1
        fi
        ;;

    2)
        echo -e "\n${CYAN}📡 Spawning Block 04 Assistive UI Bridge Infrastructure...${NC}"
        if [ -f "Sensory Processing/app_ui_bridge.py" ]; then
            python3 "Sensory Processing/app_ui_bridge.py"
        else
            echo -e "${YELLOW}⚠️  app_ui_bridge.py not found in Sensory Processing directory.${NC}"
            exit 1
        fi
        ;;

    3)
        echo -e "\n${CYAN}🛰  Running Continuous Spatial Tokenization Engine Data Check...${NC}"
        if [ -f "Sensory Processing/gesture_token_pipeline.py" ]; then
            python3 "Sensory Processing/gesture_token_pipeline.py"
        else
            echo -e "${YELLOW}⚠️  gesture_token_pipeline.py not found in Sensory Processing directory.${NC}"
            exit 1
        fi
        ;;

    *)
        echo -e "${YELLOW}❌ Invalid selection entry. Exiting workspace context runner.${NC}"
        exit 1
        ;;
esac

echo -e "\n${GREEN}=======================================================${NC}"
echo -e "${GREEN}🎉 SIGNALINK RUN COMPLETE                              ${NC}"
echo -e "${GREEN}=======================================================${NC}"
