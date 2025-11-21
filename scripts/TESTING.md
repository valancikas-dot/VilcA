# Testing the Git Time Travel Scripts

## Test Cases

### Test 1: View History Script

```bash
# Basic usage - should show last 20 commits
./scripts/view-history.sh

# Show limited commits
./scripts/view-history.sh -n 5

# Show commits since date
./scripts/view-history.sh --since '2025-11-20'

# Show help
./scripts/view-history.sh --help
```

**Expected Results:**
- ✅ Shows formatted table with commit hash, date/time, author, and message
- ✅ Color-coded output (yellow hash, green date, blue author)
- ✅ Respects -n parameter for limiting commits
- ✅ Filters by date when --since is used
- ✅ Shows help message with --help

### Test 2: Revert Script - Help and Validation

```bash
# Show help
./scripts/revert-to-date.sh --help

# Test with no arguments (should show help)
./scripts/revert-to-date.sh

# Test with invalid commit hash
./scripts/revert-to-date.sh invalid123
```

**Expected Results:**
- ✅ Shows help message when called with --help or no arguments
- ✅ Shows error message for invalid commit hashes
- ✅ Suggests using view-history.sh to find valid commits

### Test 3: Revert Script - Dry Run (Interactive)

These tests require user interaction:

```bash
# Test soft reset (safest)
# 1. Create backup branch
git branch test-backup

# 2. Try soft reset
./scripts/revert-to-date.sh bbca881 --soft
# When prompted, type 'n' to cancel (or 'y' to proceed if you want to test)

# 3. Clean up if you proceeded
git reset --soft HEAD@{1}
git branch -D test-backup
```

### Test 4: Date Parsing

Test that the script can handle different date formats:

```bash
# By commit hash
git rev-parse bbca881  # Should return full hash

# By date
git log --before='2025-11-21 12:00:00' -1 --format="%H"  # Should find commit before that time

# By relative date
git log --before='1 day ago' -1 --format="%H"  # Should find commit from yesterday
```

## Manual Testing Checklist

- [x] `view-history.sh` displays commits correctly
- [x] `view-history.sh` respects -n parameter
- [x] `view-history.sh` filters by --since date
- [x] `view-history.sh` shows help with --help
- [x] `revert-to-date.sh` shows help with --help
- [x] `revert-to-date.sh` shows help with no arguments
- [x] `revert-to-date.sh` validates commit hashes
- [x] `revert-to-date.sh` parses dates correctly
- [x] Scripts are executable (chmod +x)
- [x] Scripts have proper shebang (#!/bin/bash)
- [x] README.md has been updated with documentation
- [x] GUIDE.md provides comprehensive instructions

## Integration Testing

To fully test the revert functionality (do this on a test branch):

```bash
# 1. Create a test branch
git checkout -b test-revert-feature

# 2. Make some test commits
echo "test1" > test1.txt && git add . && git commit -m "Test commit 1"
echo "test2" > test2.txt && git add . && git commit -m "Test commit 2"
echo "test3" > test3.txt && git add . && git commit -m "Test commit 3"

# 3. View history
./scripts/view-history.sh -n 5

# 4. Revert to before test commits (using soft)
HASH=$(git log --skip=3 -1 --format=%H)
./scripts/revert-to-date.sh $HASH --soft

# 5. Verify (should see test files as staged changes)
git status

# 6. Clean up
git checkout copilot/reverse-changes-until-date
git branch -D test-revert-feature
```

## Test Results

All automated tests passed:
- ✅ Scripts execute without errors
- ✅ Help messages display correctly
- ✅ Git commands parse dates and hashes correctly
- ✅ Error handling works for invalid inputs
- ✅ Scripts have proper permissions and formatting

## Known Limitations

1. Interactive prompts require user input (by design for safety)
2. Hard reset with confirmation requires typing 'yes' exactly
3. Revert method may encounter conflicts if history is complex
4. Color output may not work on all terminals (falls back to plain text)

## Safety Features Verified

- ✅ Backup branch creation prompt before destructive operations
- ✅ Uncommitted changes warning
- ✅ Confirmation prompts for each method
- ✅ Extra confirmation for hard reset (requires typing 'yes')
- ✅ Clear explanation of each method before execution
- ✅ Instructions for undoing operations via reflog

## Documentation Quality

- ✅ README.md includes bilingual (Lithuanian/English) instructions
- ✅ GUIDE.md provides comprehensive usage examples
- ✅ Both scripts have built-in help with examples
- ✅ Error messages are clear and actionable
- ✅ Safety warnings are prominent
