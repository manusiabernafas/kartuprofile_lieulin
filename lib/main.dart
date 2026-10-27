import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// =====================================================================
// DATA PROFIL & KONFIGURASI PRIBADI
// =====================================================================
const String kNamaLengkap = 'M. Lie Ulin Nuha';
const String kNim = '4124018';
const String kDeskripsiUtama = 'Saya Seorang Vibe Coding';
const String kFotoProfil = 'assets/Ulin.jpg';
const String kKampus = 'Universitas Pesantren Tinggi Darul \'Ulum (UNIPDU)';
const String kProdi = 'S1 Sistem Informasi';
const String kEmail = 'ulinnuha.vibecoding@gmail.com';
const String kNoHp = '+62 821-3948-2018';
const String kGithub = 'github.com/ulinnuha-vibecoding';
const String kInstagram = '@ulin.vibecoding';
const String kLokasi = 'Jombang, Jawa Timur';

// =====================================================================
// NEOBRUTALISM COLOR PALETTE
// =====================================================================
class NeoColors {
  static const Color bg = Color(0xFFFFFDF0); // Warm cream canvas
  static const Color dark = Color(0xFF181818); // Solid black border & text
  static const Color yellow = Color(0xFFFFDE59); // Cyber banana yellow
  static const Color pink = Color(0xFFFF66C4); // Punchy brutalist pink
  static const Color cyan = Color(0xFF5CE1E6); // Electric aqua cyan
  static const Color green = Color(0xFF7ED957); // Acid toxic lime
  static const Color orange = Color(0xFFFF914D); // Vivid retro orange
  static const Color purple = Color(0xFFC288FF); // Playful lavender
  static const Color cardBg = Color(0xFFFFFFFF); // Crisp clean white
}

void main() {
  runApp(const NeoProfileApp());
}

class NeoProfileApp extends StatefulWidget {
  const NeoProfileApp({super.key});

  @override
  State<NeoProfileApp> createState() => _NeoProfileAppState();
}

class _NeoProfileAppState extends State<NeoProfileApp> {
  // Global theme accent color switcher
  Color _accentColor = NeoColors.yellow;

  void _changeAccent(Color newColor) {
    setState(() {
      _accentColor = newColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kartu Profil - $kNamaLengkap',
      theme: ThemeData(
        scaffoldBackgroundColor: NeoColors.bg,
        useMaterial3: true,
        fontFamily: 'sans-serif',
      ),
      home: OpeningPage(
        accentColor: _accentColor,
        onAccentChanged: _changeAccent,
      ),
    );
  }
}

// =====================================================================
// REUSABLE NEOBRUTALIST WIDGETS
// =====================================================================

/// Kotak bergaya Neobrutalism dengan garis tepi tebal & bayangan keras (hard shadow)
class NeoBox extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  final double borderRadius;
  final double borderWidth;
  final Offset shadowOffset;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;

  const NeoBox({
    super.key,
    required this.child,
    this.backgroundColor = NeoColors.cardBg,
    this.borderRadius = 14,
    this.borderWidth = 3.0,
    this.shadowOffset = const Offset(5, 5),
    this.padding,
    this.margin,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: NeoColors.dark, width: borderWidth),
        boxShadow: shadowOffset == Offset.zero
            ? []
            : [
                BoxShadow(
                  color: NeoColors.dark,
                  offset: shadowOffset,
                  blurRadius: 0,
                ),
              ],
      ),
      padding: padding,
      child: child,
    );
  }
}

/// Tombol interaktif Neobrutalism dengan efek klik fisik (turun saat ditekan)
class NeoButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final Offset shadowOffset;

  const NeoButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.backgroundColor = NeoColors.yellow,
    this.borderRadius = 12,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    this.shadowOffset = const Offset(4, 4),
  });

  @override
  State<NeoButton> createState() => _NeoButtonState();
}

class _NeoButtonState extends State<NeoButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final currentOffset = _isPressed
        ? const Offset(1, 1)
        : widget.shadowOffset;
    final translation = _isPressed
        ? Offset(widget.shadowOffset.dx - 1, widget.shadowOffset.dy - 1)
        : Offset.zero;

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onPressed?.call();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: Transform.translate(
        offset: translation,
        child: Container(
          padding: widget.padding,
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            border: Border.all(color: NeoColors.dark, width: 2.8),
            boxShadow: [
              BoxShadow(
                color: NeoColors.dark,
                offset: currentOffset,
                blurRadius: 0,
              ),
            ],
          ),
          child: widget.child,
        ),
      ),
    );
  }
}

