#!/bin/bash

# UrbanEase Database ERD Generator
# Bash script to generate visual ERD diagrams from Mermaid file
# Author: UrbanEase Team
# Date: November 2025

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${CYAN}========================================"
echo -e "  UrbanEase ERD Diagram Generator"
echo -e "========================================${NC}"
echo ""

# Check if we're in the correct directory
if [ ! -f "docs/erd_diagram.mmd" ]; then
    echo -e "${RED}ERROR: Please run this script from the project root directory!${NC}"
    echo -e "${YELLOW}Current directory: $(pwd)${NC}"
    exit 1
fi

# Check if Node.js is installed
echo -e "${YELLOW}Checking Node.js installation...${NC}"
if ! command -v node &> /dev/null; then
    echo -e "${RED}ERROR: Node.js is not installed!${NC}"
    echo -e "${YELLOW}Please install Node.js from: https://nodejs.org/${NC}"
    exit 1
fi
NODE_VERSION=$(node --version)
echo -e "${GREEN}✓ Node.js found: $NODE_VERSION${NC}"
echo ""

# Check if Mermaid CLI is installed
echo -e "${YELLOW}Checking Mermaid CLI...${NC}"
if ! command -v mmdc &> /dev/null; then
    echo -e "${YELLOW}Mermaid CLI not found. Installing...${NC}"
    echo ""
    npm install -g @mermaid-js/mermaid-cli
    
    if [ $? -ne 0 ]; then
        echo -e "${RED}ERROR: Failed to install Mermaid CLI!${NC}"
        exit 1
    fi
    echo -e "${GREEN}✓ Mermaid CLI installed successfully!${NC}"
else
    MMDC_VERSION=$(mmdc --version)
    echo -e "${GREEN}✓ Mermaid CLI found: $MMDC_VERSION${NC}"
fi
echo ""

# Generate diagrams
echo -e "${CYAN}Generating ERD diagrams...${NC}"
echo ""

# Generate PNG
echo -e "${YELLOW}1. Generating PNG diagram...${NC}"
mmdc -i docs/erd_diagram.mmd -o docs/erd_diagram.png -b transparent
if [ $? -eq 0 ]; then
    echo -e "${GREEN}   ✓ PNG generated: docs/erd_diagram.png${NC}"
else
    echo -e "${RED}   ✗ Failed to generate PNG${NC}"
fi

# Generate SVG
echo -e "${YELLOW}2. Generating SVG diagram...${NC}"
mmdc -i docs/erd_diagram.mmd -o docs/erd_diagram.svg -b transparent
if [ $? -eq 0 ]; then
    echo -e "${GREEN}   ✓ SVG generated: docs/erd_diagram.svg${NC}"
else
    echo -e "${RED}   ✗ Failed to generate SVG${NC}"
fi

# Generate PDF
echo -e "${YELLOW}3. Generating PDF diagram...${NC}"
mmdc -i docs/erd_diagram.mmd -o docs/erd_diagram.pdf
if [ $? -eq 0 ]; then
    echo -e "${GREEN}   ✓ PDF generated: docs/erd_diagram.pdf${NC}"
else
    echo -e "${RED}   ✗ Failed to generate PDF${NC}"
fi

echo ""
echo -e "${CYAN}========================================"
echo -e "  Generation Complete!"
echo -e "========================================${NC}"
echo ""
echo -e "${YELLOW}Generated files in docs/ directory:${NC}"
ls -lh docs/erd_diagram.* | awk '{printf "  - %s (%s)\n", $9, $5}'
echo ""
echo -e "${CYAN}You can now:${NC}"
echo -e "${NC}  • View PNG/SVG in any image viewer${NC}"
echo -e "${NC}  • Include in presentations or documentation${NC}"
echo -e "${NC}  • Print the PDF version${NC}"
echo ""

