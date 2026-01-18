#!/bin/bash
# Author: Daksha Dubey

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m'

echo -e "${PURPLE}=== evo-ui Installer ===${NC}"

INSTALL_DIR="$HOME/.local/bin"
mkdir -p "$INSTALL_DIR"

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Link the binary
ln -sf "$BASE_DIR/bin/evo-ui" "$INSTALL_DIR/evo-ui"

echo -e "${BLUE}[INFO]${NC} Linked evo-ui to $INSTALL_DIR/evo-ui"

# Check if INSTALL_DIR is in PATH
if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
    echo -e "${YELLOW}[WARN]${NC} $INSTALL_DIR is not in your PATH."
    echo -e "Add this to your .bashrc or .zshrc:"
    echo -e "  export PATH=\"$HOME/.local/bin:\$PATH\""
fi

echo -e "${GREEN}[SUCCESS]${NC} evo-ui installed successfully!"
echo -e "Try running: ${BLUE}evo-ui status${NC}"