/// Sticker / Badge Neobrutalism miring (rotated) dengan border & hard shadow
class NeoStickerBadge extends StatelessWidget {
  final String text;
  final Color color;
  final double angle;
  final IconData? icon;

  const NeoStickerBadge({
    super.key,
    required this.text,
    this.color = NeoColors.pink,
    this.angle = -0.05,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: NeoColors.dark, width: 2.5),
          boxShadow: const [
            BoxShadow(
              color: NeoColors.dark,
              offset: Offset(3, 3),
              blurRadius: 0,
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 14, color: NeoColors.dark),
              const SizedBox(width: 5),
            ],
            Text(
              text,
              style: const TextStyle(
                color: NeoColors.dark,
                fontSize: 12,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================================
// HALAMAN 1: OPENING PAGE (NEOBRUTALISM WELCOME)
// =====================================================================
class OpeningPage extends StatelessWidget {
  final Color accentColor;
  final ValueChanged<Color> onAccentChanged;

  const OpeningPage({
    super.key,
    required this.accentColor,
    required this.onAccentChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 580),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Top Pill Header
                  const NeoStickerBadge(
                    text: '★ TUGAS PRAKTIKUM MOBILE PROGRAMMING ★',
                    color: NeoColors.green,
                    angle: -0.02,
                    icon: Icons.code,
                  ),
                  const SizedBox(height: 24),

                  // Hero Neobrutalist Card
                  NeoBox(
                    backgroundColor: NeoColors.cardBg,
                    borderRadius: 20,
                    borderWidth: 3.5,
                    shadowOffset: const Offset(8, 8),
                    padding: const EdgeInsets.all(28),
                    child: Column(
                      children: [
                        // Avatar Frame with Rotated Sticker
                        Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 170,
                              height: 170,
                              decoration: BoxDecoration(
                                color: accentColor,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: NeoColors.dark,
                                  width: 3.5,
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: NeoColors.dark,
                                    offset: Offset(5, 5),
                                    blurRadius: 0,
                                  ),
                                ],
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: Image.asset(
                                kFotoProfil,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: accentColor,
                                    child: const Center(
                                      child: Icon(
                                        Icons.person_rounded,
                                        size: 90,
                                        color: NeoColors.dark,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const Positioned(
                              top: -12,
                              right: -14,
                              child: NeoStickerBadge(
                                text: '⚡ VIBE CODER',
                                color: NeoColors.yellow,
                                angle: 0.12,
                              ),
                            ),
                            Positioned(
                              bottom: -10,
                              left: -10,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: NeoColors.cyan,
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: NeoColors.dark,
                                    width: 2,
                                  ),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: NeoColors.dark,
                                      offset: Offset(2, 2),
                                      blurRadius: 0,
                                    ),
                                  ],
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      size: 10,
                                      color: Colors.green,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      'ONLINE & CODING',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w900,
                                        color: NeoColors.dark,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 32),

                        // Nama Lengkap
                        const Text(
                          kNamaLengkap,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                            color: NeoColors.dark,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // NIM Badge (High Contrast)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: NeoColors.yellow,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: NeoColors.dark,
                              width: 2.2,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: NeoColors.dark,
                                offset: Offset(2.5, 2.5),
                                blurRadius: 0,
                              ),
                            ],
                          ),
                          child: const Text(
                            'NIM : $kNim',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              color: NeoColors.dark,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Banner Tagline: "Saya Seorang Vibe Coding"
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: NeoColors.pink,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: NeoColors.dark,
                              width: 2.5,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: NeoColors.dark,
                                offset: Offset(3, 3),
                                blurRadius: 0,
                              ),
                            ],
                          ),
                          child: const Text(
                            '🔥 $kDeskripsiUtama',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),

                        const SizedBox(height: 14),

                        // Kampus & Keterangan
                        const Text(
                          '$kProdi\n$kKampus',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                            height: 1.4,
                          ),
                        ),

                        const SizedBox(height: 28),

                        // Button Navigasi ke Profil Lengkap
                        SizedBox(
                          width: double.infinity,
                          child: NeoButton(
                            backgroundColor: accentColor,
                            borderRadius: 14,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => ProfileCardPage(
                                    accentColor: accentColor,
                                    onAccentChanged: onAccentChanged,
                                  ),
                                ),
                              );
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'BUKA KARTU PROFIL',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 0.5,
                                    color: NeoColors.dark,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(
                                  Icons.arrow_forward_rounded,
                                  color: NeoColors.dark,
                                  size: 22,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Neobrutalist Tags di bawah
                  const Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    alignment: WrapAlignment.center,
                    children: [
                      NeoTagPill(label: 'FLUTTER DART', color: NeoColors.cyan),
                      NeoTagPill(label: 'NEOBRUTALISM', color: NeoColors.yellow),
                      NeoTagPill(label: 'VIBE CODING', color: NeoColors.green),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NeoTagPill extends StatelessWidget {
  final String label;
  final Color color;

  const NeoTagPill({super.key, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: NeoColors.dark, width: 2),
        boxShadow: const [
          BoxShadow(
            color: NeoColors.dark,
            offset: Offset(2, 2),
            blurRadius: 0,
          ),
        ],
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w900,
          color: NeoColors.dark,
        ),
      ),
    );
  }
}

// =====================================================================
// HALAMAN 2: PROFIL CARD LENGKAP (NEOBRUTALISM FULL EXPERIENCE)
// =====================================================================
class ProfileCardPage extends StatefulWidget {
  final Color accentColor;
  final ValueChanged<Color> onAccentChanged;

  const ProfileCardPage({
    super.key,
    required this.accentColor,
    required this.onAccentChanged,
  });

  @override
  State<ProfileCardPage> createState() => _ProfileCardPageState();
}

class _ProfileCardPageState extends State<ProfileCardPage> {
  // Quotes interaktif "Vibe Coder"
  final List<String> _vibeQuotes = [
    '⚡ "80% Vibe, 20% Prompt, 100% Shipped to Production!"',
    '🚀 "Kenapa debug 5 jam kalau bisa vibe coding santai bareng AI?"',
    '🎨 "Prompt adalah bahasa pemrogramanku, Flutter adalah kanvasku."',
    '☕ "Kopi panas, lagu lofi, kode ngalir tanpa hambatan."',
    '💡 "Tidak ada bug, yang ada hanyalah fitur yang tak terduga."',
    '🔥 "Code fast, iterate faster, vibe hardest!"',
  ];
  int _quoteIndex = 0;

  void _nextQuote() {
    setState(() {
      _quoteIndex = (_quoteIndex + 1) % _vibeQuotes.length;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '✨ Vibe baru terpilih!',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: NeoColors.dark,
          ),
        ),
        backgroundColor: NeoColors.yellow,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: NeoColors.dark, width: 2),
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _salinKeClipboard(String teks, String label) {
    Clipboard.setData(ClipboardData(text: teks));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '📋 $label berhasil disalin: "$teks"',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: NeoColors.dark,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: NeoColors.yellow, width: 2),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeoColors.bg,
      appBar: AppBar(
        backgroundColor: NeoColors.cardBg,
        elevation: 0,
        scrolledUnderElevation: 0,
        shape: const Border(
          bottom: BorderSide(color: NeoColors.dark, width: 3),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: NeoButton(
            backgroundColor: NeoColors.yellow,
            borderRadius: 8,
            padding: EdgeInsets.zero,
            shadowOffset: const Offset(2, 2),
            onPressed: () => Navigator.of(context).pop(),
            child: const Icon(
              Icons.arrow_back_rounded,
              color: NeoColors.dark,
              size: 20,
            ),
          ),
        ),
        title: const Text(
          'KARTU PROFIL // ULIN NUHA',
          style: TextStyle(
            color: NeoColors.dark,
            fontWeight: FontWeight.w900,
            fontSize: 16,
            letterSpacing: 0.5,
          ),
        ),
        actions: [
          // Theme color picker right on the app bar!
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Row(
              children: [
                _buildColorDot(NeoColors.yellow),
                _buildColorDot(NeoColors.pink),
                _buildColorDot(NeoColors.cyan),
                _buildColorDot(NeoColors.green),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 860),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 1. HERO PROFILE CARD
                _buildHeroCard(context),

                const SizedBox(height: 16),

                // 2. TICKER TAPE MARQUEE
                _buildTickerTape(),

                const SizedBox(height: 16),

                // 3. STATS GRID (NIM, ROLE, KAMPUS, STATUS)
                _buildStatsGrid(),

                const SizedBox(height: 16),

                // 4. TENTANG SAYA ("Saya Seorang Vibe Coding")
                _buildAboutSection(),

                const SizedBox(height: 16),

                // 5. VIBE GENERATOR INTERAKTIF
                _buildVibeGeneratorSection(),

                const SizedBox(height: 16),

                // 6. DATA PRIBADI & KONTAK
                _buildPersonalDataSection(),

                const SizedBox(height: 16),

                // 7. KEAHLIAN & TECH STACK (VIBE STACK)
                _buildSkillsSection(),

                const SizedBox(height: 16),

                // 8. RIWAYAT PENDIDIKAN & PENGALAMAN
                _buildEducationSection(),

                const SizedBox(height: 24),

                // 9. FOOTER STAMP
                _buildFooterStamp(),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildColorDot(Color color) {
    final bool isSelected = widget.accentColor.value == color.value;
    return GestureDetector(
      onTap: () => widget.onAccentChanged(color),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 3),
        width: 22,
        height: 22,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: NeoColors.dark,
            width: isSelected ? 2.5 : 1.5,
          ),
          boxShadow: isSelected
              ? const [
                  BoxShadow(
                    color: NeoColors.dark,
                    offset: Offset(1.5, 1.5),
                    blurRadius: 0,
                  ),
                ]
              : null,
        ),
      ),
    );
  }

  // -------------------------------------------------------------------
  // 1. HERO PROFILE CARD
  // -------------------------------------------------------------------
  Widget _buildHeroCard(BuildContext context) {
    return NeoBox(
      backgroundColor: NeoColors.cardBg,
      borderRadius: 18,
      borderWidth: 3.5,
      shadowOffset: const Offset(7, 7),
      padding: const EdgeInsets.all(22),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 580;

          final avatarWidget = Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: isWide ? 190 : 160,
                height: isWide ? 190 : 160,
                decoration: BoxDecoration(
                  color: widget.accentColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: NeoColors.dark, width: 3.5),
                  boxShadow: const [
                    BoxShadow(
                      color: NeoColors.dark,
                      offset: Offset(5, 5),
                      blurRadius: 0,
                    ),
                  ],
                ),
                clipBehavior: Clip.antiAlias,
                child: Image.asset(
                  kFotoProfil,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: widget.accentColor,
                      child: const Center(
                        child: Icon(
                          Icons.person_rounded,
                          size: 90,
                          color: NeoColors.dark,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const Positioned(
                bottom: -10,
                right: -6,
                child: NeoStickerBadge(
                  text: '⚡ VIBE CODER',
                  color: NeoColors.yellow,
                  angle: 0.08,
                ),
              ),
              Positioned(
                top: -8,
                left: -8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: NeoColors.green,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: NeoColors.dark, width: 2),
                    boxShadow: const [
                      BoxShadow(
                        color: NeoColors.dark,
                        offset: Offset(2, 2),
                        blurRadius: 0,
                      ),
                    ],
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.bolt, size: 14, color: NeoColors.dark),
                      SizedBox(width: 4),
                      Text(
                        'VERIFIED',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          color: NeoColors.dark,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );

          final detailsWidget = Column(
            crossAxisAlignment:
                isWide ? CrossAxisAlignment.start : CrossAxisAlignment.center,
            children: [
              // Row badge NIM & Status
              Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment:
                    isWide ? WrapAlignment.start : WrapAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => _salinKeClipboard(kNim, 'NIM'),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: NeoColors.yellow,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: NeoColors.dark, width: 2.5),
                        boxShadow: const [
                          BoxShadow(
                            color: NeoColors.dark,
                            offset: Offset(2.5, 2.5),
                            blurRadius: 0,
                          ),
                        ],
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.badge, size: 16, color: NeoColors.dark),
                          SizedBox(width: 6),
                          Text(
                            'NIM: $kNim',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w900,
                              color: NeoColors.dark,
                              letterSpacing: 0.5,
                            ),
                          ),
                          SizedBox(width: 4),
                          Icon(Icons.copy, size: 13, color: NeoColors.dark),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: NeoColors.cyan,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: NeoColors.dark, width: 2.5),
                      boxShadow: const [
                        BoxShadow(
                          color: NeoColors.dark,
                          offset: Offset(2.5, 2.5),
                          blurRadius: 0,
                        ),
                      ],
                    ),
                    child: const Text(
                      'STATUS: AKTIF (SMT 5)',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                        color: NeoColors.dark,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Nama
              Text(
                kNamaLengkap,
                textAlign: isWide ? TextAlign.left : TextAlign.center,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: NeoColors.dark,
                  letterSpacing: -0.5,
                ),
              ),

              const SizedBox(height: 6),

              // Deskripsi Utama Banner
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: NeoColors.pink,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: NeoColors.dark, width: 2.2),
                  boxShadow: const [
                    BoxShadow(
                      color: NeoColors.dark,
                      offset: Offset(3, 3),
                      blurRadius: 0,
                    ),
                  ],
                ),
                child: const Text(
                  '⚡ $kDeskripsiUtama',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 0.4,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Prodi & Kampus
              Text(
                '$kProdi\n$kKampus',
                textAlign: isWide ? TextAlign.left : TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade800,
                  height: 1.35,
                ),
              ),

              const SizedBox(height: 16),

              // Tombol Aksi Cepat (Quick Actions)
              Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment:
                    isWide ? WrapAlignment.start : WrapAlignment.center,
                children: [
                  NeoButton(
                    backgroundColor: NeoColors.yellow,
                    borderRadius: 8,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 9,
                    ),
                    shadowOffset: const Offset(3, 3),
                    onPressed: () => _salinKeClipboard(kNim, 'NIM'),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.copy, size: 15, color: NeoColors.dark),
                        SizedBox(width: 6),
                        Text(
                          'Salin NIM',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            color: NeoColors.dark,
                          ),
                        ),
                      ],
                    ),
                  ),
                  NeoButton(
                    backgroundColor: NeoColors.green,
                    borderRadius: 8,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 9,
                    ),
                    shadowOffset: const Offset(3, 3),
                    onPressed: () => _salinKeClipboard(kNoHp, 'WhatsApp'),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.chat, size: 15, color: NeoColors.dark),
                        SizedBox(width: 6),
                        Text(
                          'WhatsApp',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            color: NeoColors.dark,
                          ),
                        ),
                      ],
                    ),
                  ),
                  NeoButton(
                    backgroundColor: NeoColors.cyan,
                    borderRadius: 8,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 9,
                    ),
                    shadowOffset: const Offset(3, 3),
                    onPressed: () => _salinKeClipboard(kEmail, 'Email'),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.email, size: 15, color: NeoColors.dark),
                        SizedBox(width: 6),
                        Text(
                          'Email',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            color: NeoColors.dark,
                          ),
                        ),
                      ],
                    ),
                  ),
                  NeoButton(
                    backgroundColor: NeoColors.orange,
                    borderRadius: 8,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 9,
                    ),
                    shadowOffset: const Offset(3, 3),
                    onPressed: () => _salinKeClipboard(kGithub, 'GitHub'),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.code, size: 15, color: NeoColors.dark),
                        SizedBox(width: 6),
                        Text(
                          'GitHub',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            color: NeoColors.dark,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );

          if (isWide) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                avatarWidget,
                const SizedBox(width: 28),
                Expanded(child: detailsWidget),
              ],
            );
          } else {
            return Column(
              children: [
                avatarWidget,
                const SizedBox(height: 24),
                detailsWidget,
              ],
            );
          }
        },
      ),
    );
  }

  // -------------------------------------------------------------------
  // 2. TICKER TAPE BANNER
  // -------------------------------------------------------------------
  Widget _buildTickerTape() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        color: NeoColors.yellow,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: NeoColors.dark, width: 2.8),
        boxShadow: const [
          BoxShadow(
            color: NeoColors.dark,
            offset: Offset(4, 4),
            blurRadius: 0,
          ),
        ],
      ),
      child: const SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Text(
              '⚡ SAYA SEORANG VIBE CODING ⚡ NIM: 4124018 ⚡ FAST SHIPPING ⚡ FLUTTER & DART ⚡ AI PROMPT CRAFTER ⚡ UNIPDU 2026 ⚡ NO BUGS ONLY FEATURES ⚡',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w900,
                color: NeoColors.dark,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // -------------------------------------------------------------------
  // 3. STATS GRID
  // -------------------------------------------------------------------
  Widget _buildStatsGrid() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmall = constraints.maxWidth < 500;
        final count = isSmall ? 2 : 4;

        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: count,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: isSmall ? 1.4 : 1.25,
          children: const [
            NeoStatCard(
              title: 'NIM',
              value: kNim,
              color: NeoColors.yellow,
              icon: Icons.confirmation_number_outlined,
            ),
            NeoStatCard(
              title: 'ROLE',
              value: 'Vibe Coder',
              color: NeoColors.pink,
              icon: Icons.bolt,
            ),
            NeoStatCard(
              title: 'KAMPUS',
              value: 'UNIPDU',
              color: NeoColors.cyan,
              icon: Icons.school,
            ),
            NeoStatCard(
              title: 'STATUS',
              value: 'Aktif Smt 5',
              color: NeoColors.green,
              icon: Icons.check_circle_outline,
            ),
          ],
        );
      },
    );
  }

  // -------------------------------------------------------------------
  // 4. TENTANG SAYA
  // -------------------------------------------------------------------
  Widget _buildAboutSection() {
    return NeoBox(
      backgroundColor: NeoColors.cardBg,
      borderRadius: 16,
      borderWidth: 3.0,
      shadowOffset: const Offset(5, 5),
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: NeoColors.yellow,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: NeoColors.dark, width: 2),
                ),
                child: const Icon(
                  Icons.person_pin_rounded,
                  color: NeoColors.dark,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'TENTANG SAYA',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: NeoColors.dark,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Highlight Text Box
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0x595CE1E6),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: NeoColors.dark, width: 2),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('💡', style: TextStyle(fontSize: 20)),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Saya Seorang Vibe Coding yang memadukan intuisi kreatif, percepatan AI, dan fondasi logika pemrograman untuk menciptakan karya digital bernilai tinggi.',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: NeoColors.dark,
                      height: 1.45,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),

          const Text(
            'Halo! Nama saya M. Lie Ulin Nuha (NIM 4124018), seorang mahasiswa aktif Program Studi S1 Sistem Informasi di UNIPDU Jombang. '
            'Saya mendedikasikan diri pada filosofi Vibe Coding — cara kerja modern di mana ide dieksekusi dengan cepat, tepat sasaran, dan tanpa hambatan birokrasi kode yang berbelit-belit.\n\n'
            'Bagi saya, pemrograman bukan sekadar menghafal sintaks, melainkan seni merajut solusi, menyusun prompt yang tajam, dan memvisualisasikan antarmuka yang memikat seperti Neobrutalism ini. '
            'Saya selalu antusias mengeksplorasi ekosistem Flutter, arsitektur UI/UX ekspresif, dan integrasi automasi digital demi menghadirkan solusi yang bermanfaat bagi sesama.',
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: 14,
              color: NeoColors.dark,
              height: 1.6,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------
  // 5. VIBE GENERATOR INTERAKTIF
  // -------------------------------------------------------------------
  Widget _buildVibeGeneratorSection() {
    return NeoBox(
      backgroundColor: const Color(0x59C288FF),
      borderRadius: 16,
      borderWidth: 3.0,
      shadowOffset: const Offset(5, 5),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(Icons.auto_awesome, color: NeoColors.dark, size: 22),
                  SizedBox(width: 8),
                  Text(
                    'VIBE OF THE DAY',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: NeoColors.dark,
                    ),
                  ),
                ],
              ),
              NeoButton(
                backgroundColor: NeoColors.yellow,
                borderRadius: 8,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                shadowOffset: const Offset(2, 2),
                onPressed: _nextQuote,
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.casino, size: 16, color: NeoColors.dark),
                    SizedBox(width: 4),
                    Text(
                      'Roll Vibe!',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                        color: NeoColors.dark,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          NeoBox(
            backgroundColor: NeoColors.cardBg,
            borderRadius: 10,
            borderWidth: 2.2,
            shadowOffset: const Offset(3, 3),
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _vibeQuotes[_quoteIndex],
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      fontStyle: FontStyle.italic,
                      color: NeoColors.dark,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------
  // 6. DATA PRIBADI & KONTAK
  // -------------------------------------------------------------------
  Widget _buildPersonalDataSection() {
    return NeoBox(
      backgroundColor: NeoColors.cardBg,
      borderRadius: 16,
      borderWidth: 3.0,
      shadowOffset: const Offset(5, 5),
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: NeoColors.pink,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: NeoColors.dark, width: 2),
                ),
                child: const Icon(
                  Icons.badge_outlined,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'DATA PRIBADI & KONTAK',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: NeoColors.dark,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          NeoInfoRow(
            icon: Icons.person,
            label: 'Nama Lengkap',
            value: kNamaLengkap,
            color: NeoColors.yellow,
            onCopy: () => _salinKeClipboard(kNamaLengkap, 'Nama Lengkap'),
          ),
          NeoInfoRow(
            icon: Icons.confirmation_number,
            label: 'NIM',
            value: kNim,
            color: NeoColors.cyan,
            onCopy: () => _salinKeClipboard(kNim, 'NIM'),
          ),
          NeoInfoRow(
            icon: Icons.electric_bolt,
            label: 'Gelar / Title',
            value: kDeskripsiUtama,
            color: NeoColors.pink,
            onCopy: () => _salinKeClipboard(kDeskripsiUtama, 'Deskripsi'),
          ),
          NeoInfoRow(
            icon: Icons.school,
            label: 'Program Studi',
            value: kProdi,
            color: NeoColors.green,
            onCopy: () => _salinKeClipboard(kProdi, 'Prodi'),
          ),
          NeoInfoRow(
            icon: Icons.account_balance,
            label: 'Universitas',
            value: kKampus,
            color: NeoColors.orange,
            onCopy: () => _salinKeClipboard(kKampus, 'Kampus'),
          ),
          NeoInfoRow(
            icon: Icons.email,
            label: 'Email',
            value: kEmail,
            color: NeoColors.purple,
            onCopy: () => _salinKeClipboard(kEmail, 'Email'),
          ),
          NeoInfoRow(
            icon: Icons.phone,
            label: 'WhatsApp/No. HP',
            value: kNoHp,
            color: NeoColors.green,
            onCopy: () => _salinKeClipboard(kNoHp, 'Nomor HP'),
          ),
          NeoInfoRow(
            icon: Icons.code,
            label: 'GitHub',
            value: kGithub,
            color: NeoColors.yellow,
            onCopy: () => _salinKeClipboard(kGithub, 'GitHub'),
          ),
          NeoInfoRow(
            icon: Icons.location_on,
            label: 'Domisili',
            value: kLokasi,
            color: NeoColors.cyan,
            onCopy: () => _salinKeClipboard(kLokasi, 'Domisili'),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------
  // 7. KEAHLIAN & TECH STACK (VIBE STACK)
  // -------------------------------------------------------------------
  Widget _buildSkillsSection() {
    return NeoBox(
      backgroundColor: NeoColors.cardBg,
      borderRadius: 16,
      borderWidth: 3.0,
      shadowOffset: const Offset(5, 5),
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: NeoColors.green,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: NeoColors.dark, width: 2),
                ),
                child: const Icon(
                  Icons.bolt_rounded,
                  color: NeoColors.dark,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'KEAHLIAN & VIBE STACK',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: NeoColors.dark,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              NeoSkillBadge(
                label: '⚡ Vibe Coding',
                color: NeoColors.yellow,
              ),
              NeoSkillBadge(
                label: '🤖 AI Prompt Engineering',
                color: NeoColors.pink,
              ),
              NeoSkillBadge(
                label: '📱 Flutter & Dart',
                color: NeoColors.cyan,
              ),
              NeoSkillBadge(
                label: '🎨 Neobrutalism UI',
                color: NeoColors.green,
              ),
              NeoSkillBadge(
                label: '🌐 Web Development',
                color: NeoColors.orange,
              ),
              NeoSkillBadge(
                label: '🐙 Git & GitHub',
                color: NeoColors.purple,
              ),
              NeoSkillBadge(
                label: '🚀 Rapid Prototyping',
                color: NeoColors.yellow,
              ),
              NeoSkillBadge(
                label: '🧠 Problem Solving',
                color: NeoColors.cyan,
              ),
              NeoSkillBadge(
                label: '🤝 Team Collaboration',
                color: NeoColors.green,
              ),
              NeoSkillBadge(
                label: '☕ High Caffeine Tolerance',
                color: NeoColors.pink,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------
  // 8. RIWAYAT PENDIDIKAN & PENGALAMAN
  // -------------------------------------------------------------------
  Widget _buildEducationSection() {
    return NeoBox(
      backgroundColor: NeoColors.cardBg,
      borderRadius: 16,
      borderWidth: 3.0,
      shadowOffset: const Offset(5, 5),
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: NeoColors.orange,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: NeoColors.dark, width: 2),
                ),
                child: const Icon(
                  Icons.school_rounded,
                  color: NeoColors.dark,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'PENDIDIKAN & PENGALAMAN',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: NeoColors.dark,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const NeoTimelineCard(
            period: '2024 - Sekarang',
            title: 'S1 Sistem Informasi',
            subtitle: 'Universitas Pesantren Tinggi Darul \'Ulum (UNIPDU)',
            desc:
                'Menempuh pendidikan sarjana semester 5 dengan fokus pada mobile programming, rekayasa perangkat lunak, dan AI workflow integration.',
            badgeColor: NeoColors.yellow,
          ),
          const SizedBox(height: 12),
          const NeoTimelineCard(
            period: '2023 - Sekarang',
            title: 'Komunitas Vibe Coding & Developer',
            subtitle: 'Eksplorasi AI & Flutter Specialist',
            desc:
                'Mengembangkan berbagai prototipe aplikasi cepat, memanfaatkan tool generative AI terkini untuk meningkatkan produktivitas coding.',
            badgeColor: NeoColors.cyan,
          ),
          const SizedBox(height: 12),
          const NeoTimelineCard(
            period: '2020 - 2023',
            title: 'Sekolah Menengah Atas / Madrasah Aliyah',
            subtitle: 'Jurusan IPA / Keagamaan',
            desc:
                'Membangun kedisiplinan belajar, ketekunan, dan dasar logika sains serta teknologi informasi.',
            badgeColor: NeoColors.green,
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------
  // 9. FOOTER STAMP
  // -------------------------------------------------------------------
  Widget _buildFooterStamp() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: NeoColors.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: NeoColors.dark, width: 2.5),
        boxShadow: const [
          BoxShadow(
            color: NeoColors.dark,
            offset: Offset(4, 4),
            blurRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            '⚡ BUILT WITH PASSION & VIBE CODING ⚡',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w900,
              color: NeoColors.dark,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '© 2026 $kNamaLengkap • NIM $kNim • UNIPDU',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// HELPER COMPONENT WIDGETS
// =====================================================================

class NeoStatCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final IconData icon;

  const NeoStatCard({
    super.key,
    required this.title,
    required this.value,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: NeoColors.dark, width: 2.5),
        boxShadow: const [
          BoxShadow(
            color: NeoColors.dark,
            offset: Offset(3.5, 3.5),
            blurRadius: 0,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                  color: NeoColors.dark,
                  letterSpacing: 0.8,
                ),
              ),
              Icon(icon, size: 16, color: NeoColors.dark),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: NeoColors.dark,
            ),
          ),
        ],
      ),
    );
  }
}

class NeoInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final VoidCallback onCopy;

  const NeoInfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    required this.onCopy,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: color.withAlpha(46),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: NeoColors.dark, width: 2),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: NeoColors.dark, width: 1.8),
            ),
            child: Icon(icon, size: 16, color: NeoColors.dark),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w900,
                color: NeoColors.dark,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: NeoColors.dark,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.copy, size: 16, color: NeoColors.dark),
            tooltip: 'Salin $label',
            visualDensity: VisualDensity.compact,
            onPressed: onCopy,
          ),
        ],
      ),
    );
  }
}

class NeoSkillBadge extends StatelessWidget {
  final String label;
  final Color color;

  const NeoSkillBadge({
    super.key,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: NeoColors.dark, width: 2.2),
        boxShadow: const [
          BoxShadow(
            color: NeoColors.dark,
            offset: Offset(2.5, 2.5),
            blurRadius: 0,
          ),
        ],
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w900,
          color: NeoColors.dark,
        ),
      ),
    );
  }
}

class NeoTimelineCard extends StatelessWidget {
  final String period;
  final String title;
  final String subtitle;
  final String desc;
  final Color badgeColor;

  const NeoTimelineCard({
    super.key,
    required this.period,
    required this.title,
    required this.subtitle,
    required this.desc,
    required this.badgeColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: NeoColors.cardBg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: NeoColors.dark, width: 2.2),
        boxShadow: const [
          BoxShadow(
            color: NeoColors.dark,
            offset: Offset(3, 3),
            blurRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                    color: NeoColors.dark,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: badgeColor,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: NeoColors.dark, width: 1.8),
                ),
                child: Text(
                  period,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                    color: NeoColors.dark,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            desc,
            style: const TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w500,
              color: NeoColors.dark,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}