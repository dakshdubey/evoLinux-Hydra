#!/bin/bash
# Author: Daksha Dubey

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Logging functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1" >&2
}

log_step() {
    echo -e "${PURPLE}➜${NC} $1"
}

# Error handling
die() {
    log_error "$1"
    exit 1
}

# Dependency check
check_dep() {
    if ! command -v "$1" &> /dev/null; then
        die "Required dependency '$1' is not installed. Please install it and try again."
    fi
}

# Ask for confirmation
confirm() {
    read -r -p "${YELLOW}[?]${NC} $1 [y/N] " response
    case "$response" in
        [yY][eE][sS]|[yY]) 
            true
            ;;
        *)
            false
            ;;
    esac
}
