// main.dart
// Flutter single-file demo app: Profile page for Irbadh Asi-sibuny
// Farm-green palette, gold accents, subtle animations, mobile-optimized

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


void main() => runApp(SmkInformatikaProfileApp());

class SmkInformatikaProfileApp extends StatelessWidget {
  const SmkInformatikaProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Profile — Irbadh As-siribuny',
      theme: ThemeData(
        primaryColor: _Palette.farmGreen,
        scaffoldBackgroundColor: _Palette.background,
        fontFamily: 'Roboto',
        appBarTheme: AppBarTheme(
          backgroundColor: _Palette.farmGreen,
          elevation: 0,
        ),
      ),
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with SingleTickerProviderStateMixin {
  bool _showCelebration = true;
  late final AnimationController _leafController;

  @override
  void initState() {
    super.initState();
    _leafController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 6),
    )..repeat();

    // hide celebration automatically after a short time to keep focus on content
    Future.delayed(Duration(seconds: 5), () {
      if (mounted) setState(() => _showCelebration = false);
    });
  }

  @override 
  void dispose() {
    _leafController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.school, color: Colors.white),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                'Siswa — Profil',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold, // opsional biar lebih tegas
                  fontSize: 20, // opsional biar lebih besar
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.settings_outlined,
              color: Colors.white),
              onPressed: () {},
              tooltip: 'Pengaturan',
            )
          ],
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AnimatedOpacity(
                    duration: Duration(milliseconds: 600),
                    opacity: _showCelebration ? 1.0 : 0.0,
                    child: _CelebrationBanner(onClose: () => setState(() => _showCelebration = false)),
                  ),
                  SizedBox(height: 18),
                  _ProfileCard(),
                  SizedBox(height: 18),
                  _StatsRow(),
                  SizedBox(height: 18),
                  _AboutCard(),
                  SizedBox(height: 18),
                  _ContactCard(),
                  SizedBox(height: 36),
                  Center(child: Text('Kerja Pasti, Kuliah Bisa, Usaha Sukses', style: TextStyle(color: _Palette.muted)))
                ],
              ),
            ),
            // floating leaves animation
            Positioned.fill(
              child: IgnorePointer(
                child: AnimatedBuilder(
                  animation: _leafController,
                  builder: (_, __) {
                    return CustomPaint(painter: _LeavesPainter(progress: _leafController.value));
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// ---------- Widgets ----------

class _CelebrationBanner extends StatelessWidget {
  final VoidCallback onClose;
  const _CelebrationBanner({required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(12),
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Hai, Irbadh!', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                  SizedBox(height: 6),
                  Text('Jangan lupa semangat belajar, coding jalan terus… kopi jangan sampai habis', style: TextStyle(color: _Palette.muted)),
                ],
              ),
            ),
            SizedBox(width: 12),
            Container(
              decoration: BoxDecoration(
                color: _Palette.gold.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Column(
                children: [
                  Icon(Icons.celebration, color: _Palette.gold),
                  SizedBox(height: 4),
                  Text('Siswa berprestasi', style: TextStyle(color: _Palette.gold, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            IconButton(onPressed: onClose, icon: Icon(Icons.close_rounded))
          ],
        ),
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 44,
              backgroundImage: AssetImage('asset/img/irbadh_pp.jpg'),
              // replace the URL with a custom portrait/your photo
            ),
            SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Irbadh As-siribuny', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                  SizedBox(height: 6),
                  Text('Siswa — SMK Informatika Al-Irsyad', style: TextStyle(color: _Palette.muted, fontWeight: FontWeight.w600)),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined, size: 16, color: _Palette.muted),
                      SizedBox(width: 6),
                      Flexible(child: Text('Cirebon — Jawa Barat (Indonesia)', style: TextStyle(color: _Palette.muted))),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _Palette.farmGreen,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          foregroundColor: Colors.white, 
                        ),
                        onPressed: () {},
                        icon: Icon(Icons.edit_outlined ),
                        label: Text('Edit Profil'),
                      ),
                      SizedBox(width: 10),
                      OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: _Palette.muted,
                        ),
                        onPressed: () {},
                        icon: Icon(Icons.mail_outline),
                        label: Text('Hubungi'),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _StatsRow extends StatelessWidget {
  Widget _stat(String title, String val, IconData icon) => Expanded(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
          margin: EdgeInsets.only(right: 8),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)]),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(icon, size: 18, color: _Palette.farmGreen), SizedBox(width: 8), Text(val, style: TextStyle(fontWeight: FontWeight.w700))]),
              SizedBox(height: 6),
              Text(title, style: TextStyle(color: _Palette.muted, fontSize: 12))
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _stat('Kelas', 'XI', Icons.school_outlined),
        _stat('Jurusan', 'RPL', Icons.computer_outlined),
        _stat('Hobi', 'Gaming', Icons.videogame_asset_outlined),
      ],
    );
  }
}

