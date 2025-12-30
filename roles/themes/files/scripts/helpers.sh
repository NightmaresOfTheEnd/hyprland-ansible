#!/bin/bash
# Helper functions for theme scripts

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

log_step() {
    echo -e "${YELLOW}[STEP]${NC} $1"
}

log_detail() {
    echo -e "  → $1"
}

restart-app() {
    local app="$1"
    if pgrep -x "$app" > /dev/null; then
        pkill -x "$app"
        sleep 0.5
    fi
    "$app" &
    disown
}
