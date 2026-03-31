#!/bin/bash
# Script to safely revert repository to a specific date/time
# This script provides options to revert changes safely

set -e

echo "============================================"
echo "Revert Repository to Specific Date/Time"
echo "============================================"
echo ""

if [ "$1" == "--help" ] || [ "$1" == "-h" ] || [ -z "$1" ]; then
    echo "Usage: ./scripts/revert-to-date.sh <commit-hash|date> [method]"
    echo ""
    echo "Methods:"
    echo "  --soft         Move HEAD but keep changes staged (safest)"
    echo "  --mixed        Move HEAD, unstage changes but keep in working directory (default)"
    echo "  --hard         Move HEAD and discard all changes (DESTRUCTIVE)"
    echo "  --revert       Create new commits that undo changes (preserves history)"
    echo ""
    echo "Arguments:"
    echo "  <commit-hash>  The commit hash to revert to (use view-history.sh to find it)"
    echo "  <date>         Or use a date like '2025-11-20 14:30:00' or '2 days ago'"
    echo ""
    echo "Examples:"
    echo "  ./scripts/revert-to-date.sh abc1234 --soft"
    echo "  ./scripts/revert-to-date.sh '2025-11-20' --mixed"
    echo "  ./scripts/revert-to-date.sh 'HEAD~5' --revert"
    echo ""
    echo "IMPORTANT: Always create a backup before reverting!"
    echo "  git branch backup-$(date +%Y%m%d-%H%M%S)"
    exit 0
fi

TARGET="$1"
METHOD="${2:--mixed}"

# Check if target is a date or commit hash
if git rev-parse "$TARGET" >/dev/null 2>&1; then
    COMMIT_HASH=$(git rev-parse "$TARGET")
    COMMIT_DATE=$(git log -1 --format=%ai "$COMMIT_HASH")
    echo "Target commit: $COMMIT_HASH"
    echo "Commit date: $COMMIT_DATE"
elif git log --before="$TARGET" -1 >/dev/null 2>&1; then
    COMMIT_HASH=$(git log --before="$TARGET" -1 --format=%H)
    COMMIT_DATE=$(git log -1 --format=%ai "$COMMIT_HASH")
    echo "Found commit: $COMMIT_HASH"
    echo "Commit date: $COMMIT_DATE"
else
    echo "ERROR: Could not find commit for target: $TARGET"
    echo "Use ./scripts/view-history.sh to see available commits"
    exit 1
fi

echo ""
echo "Current branch: $(git branch --show-current)"
echo "Current HEAD: $(git rev-parse --short HEAD)"
echo ""

# Check for uncommitted changes
if ! git diff-index --quiet HEAD --; then
    echo "WARNING: You have uncommitted changes!"
    echo ""
    git status --short
    echo ""
    read -p "Do you want to create a backup branch first? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        BACKUP_BRANCH="backup-$(date +%Y%m%d-%H%M%S)"
        git branch "$BACKUP_BRANCH"
        echo "Created backup branch: $BACKUP_BRANCH"
    fi
fi

echo ""
echo "You are about to revert to:"
echo "  Commit: $COMMIT_HASH"
echo "  Date: $COMMIT_DATE"
echo "  Method: $METHOD"
echo ""

case $METHOD in
    --soft)
        echo "Method: Soft reset (keeps all changes staged)"
        read -p "Continue? (y/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            git reset --soft "$COMMIT_HASH"
            echo "✓ Reset complete. Changes are staged. Use 'git status' to review."
        fi
        ;;
    --mixed)
        echo "Method: Mixed reset (keeps changes in working directory, unstaged)"
        read -p "Continue? (y/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            git reset --mixed "$COMMIT_HASH"
            echo "✓ Reset complete. Changes are in working directory. Use 'git status' to review."
        fi
        ;;
    --hard)
        echo "⚠️  WARNING: Hard reset will PERMANENTLY DELETE all changes!"
        echo "This cannot be undone easily."
        read -p "Are you ABSOLUTELY sure? Type 'yes' to continue: " CONFIRM
        if [ "$CONFIRM" == "yes" ]; then
            git reset --hard "$COMMIT_HASH"
            echo "✓ Hard reset complete. All changes discarded."
        else
            echo "Cancelled."
        fi
        ;;
    --revert)
        echo "Method: Revert (creates new commits that undo changes)"
        echo "This preserves history and is safe for shared branches."
        read -p "Continue? (y/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            # Get list of commits to revert (from newest to oldest)
            COMMITS_TO_REVERT=$(git rev-list "$COMMIT_HASH"..HEAD)
            if [ -z "$COMMITS_TO_REVERT" ]; then
                echo "No commits to revert. Already at target or ahead."
            else
                while IFS= read -r commit; do
                    echo "Reverting: $(git log -1 --oneline "$commit")"
                    git revert --no-edit "$commit" || {
                        echo "Conflict during revert. Resolve conflicts and run: git revert --continue"
                        exit 1
                    }
                done <<< "$COMMITS_TO_REVERT"
                echo "✓ Revert complete. New commits created."
            fi
        fi
        ;;
    *)
        echo "ERROR: Unknown method: $METHOD"
        echo "Use --help to see available methods"
        exit 1
        ;;
esac

echo ""
echo "Done! Current status:"
git log -1 --oneline
echo ""
echo "To undo this operation (if needed):"
echo "  git reflog       # Find the previous HEAD"
echo "  git reset --hard <previous-hash>"
