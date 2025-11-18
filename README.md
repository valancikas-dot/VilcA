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