class _AboutCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(14),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Tentang Pelajar', style: TextStyle(fontWeight: FontWeight.w700)),
          SizedBox(height: 8),
          Text('Irbadh adalah pelajar SMK Informatika Al Irsyad dengan jurusan PPLG'
                '(Pengembangan Perangkat Lunak dan Gim). Berfokus pada pengembangan aplikasi, '
                'coding, serta eksplorasi teknologi digital yang mendukung pertanian modern. '
                'Profil ini menampilkan ringkasan cepat aktivitas, keterampilan, dan projek '
                'yang sedang dikerjakan.', style: TextStyle(color: _Palette.muted)),
        ]),
      ),
    );
  }
}

class _ContactCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(14),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Kontak & Sosial', style: TextStyle(fontWeight: FontWeight.w700)),
          SizedBox(height: 8),
          Row(children: [Icon(Icons.phone_outlined), SizedBox(width: 10), Text('+62 831 5077 3059')]),
          SizedBox(height: 10),
          Row(children: [Icon(Icons.email_outlined), SizedBox(width: 10), Text('irbadhb@gmail.com')]),
          SizedBox(height: 12),
          Wrap(spacing: 10, children: [
            Chip(
              avatar: FaIcon(FontAwesomeIcons.instagram, size: 18, color: Colors.purple),
              label: Text('Instagram')
              ),
            Chip(
              avatar: FaIcon(FontAwesomeIcons.discord, size: 18, color: Colors.blue),
              label: Text('Discord')
              ),
            Chip(
              avatar: FaIcon(FontAwesomeIcons.github, size: 18, color: Colors.black),
              label: Text('Github')
              ),
          ])
        ]),
      ),
    );
  }
}

// ---------- Visuals / Helpers ----------

class _Palette {
  static const Color farmGreen = Color(0xFF2E7D32); // primary
  static const Color gold = Color(0xFFE6B13A);
  static const Color background = Color(0xFFF6FBF6);
  static const Color muted = Color(0xFF6B6B6B);
}

class _LeavesPainter extends CustomPainter {
  final double progress; // 0..1
  _LeavesPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = _Palette.farmGreen.withOpacity(0.03);
    // draw soft overlapping circles to simulate soft shapes/foliage
    double x = (size.width * (0.15 + 0.7 * progress));
    double y = size.height * 0.08;
    canvas.drawCircle(Offset(x, y), 120, paint);

    x = (size.width * (0.85 - 0.7 * progress));
    y = size.height * 0.9;
    canvas.drawCircle(Offset(x, y), 100, paint);

    // light gold sun-like highlight
    final goldPaint = Paint()..color = _Palette.gold.withOpacity(0.04);
    canvas.drawCircle(Offset(size.width * 0.85, size.height * 0.12), 60, goldPaint);
  }

  @override
  bool shouldRepaint(covariant _LeavesPainter oldDelegate) => oldDelegate.progress != progress;
}

// End of file
