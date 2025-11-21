#!/bin/bash
# Script to view git commit history with timestamps
# This helps identify which commit corresponds to a specific date/time

echo "============================================"
echo "Git Commit History with Timestamps"
echo "============================================"
echo ""

if [ "$1" == "--help" ] || [ "$1" == "-h" ]; then
    echo "Usage: ./scripts/view-history.sh [options]"
    echo ""
    echo "Options:"
    echo "  -n <number>    Show last N commits (default: 20)"
    echo "  --all          Show all commits"
    echo "  --since <date> Show commits since date (e.g., '2025-11-20' or '2 days ago')"
    echo "  --until <date> Show commits until date"
    echo "  --help, -h     Show this help message"
    echo ""
    echo "Examples:"
    echo "  ./scripts/view-history.sh -n 10"
    echo "  ./scripts/view-history.sh --since '2025-11-20'"
    echo "  ./scripts/view-history.sh --since '1 week ago'"
    exit 0
fi

# Default number of commits to show
NUM_COMMITS=20
SINCE=""
UNTIL=""
SHOW_ALL=false

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -n)
            NUM_COMMITS="$2"
            shift 2
            ;;
        --all)
            SHOW_ALL=true
            shift
            ;;
        --since)
            SINCE="$2"
            shift 2
            ;;
        --until)
            UNTIL="$2"
            shift 2
            ;;
        *)
            shift
            ;;
    esac
done

# Build the git log command
CMD="git log --pretty=format:'%C(yellow)%h%C(reset) | %C(green)%ai%C(reset) | %C(blue)%an%C(reset) | %s'"

if [ "$SHOW_ALL" = false ]; then
    CMD="$CMD -n $NUM_COMMITS"
fi

if [ -n "$SINCE" ]; then
    CMD="$CMD --since='$SINCE'"
fi

if [ -n "$UNTIL" ]; then
    CMD="$CMD --until='$UNTIL'"
fi

# Execute the command
echo "Showing commits..."
echo ""
printf "%-10s | %-28s | %-20s | %s\n" "HASH" "DATE & TIME" "AUTHOR" "MESSAGE"
echo "--------------------------------------------------------------------------------------------------------"
eval $CMD

echo ""
echo "--------------------------------------------------------------------------------------------------------"
echo "Note: Copy the commit hash (first column) to use with revert-to-date.sh"
