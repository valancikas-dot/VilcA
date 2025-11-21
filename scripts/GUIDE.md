# Git Time Travel Guide / Laiko Atstatymo Gidas

## Lietuviškai

### Kas tai yra?

Šie įrankiai leidžia atstatyti projektą į ankstesnį laiką. Tai naudinga, kai:
- Norite atšaukti naujausius pakeitimus
- Reikia grįžti prie veikiančios versijos
- Eksperimentavote ir norite grįžti atgal

### Kaip naudoti?

#### 1. Peržiūrėkite istoriją

```bash
./scripts/view-history.sh
```

Tai parodys commit'ų sąrašą su datomis ir laiku. Pavyzdžiui:

```
ea56628 | 2025-11-21 14:47:46 | Initial plan
bbca881 | 2025-11-21 11:42:13 | Add Rangis privacy page
```

#### 2. Sukurkite atsarginę kopiją (BŪTINA!)

```bash
git branch backup-$(date +%Y%m%d-%H%M%S)
```

#### 3. Atstatykite į norimą laiką

Pasirinkite vieną iš metodų:

**a) Soft reset (rekomenduojama pradedantiesiems)**
- Palieka visus pakeitimus, galite juos peržiūrėti
- Saugiausias variantas

```bash
./scripts/revert-to-date.sh <commit-hash> --soft
```

**b) Mixed reset (numatytasis)**
- Palieka pakeitimus, bet juos reikia vėl pridėti (stage)

```bash
./scripts/revert-to-date.sh <commit-hash> --mixed
```

**c) Revert (saugiausias viešoms šakoms)**
- Sukuria naujus commit'us, kurie atšaukia pakeitimus
- Nepraranda istorijos

```bash
./scripts/revert-to-date.sh <commit-hash> --revert
```

**d) Hard reset (PAVOJINGA!)**
- Ištrins visus pakeitimus negrąžinamai
- Naudokite tik jei tikrai žinote ką darote

```bash
./scripts/revert-to-date.sh <commit-hash> --hard
```

### Pavyzdys

```bash
# 1. Žiūrime istoriją
./scripts/view-history.sh

# 2. Matome, kad norime grįžti prie bbca881
# 3. Sukuriame atsarginę kopiją
git branch backup-20251121

# 4. Atstatome (soft metodas)
./scripts/revert-to-date.sh bbca881 --soft

# 5. Peržiūrime kas pasikeitė
git status
```

### Jei susipainiojote

Jei padarėte klaidą, galite grįžti atgal:

```bash
# Pamatykite visą istoriją
git reflog

# Grįžkite į ankstesnę būseną
git reset --hard <ankstesnis-hash>
```

Arba naudokite atsarginę kopiją:

```bash
git checkout backup-20251121
```

---

## English

### What is this?

These tools allow you to restore the project to a previous point in time. Useful when you:
- Want to undo recent changes
- Need to return to a working version
- Were experimenting and want to go back

### How to use?

#### 1. View the history

```bash
./scripts/view-history.sh
```

This will show a list of commits with dates and times. For example:

```
ea56628 | 2025-11-21 14:47:46 | Initial plan
bbca881 | 2025-11-21 11:42:13 | Add Rangis privacy page
```

#### 2. Create a backup (REQUIRED!)

```bash
git branch backup-$(date +%Y%m%d-%H%M%S)
```

#### 3. Revert to desired time

Choose one of the methods:

**a) Soft reset (recommended for beginners)**
- Keeps all changes, you can review them
- Safest option

```bash
./scripts/revert-to-date.sh <commit-hash> --soft
```

**b) Mixed reset (default)**
- Keeps changes but you need to stage them again

```bash
./scripts/revert-to-date.sh <commit-hash> --mixed
```

**c) Revert (safest for public branches)**
- Creates new commits that undo changes
- Doesn't lose history

```bash
./scripts/revert-to-date.sh <commit-hash> --revert
```

**d) Hard reset (DANGEROUS!)**
- Permanently deletes all changes
- Use only if you know what you're doing

```bash
./scripts/revert-to-date.sh <commit-hash> --hard
```

### Example

```bash
# 1. View history
./scripts/view-history.sh

# 2. We see we want to go back to bbca881
# 3. Create backup
git branch backup-20251121

# 4. Revert (soft method)
./scripts/revert-to-date.sh bbca881 --soft

# 5. Review what changed
git status
```

### If you get confused

If you made a mistake, you can go back:

```bash
# See full history
git reflog

# Return to previous state
git reset --hard <previous-hash>
```

Or use your backup:

```bash
git checkout backup-20251121
```

## Additional Resources

### Date formats accepted

- Commit hash: `abc1234`
- ISO date: `2025-11-20`
- Relative: `yesterday`, `2 days ago`, `1 week ago`
- Commit reference: `HEAD~5` (5 commits back)

### Advanced options

```bash
# Show commits between dates
./scripts/view-history.sh --since '2025-11-01' --until '2025-11-20'

# Show all commits ever
./scripts/view-history.sh --all
```

### Understanding the methods

| Method | Changes Preserved | History Preserved | Safe for Shared Branch | Reversible |
|--------|------------------|-------------------|----------------------|------------|
| --soft | ✅ (staged)       | ❌                | ❌                   | ✅         |
| --mixed| ✅ (unstaged)     | ❌                | ❌                   | ✅         |
| --hard | ❌                | ❌                | ❌                   | ⚠️         |
| --revert| ✅ (as new commits)| ✅              | ✅                   | ✅         |

**Recommendation:** Use `--revert` for shared branches, `--soft` for local work.
