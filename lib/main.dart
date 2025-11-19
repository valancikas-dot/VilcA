import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const VilcaBrandSite());
}

class _AppCTA {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  _AppCTA({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });
}

class VilcaBrandSite extends StatefulWidget {
  const VilcaBrandSite({super.key});
  @override
  State<VilcaBrandSite> createState() => _VilcaBrandSiteState();
}

class _VilcaBrandSiteState extends State<VilcaBrandSite> with SingleTickerProviderStateMixin {
  String lang = 'lt';

  final translations = {
    'lt': {
      'title': 'VilcA – Mobiliųjų aplikacijų studija',
      'projects': 'Projektai',
      'contact': 'Susisiekite su mumis – siūlykite savo idėjas programėlėms',
      'name': 'Vardas',
      'email': 'El. paštas',
      'message': 'Žinutė',
      'send': 'Siųsti',
      'rangis': 'Rangis',
      'rangisDesc': 'Išmanioji rangos darbų valdymo programėlė',
      'forceplan': 'Forceplan',
      'forceplanDesc': 'Įdarbinimo agentūrų programėlė',
      'back': 'Grįžti į portfolio',
      'rangisDetails': 'Rangis – funkcijos, kaina, paskirtis',
      'forceplanDetails': 'Forceplan – funkcijos, kaina, paskirtis',
      'contactDetails': 'Susisiekite – forma, kontaktai',
    },
    'en': {
      'title': 'VilcA – Mobile App Studio',
      'projects': 'Projects',
      'contact': 'Contact us – pitch your app ideas',
      'name': 'Name',
      'email': 'Email',
      'message': 'Message',
      'send': 'Send',
      'rangis': 'Rangis',
      'rangisDesc': 'Smart construction management app',
      'forceplan': 'Forceplan',
      'forceplanDesc': 'Employment agency app',
      'back': 'Back to portfolio',
      'rangisDetails': 'Rangis – features, price, purpose',
      'forceplanDetails': 'Forceplan – features, price, purpose',
      'contactDetails': 'Contact – form, details',
    }
  };

  static const brandPrimary = Color(0xFFB32100);
  static const brandSecondary = Color(0xFFFF5E1B);
  static const brandAccent = Color(0xFFFFB347);
  static const darkBackground = Color(0xFF050505);
  static const surfaceColor = Color(0xFF1A0D07);
  static const glowColor = Color(0x33FFB347);
  static const _web3FormsEndpoint = 'https://api.web3forms.com/submit';
  static const web3FormsAccessKey = '6648a3fb-38d9-4383-847c-1d6d7e474e26';

  final _contactFormKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isSubmitting = false;
  late final AnimationController _heroController;
  late final Animation<double> _heroShift;

  String? detailsPage; // null = main, 'rangis', 'forceplan', 'contact'

  void openDetails(String page) {
    setState(() {
      detailsPage = page;
    });
  }

