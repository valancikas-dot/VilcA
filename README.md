# VilcA Portfolio Website

Šiame repo talpinamas VilcA mobiliųjų aplikacijų studijos pristatymo puslapis. Projektą sudaro:

- Flutter Web aplikacija (`lib/main.dart`) su interaktyviu rangos projektų katalogu, detalių puslapiais ir kontaktų forma.
- Statiniai HTML maketai (`vilca-portfolio.html`, `web/…`) skirti pasidalinti projekto informacija už Flutter ribų.
- Vizualiniai resursai (`assets/`, `web/icons/`) su VilcA, Rangis ir Forceplan logotipais.

## Kūrimo komandos

Reikiama aplinka:

- Flutter 3.9+ (beta channel) ir Dart SDK 3.9+
- Chrome (testavimui per `flutter run -d chrome`)

### Paleidimas lokaliai

```bash
flutter pub get
flutter run -d chrome
```

### Statinio build generavimas

```bash
flutter build web
python3 -m http.server 9000 --directory build/web
```

Atidaryk `http://localhost:9000` naršyklėje ir matysi naujausią versiją.

## Deploy

- `build/web` katalogas gali būti įkeliamas į GitHub Pages arba kitą statinio hosting'o sprendimą.
- GitHub Pages atveju `flutter build web` generuojamus failus galima perkelti į `gh-pages` šaką.

Visi dizaino atnaujinimai turi būti testuojami tiek Flutter aplikacijoje, tiek statiniame HTML, kad atrodytų nuosekliai.

## Git laiko atstatymas / Reverting to a Specific Date

Galite atstatyti projektą į ankstesnį momentą laiko naudodami įrankius `scripts/` kataloge.

### Žiūrėti istoriją su laiko žymomis

```bash
# Rodyti paskutinius 20 commit'ų
./scripts/view-history.sh

# Rodyti paskutinius 10 commit'ų
./scripts/view-history.sh -n 10

# Rodyti commit'us nuo konkrečios datos
./scripts/view-history.sh --since '2025-11-20'

# Rodyti commit'us per paskutinę savaitę
./scripts/view-history.sh --since '1 week ago'

# Pagalba
./scripts/view-history.sh --help
```

### Atstatyti į konkretų laiką

**⚠️ SVARBU:** Prieš atstatant, sukurkite atsarginę kopiją:

```bash
git branch backup-$(date +%Y%m%d-%H%M%S)
```

**Atstatymo metodai:**

```bash
# 1. Soft reset - saugiausia, palieka pakeitimus staged būsenoje
./scripts/revert-to-date.sh <commit-hash> --soft

# 2. Mixed reset - palieka pakeitimus working directory (numatytasis)
./scripts/revert-to-date.sh <commit-hash> --mixed

# 3. Hard reset - IŠTRINS visus pakeitimus (PAVOJINGA!)
./scripts/revert-to-date.sh <commit-hash> --hard

# 4. Revert - sukuria naujus commit'us, saugi viešoms šakoms
./scripts/revert-to-date.sh <commit-hash> --revert
```

**Pavyzdžiai:**

```bash
# Atstatyti į konkretų commit
./scripts/revert-to-date.sh abc1234 --soft

# Atstatyti į datą (randa artimiausią commit)
./scripts/revert-to-date.sh '2025-11-20' --mixed

# Atstatyti 5 commit'us atgal
./scripts/revert-to-date.sh 'HEAD~5' --revert

# Pagalba
./scripts/revert-to-date.sh --help
```

**Atšaukti operaciją:**

Jei reikia atšaukti atstatymo operaciją:

```bash
git reflog                    # Rasti ankstesnį HEAD
git reset --hard <hash>       # Grįžti į ankstesnę būseną
```

---

## Reverting Changes to a Specific Date/Time (English)

You can revert the project to a previous point in time using the tools in the `scripts/` directory.

### View History with Timestamps

```bash
# Show last 20 commits
./scripts/view-history.sh

# Show last 10 commits
./scripts/view-history.sh -n 10

# Show commits since specific date
./scripts/view-history.sh --since '2025-11-20'

# Show commits from last week
./scripts/view-history.sh --since '1 week ago'

# Help
./scripts/view-history.sh --help
```

### Revert to Specific Time

**⚠️ IMPORTANT:** Before reverting, create a backup:

```bash
git branch backup-$(date +%Y%m%d-%H%M%S)
```

**Revert Methods:**

```bash
# 1. Soft reset - safest, keeps changes staged
./scripts/revert-to-date.sh <commit-hash> --soft

# 2. Mixed reset - keeps changes in working directory (default)
./scripts/revert-to-date.sh <commit-hash> --mixed

# 3. Hard reset - DELETES all changes (DANGEROUS!)
./scripts/revert-to-date.sh <commit-hash> --hard

# 4. Revert - creates new commits, safe for shared branches
./scripts/revert-to-date.sh <commit-hash> --revert
```

**Examples:**

```bash
# Revert to specific commit
./scripts/revert-to-date.sh abc1234 --soft

# Revert to date (finds closest commit)
./scripts/revert-to-date.sh '2025-11-20' --mixed

# Revert 5 commits back
./scripts/revert-to-date.sh 'HEAD~5' --revert

# Help
./scripts/revert-to-date.sh --help
```

**Undo Operation:**

If you need to undo the revert operation:

```bash
git reflog                    # Find previous HEAD
git reset --hard <hash>       # Return to previous state
```
