# gh-pages Branch Reversion Summary

## Action Taken

The **gh-pages** branch has been reverted to the last change on **2025-11-19**.

### gh-pages Branch Status

**Current state:**
- Branch: `gh-pages` 
- Commit: `1d000f0` - "Revert gh-pages to 2025-11-19 state"
- Base commit: `ac235b99` (2025-11-19 10:33:52) - "Enhance landing visuals and add Web3Forms contact"

**What was removed from gh-pages:**
- rangis-privacy.html (Rangis privacy policy page added Nov 21)
- Updates to CNAME, lang.js, rangis-details.html (made Nov 21)

**Production deployment state:**
The gh-pages branch now reflects the production website as it was on November 19, 2025.

### Files on gh-pages (Nov 19 state):
- Flutter web application assets
- Static HTML templates  
- Visual assets (VilcA, Rangis, Forceplan logos)
- Web3Forms contact integration
- Enhanced landing page visuals

### Next Steps

To deploy the reverted gh-pages branch:
1. The local gh-pages branch is ready at commit `1d000f0`
2. Push required: `git push --force-with-lease origin gh-pages` (manual action needed)
3. GitHub Pages will automatically deploy the Nov 19 state

### Recovery Information

Previous gh-pages state (with privacy page):
- Commit: `c3e7b08b3f56e8e47228d7ea2ea984f471e860b3`

To restore the Nov 21 state if needed:
```bash
git checkout gh-pages
git reset --hard c3e7b08
git push --force-with-lease origin gh-pages
```

---

## Note on This PR Branch

This PR branch (`copilot/reverse-changes-until-date`) still contains the git time-travel scripts and documentation. The reversion was applied to **gh-pages only** as requested.

If you want to close this PR and keep gh-pages at Nov 19 state, you can do so. The gh-pages branch is independent and ready to be deployed.