  Widget _ctaButton(BuildContext context, _AppCTA cta) {
    return SizedBox(
      height: 40,
      child: ElevatedButton.icon(
        icon: Icon(cta.icon, size: 18, color: Colors.white),
        label: Text(cta.label),
        style: ElevatedButton.styleFrom(
          backgroundColor: cta.color,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        onPressed: cta.onTap,
      ),
    );
  }

  List<_AppCTA> _defaultCtas(BuildContext context, String name) {
    return [
      _AppCTA(
        icon: Icons.android,
        label: 'Google Play',
        color: const Color(0xFF0F9D58),
        onTap: () => _showComingSoon(context, 'Google Play – $name'),
      ),
      _AppCTA(
        icon: Icons.apple,
        label: 'App Store',
        color: Colors.black87,
        onTap: () => _showComingSoon(context, 'App Store – $name'),
      ),
      _AppCTA(
        icon: Icons.language,
        label: 'Web',
        color: brandAccent.withOpacity(0.5),
        onTap: () => _showComingSoon(context, 'Web demo – $name'),
      ),
    ];
  }

  void _showComingSoon(BuildContext context, String platform) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(lang == 'lt' ? '$platform pasiekiama netrukus.' : '$platform link coming soon.')),
    );
  }

  void backToMain() {
    setState(() {
      detailsPage = null;
    });
  }

  @override
  void initState() {
    super.initState();
    _heroController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 14),
    )..repeat(reverse: true);
    _heroShift = CurvedAnimation(parent: _heroController, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _heroController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submitContactForm(BuildContext context) async {
    if (_isSubmitting) return;
    if (!_contactFormKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);
    try {
      final response = await http.post(
        Uri.parse(_web3FormsEndpoint),
        body: {
          'access_key': web3FormsAccessKey,
          'name': _nameController.text.trim(),
          'email': _emailController.text.trim(),
          'message': _messageController.text.trim(),
          'subject': 'VilcA kontaktinė forma',
          'from_name': 'VilcA Website',
        },
      );

      if (response.statusCode == 200) {
        _contactFormKey.currentState!.reset();
        _nameController.clear();
        _emailController.clear();
        _messageController.clear();
        await _showContactSuccessDialog(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(lang == 'lt' ? 'Nepavyko išsiųsti. Bandykite dar kartą.' : 'Sending failed. Please try again.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(lang == 'lt' ? 'Tinklo klaida. Patikrinkite ryšį.' : 'Network error. Please check your connection.')),
      );
    } finally {
      setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VilcA Brand',
      theme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: brandPrimary,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: Colors.transparent,
        fontFamily: 'Inter',
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Colors.white,
        ),
        cardColor: surfaceColor,
      ),
      home: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          toolbarHeight: 82,
          leadingWidth: 86,
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Image.asset('assets/VilcA.png', fit: BoxFit.contain),
          ),
          title: Text(detailsPage == null
              ? translations[lang]!['title']!
              : detailsPage == 'rangis'
                  ? translations[lang]!['rangisDetails']!
                  : detailsPage == 'forceplan'
                      ? translations[lang]!['forceplanDetails']!
                      : translations[lang]!['contactDetails']!),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.9),
                  brandPrimary.withOpacity(0.9),
                  brandSecondary.withOpacity(0.9),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border: const Border(
                bottom: BorderSide(color: Color(0x44FFFFFF), width: 1),
              ),
              boxShadow: [
                BoxShadow(color: brandAccent.withOpacity(0.25), blurRadius: 24, offset: const Offset(0, 12)),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => setState(() => lang = 'lt'),
              child: Text('LT', style: TextStyle(color: lang == 'lt' ? brandAccent : Colors.white)),
            ),
            TextButton(
              onPressed: () => setState(() => lang = 'en'),
              child: Text('EN', style: TextStyle(color: lang == 'en' ? brandAccent : Colors.white)),
            ),
          ],
        ),
        body: Stack(
          children: [
            AnimatedBuilder(
              animation: _heroShift,
              builder: (context, _) {
                final shift = (_heroShift.value - 0.5) * 0.8;
                return Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black,
                        darkBackground,
                        const Color(0xFF0B0200),
                      ],
                      begin: Alignment(-0.7 + shift, -1),
                      end: Alignment(0.7 - shift, 1),
                    ),
                  ),
                );
              },
            ),
            Positioned(
              top: -80,
              left: -40,
              child: _ambientGlow(size: 260, colors: [brandSecondary.withOpacity(0.55), Colors.transparent]),
            ),
            Positioned(
              bottom: -60,
              right: -30,
              child: _ambientGlow(size: 220, colors: [brandAccent.withOpacity(0.4), Colors.transparent]),
            ),
            Positioned(
              top: 220,
              right: 120,
              child: _ambientGlow(size: 140, colors: [brandPrimary.withOpacity(0.3), Colors.transparent]),
            ),
            Positioned.fill(
              child: detailsPage == null
                  ? _mainPage(context)
                  : detailsPage == 'rangis'
                      ? _rangisDetails()
                      : detailsPage == 'forceplan'
                          ? _forceplanDetails()
                          : _contactDetails(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _mainPage(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 140),
            // VilcA logo
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: brandAccent.withOpacity(0.4), width: 2),
                boxShadow: [
                  BoxShadow(color: brandSecondary.withOpacity(0.3), blurRadius: 32, spreadRadius: 4),
                ],
              ),
              child: Image.asset('assets/VilcA.png', height: 96),
            ),
            SizedBox(height: 24),
            Text(translations[lang]!['projects']!, style: TextStyle(fontSize: 32, color: brandAccent, fontWeight: FontWeight.bold, letterSpacing: 2)),
            SizedBox(height: 16),
            LayoutBuilder(
              builder: (context, constraints) {
                final isCompact = constraints.maxWidth < 760;
                final double cardWidth = isCompact ? constraints.maxWidth : 340;
                final rangisHighlights = lang == 'lt'
                    ? ['Projektai', 'Medžiagų rinka', 'PDF sąmatos']
                    : ['Projects', 'Materials', 'PDF estimates'];
                final forceplanHighlights = lang == 'lt'
                    ? ['Algoritmai', 'Sąskaitos', 'Komandos']
                    : ['Payroll', 'Invoices', 'Teams'];
                final normalizedWidth = cardWidth.clamp(260, 420).toDouble();
                return Wrap(
                  spacing: 24,
                  runSpacing: 24,
                  alignment: WrapAlignment.center,
                  children: [
                    SizedBox(
                      width: normalizedWidth,
                      child: _appCard(
                        context: context,
                        title: translations[lang]!['rangis']!,
                        description: translations[lang]!['rangisDesc']!,
                        color: brandSecondary,
                        logo: Image.asset('assets/rangis_premium_icon_1024.png', height: 48),
                        highlights: rangisHighlights,
                        ctas: _defaultCtas(context, 'Rangis'),
                        onTap: () => openDetails('rangis'),
                      ),
                    ),
                    SizedBox(
                      width: normalizedWidth,
                      child: _appCard(
                        context: context,
                        title: translations[lang]!['forceplan']!,
                        description: translations[lang]!['forceplanDesc']!,
                        color: brandPrimary,
                        logo: Image.asset('assets/forceplan_logo.png', height: 48),
                        highlights: forceplanHighlights,
                        ctas: _defaultCtas(context, 'Forceplan'),
                        onTap: () => openDetails('forceplan'),
                      ),
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: 40),
            Text(translations[lang]!['contact']!, style: TextStyle(fontSize: 28, color: brandAccent, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Card(
              color: surfaceColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: _contactForm(context),
              ),
            ),
            SizedBox(height: 32),
            Text('© VilcA ${DateTime.now().year}', style: TextStyle(color: Colors.white54)),
          ],
        ),
      ),
    );
  }

  Widget _appCard({
    required BuildContext context,
    required String title,
    required String description,
    required Color color,
    required Widget logo,
    required List<String> highlights,
    required List<_AppCTA> ctas,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color, darkBackground],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.4),
              blurRadius: 16,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            logo,
            SizedBox(height: 12),
            Text(title, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
            SizedBox(height: 8),
            Text(description, style: TextStyle(fontSize: 16, color: Colors.white70)),
            SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: highlights
                  .map((item) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white24),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.bolt, size: 14, color: brandAccent),
                            const SizedBox(width: 4),
                            Text(item, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                          ],
                        ),
                      ))
                  .toList(),
            ),
            SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: ctas.map((cta) => _ctaButton(context, cta)).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _rangisDetails() {
    final features = lang == 'lt'
        ? [
            'Pradžia — prisijunkite arba susikurkite profilį, o įvesti įmonės duomenys automatiškai keliauja į PDF dokumentus.',
            'Apatinis meniu — keturios pagrindinės sritys: Projektai, Rinka, Žinutės ir Daugiau.',
            'Projektai — klientų kortelės, sąmatos eilutės su kainomis, sąskaitų išrašymas ir PDF sugeneravimas, nuotraukų galerija.',
            'Rinka — sukurkite skelbimus apie medžiagas su nuotraukomis, vieta ir kontaktais, gaukite pirkėjų žinutes.',
            'Žinutės — saugūs pokalbiai su pardavėjais ar kolegomis, greitas dalijimasis skelbimų nuorodomis.',
            'Profilis ir nustatymai — logotipo įkėlimas PDF failams, prenumeratos valdymas, kalbos bei šviesios/tamsios temos pasirinkimas.'
          ]
        : [
            'Getting started — sign in or create a profile so company data is reused in generated PDFs.',
            'Bottom navigation — four core areas: Projects, Market, Messages and More.',
            'Projects — client cards, estimate line items with pricing, invoice creation/PDF export and a gallery for photos.',
            'Market — publish leftover material listings with photos, location and contacts, receive buyer messages.',
            'Messages — secure chats with sellers or teammates, quickly share listing links.',
            'Profile & settings — upload a logo for branded PDFs, manage subscriptions, choose language plus light/dark theme.'
          ];

    final target = lang == 'lt'
        ? 'Tinka statybų įmonėms, projektų vadovams ar brigadoms, kurios nori greitai kurti sąmatas, sąskaitas ir valdyti likusias medžiagas.'
        : 'Ideal for construction firms, project managers and crews who need quick estimates, invoices and leftover material tracking.';

    final price = lang == 'lt' ? '9.99 €/mėn.' : '€9.99 / month';

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(translations[lang]!['rangis']!, style: TextStyle(fontSize: 32, color: brandAccent, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            Text(lang == 'lt' ? 'Pilnas programėlės aprašymas' : 'Full app overview',
                style: TextStyle(fontSize: 18, color: Colors.white60)),
            SizedBox(height: 24),
            Text(lang == 'lt' ? 'Pagrindinės funkcijos' : 'Key features',
                style: TextStyle(fontSize: 20, color: brandSecondary, fontWeight: FontWeight.w600)),
            SizedBox(height: 12),
            ...features
                .map(
                  (feature) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('• ', style: TextStyle(fontSize: 18, color: Colors.white70)),
                        Expanded(child: Text(feature, style: TextStyle(fontSize: 18, color: Colors.white70))),
                      ],
                    ),
                  ),
                )
                .toList(),
            SizedBox(height: 24),
            Text(lang == 'lt' ? 'Kaina' : 'Pricing',
                style: TextStyle(fontSize: 20, color: brandSecondary, fontWeight: FontWeight.w600)),
            SizedBox(height: 8),
            Text(price, style: TextStyle(fontSize: 22, color: Colors.white)),
            SizedBox(height: 8),
            Text(lang == 'lt' ? 'Į kainą įskaičiuoti visi moduliai ir neribotas vartotojų kiekis.'
                : 'All modules included with unlimited users in the subscription.',
                style: TextStyle(fontSize: 18, color: Colors.white70)),
            SizedBox(height: 24),
            Text(lang == 'lt' ? 'Kam skirta?' : 'Who is it for?',
                style: TextStyle(fontSize: 20, color: brandSecondary, fontWeight: FontWeight.w600)),
            SizedBox(height: 8),
            Text(target, style: TextStyle(fontSize: 18, color: Colors.white70)),
            SizedBox(height: 32),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: brandSecondary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: backToMain,
              child: Text(translations[lang]!['back']!),
            ),
          ],
        ),
      ),
    );
  }

  Widget _forceplanDetails() {
    final featureBlocks = lang == 'lt'
        ? [
            'Dokumentų valdymas — šablonai darbo, paslaugų ar NDA sutartims, PDF generavimas ir pasirašymas skaitmeniniu būdu.',
            'Sąskaitų modulis — automatinis numeravimas, klientų bazė, paslaugų katalogas, PVM skaičiavimas ir apmokėjimų būsena.',
            'Algalapių sistema — atlyginimų bei mokesčių (GPM, Sodros įmokos, papildomi atskaitymai) skaičiavimas su eksporto failais bankui.',
            'Komandos valdymas — komandų kūrimas, vaidmenys (vadovas, administratorius, narys), kvietimų siuntimas ir veiklos stebėjimas.',
            'Darbo laiko apskaita — darbo pradžios/pabaigos registravimas, pertraukos, viršvalandžiai, kalendorinė peržiūra ir ataskaitos.',
            'Ataskaitos ir automatizacija — pajamų, mokesčių bei produktyvumo ataskaitos, nuolatiniai priminimai ir gidas naujiems vartotojams.'
          ]
        : [
            'Document management — templates for employment/service contracts, NDAs, PDF export and electronic signatures.',
            'Invoicing — automatic numbering, client CRM, product catalog, VAT calculation and payment status tracking.',
            'Payroll — salary and tax calculations (income tax, social contributions, deductions) with bank export files.',
            'Team management — create teams, assign roles (manager/admin/member), send invitations and monitor performance.',
            'Work hours — clock in/out, track breaks, overtime and project time with calendar view and reports.',
            'Reports & automation — revenue/tax insights, productivity dashboards plus reminders and an in-app quick start guide.'
          ];

    final target = lang == 'lt'
        ? 'Skirta įdarbinimo agentūroms ar kitoms įmonėms, kurios valdo didesnes komandas, generuoja sąskaitas bei algalapius vienoje sistemoje.'
        : 'Built for staffing agencies or any organization that needs to manage larger teams, invoices and payroll in a single workflow.';

    final price = lang == 'lt' ? '14.99 €/mėn.' : '€14.99 / month';

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(translations[lang]!['forceplan']!, style: TextStyle(fontSize: 32, color: brandAccent, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            Text(lang == 'lt' ? 'Pilnas ForcePlan funkcijų aprašymas' : 'In-depth ForcePlan overview',
                style: TextStyle(fontSize: 18, color: Colors.white60)),
            SizedBox(height: 24),
            Text(lang == 'lt' ? 'Pagrindiniai moduliai' : 'Key modules',
                style: TextStyle(fontSize: 20, color: brandSecondary, fontWeight: FontWeight.w600)),
            SizedBox(height: 12),
            ...featureBlocks
                .map(
                  (feature) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('• ', style: TextStyle(fontSize: 18, color: Colors.white70)),
                        Expanded(child: Text(feature, style: TextStyle(fontSize: 18, color: Colors.white70))),
                      ],
                    ),
                  ),
                )
                .toList(),
            SizedBox(height: 24),
            Text(lang == 'lt' ? 'Kaina' : 'Pricing',
                style: TextStyle(fontSize: 20, color: brandSecondary, fontWeight: FontWeight.w600)),
            SizedBox(height: 8),
            Text(price, style: TextStyle(fontSize: 22, color: Colors.white)),
            SizedBox(height: 8),
            Text(
                lang == 'lt'
                    ? 'Prenumeratoje įtraukti visi moduliai ir neribota darbuotojų bei dokumentų skaičiaus apskaita.'
                    : 'Subscription includes every module with unlimited employees and document generation.',
                style: TextStyle(fontSize: 18, color: Colors.white70)),
            SizedBox(height: 24),
            Text(lang == 'lt' ? 'Kam skirta?' : 'Who is it for?',
                style: TextStyle(fontSize: 20, color: brandSecondary, fontWeight: FontWeight.w600)),
            SizedBox(height: 8),
            Text(target, style: TextStyle(fontSize: 18, color: Colors.white70)),
            SizedBox(height: 32),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: brandSecondary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: backToMain,
              child: Text(translations[lang]!['back']!),
            ),
          ],
        ),
      ),
    );
  }

  Widget _ambientGlow({required double size, required List<Color> colors}) {
    return IgnorePointer(
      ignoring: true,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(colors: colors, stops: const [0.0, 1.0]),
          boxShadow: [
            BoxShadow(color: colors.first.withOpacity(0.4), blurRadius: size / 4, spreadRadius: size / 10),
          ],
        ),
      ),
    );
  }

  Future<void> _showContactSuccessDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: surfaceColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          title: Row(
            children: [
              Icon(Icons.check_circle, color: brandAccent),
              const SizedBox(width: 8),
              Text(lang == 'lt' ? 'Žinutė gauta' : 'Message received'),
            ],
          ),
          content: Text(
            lang == 'lt'
                ? 'Ačiū, kad susisiekėte! Atsakysiu per 24 valandas. Tuo tarpu galite peržiūrėti projektų studijas.'
                : 'Thanks for reaching out! I will respond within 24 hours. Meanwhile, feel free to explore the case studies.',
            style: const TextStyle(color: Colors.white70),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(lang == 'lt' ? 'Uždaryti' : 'Close'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: brandSecondary),
              onPressed: () {
                Navigator.of(context).pop();
                backToMain();
              },
              child: Text(lang == 'lt' ? 'Peržiūrėti projektus' : 'View projects'),
            ),
          ],
        );
      },
    );
  }

  Widget _contactForm(BuildContext context) {
    return Form(
      key: _contactFormKey,
      child: Column(
        children: [
          TextFormField(
            controller: _nameController,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: translations[lang]!['name'],
              labelStyle: TextStyle(color: brandAccent),
              border: const OutlineInputBorder(),
            ),
            validator: (value) => (value == null || value.trim().isEmpty)
                ? (lang == 'lt' ? 'Įveskite vardą' : 'Enter your name')
                : null,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _emailController,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: translations[lang]!['email'],
              labelStyle: TextStyle(color: brandAccent),
              border: const OutlineInputBorder(),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return lang == 'lt' ? 'Įveskite el. paštą' : 'Enter your email';
              }
              final emailRegex = RegExp(r'^.+@.+\..+$');
              if (!emailRegex.hasMatch(value.trim())) {
                return lang == 'lt' ? 'Neteisingas el. paštas' : 'Invalid email';
              }
              return null;
            },
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _messageController,
            style: const TextStyle(color: Colors.white),
            maxLines: 4,
            decoration: InputDecoration(
              labelText: translations[lang]!['message'],
              labelStyle: TextStyle(color: brandAccent),
              border: const OutlineInputBorder(),
            ),
            validator: (value) => (value == null || value.trim().isEmpty)
                ? (lang == 'lt' ? 'Įveskite žinutę' : 'Enter your message')
                : null,
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: brandSecondary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: _isSubmitting ? null : () => _submitContactForm(context),
              child: _isSubmitting
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                    )
                  : Text(translations[lang]!['send']!),
            ),
          ),
        ],
      ),
    );
  }

  Widget _contactDetails() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(translations[lang]!['contact']!, style: TextStyle(fontSize: 32, color: brandAccent, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Card(
              color: surfaceColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: _contactForm(context),
              ),
            ),
            SizedBox(height: 32),
            Text('info@vilca.lt', style: TextStyle(fontSize: 18, color: Colors.white70)),
            SizedBox(height: 8),
            Text('+370 600 00000', style: TextStyle(fontSize: 18, color: Colors.white70)),
            SizedBox(height: 32),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: brandSecondary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: backToMain,
              child: Text(translations[lang]!['back']!),
            ),
          ],
        ),
      ),
    );
  }
}
