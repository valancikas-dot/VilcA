# Repository Reverted to 2025-11-19 23:00

## What happened?

This repository was reverted to the state it was in on **2025-11-19 at 23:00**.

## Target commit:
- **Hash**: ac235b99a73e8d133e5d60d04f0402c2327713bf
- **Date**: 2025-11-19 10:33:52 +0000
- **Message**: "Enhance landing visuals and add Web3Forms contact"

## What was removed?

The following changes made after 2025-11-19 were removed:
1. **Add Rangis privacy page and link** (bbca881) - Nov 21, 2025
2. **Git time-travel feature** - Scripts and documentation added on Nov 21, 2025
   - scripts/view-history.sh
   - scripts/revert-to-date.sh
   - scripts/GUIDE.md
   - scripts/TESTING.md
   - scripts/demo.sh
   - Updated README.md with time-travel documentation

## Backup

A backup branch was created before reverting:
- Branch name starts with: `backup-before-revert-to-nov19-`
- You can see it with: `git branch -a | grep backup`

## To restore the newer version

If you want to go back to the state before this revert:

```bash
# See the backup branches
git branch -a | grep backup

# Switch to the backup
git checkout <backup-branch-name>

# Or use git reflog to find the previous state
git reflog
git reset --hard <commit-before-revert>
```

## Current state

The repository now contains:
- Flutter web application (lib/main.dart)
- Static HTML templates
- Visual assets (logos, icons)
- Basic README
- No scripts/ directory
- No rangis-privacy.html page

This is exactly how the repository looked on 2025-11-19.
