import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const DigitexApp());

class DigitexApp extends StatelessWidget {
  const DigitexApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFD81B60)),
      useMaterial3: true,
      textTheme: GoogleFonts.poppinsTextTheme(),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFD81B60),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xFFE91E63),
        foregroundColor: Colors.white,
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DIGITEX',
      theme: theme,
      home: const HomeTabs(),
    );
  }
}

class HomeTabs extends StatefulWidget {
  const HomeTabs({super.key});
  @override
  State<HomeTabs> createState() => _HomeTabsState();
}

class _HomeTabsState extends State<HomeTabs> {
  int idx = 0;
  final pages = const [
    DiscoverPage(),
    MatesPage(),
    MutualPage(),
    ExPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DIGITEX'),
      ),
      body: Stack(
        children: [
          const HeartsBackground(),
          pages[idx],
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: idx,
        destinations: const [
          NavigationDestination(icon: Text('📱', style: TextStyle(fontSize: 22)), label: 'Discover'),
          NavigationDestination(icon: Text('👥', style: TextStyle(fontSize: 22)), label: 'Mates'),
          NavigationDestination(icon: Text('❣️', style: TextStyle(fontSize: 22)), label: 'Mutual'),
          NavigationDestination(icon: Text('X', style: TextStyle(fontSize: 22)), label: 'Ex'),
        ],
        onDestinationSelected: (i) => setState(() => idx = i),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: const Icon(Icons.favorite),
      ),
    );
  }
}

class HeartsBackground extends StatefulWidget {
  const HeartsBackground({super.key});
  @override
  State<HeartsBackground> createState() => _HeartsBackgroundState();
}

class _HeartsBackgroundState extends State<HeartsBackground> with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  final rand = Random();
  final hearts = List.generate(20, (_) => _Heart());

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: const Duration(seconds: 8))
      ..repeat();
    for (final h in hearts) {
      h.x = rand.nextDouble();
      h.size = 12 + rand.nextDouble() * 24;
      h.speed = 0.02 + rand.nextDouble() * 0.06;
      h.phase = rand.nextDouble() * 2 * pi;
      h.alpha = 0.25 + rand.nextDouble() * 0.35;
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {
        return CustomPaint(
          painter: _HeartsPainter(hearts: hearts, t: controller.value),
          size: Size.infinite,
        );
      },
    );
  }
}

class _Heart {
  double x = 0;      // 0..1
  double size = 16;  // px
  double speed = 0.03;
  double phase = 0;
  double alpha = 0.4;
}

class _HeartsPainter extends CustomPainter {
  final List<_Heart> hearts;
  final double t;
  _HeartsPainter({required this.hearts, required this.t});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    for (final h in hearts) {
      final y = size.height * (1 - ((t + h.phase) % 1.0));
      final x = size.width * h.x + sin((t + h.phase) * 2 * pi) * 20;
      paint.color = Colors.pink.withOpacity(h.alpha);
      _drawHeart(canvas, Offset(x, y), h.size, paint);
    }
  }

  void _drawHeart(Canvas canvas, Offset c, double s, Paint p) {
    final path = Path();
    path.moveTo(c.dx, c.dy + s * 0.25);
    path.cubicTo(c.dx + s * 0.5, c.dy - s * 0.35, c.dx + s, c.dy + s * 0.35, c.dx, c.dy + s);
    path.cubicTo(c.dx - s, c.dy + s * 0.35, c.dx - s * 0.5, c.dy - s * 0.35, c.dx, c.dy + s * 0.25);
    canvas.drawPath(path, p);
  }

  @override
  bool shouldRepaint(covariant _HeartsPainter oldDelegate) => true;
}

// Placeholder pages
class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Discover people within 100 km', style: TextStyle(fontSize: 18)),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: (){},
            icon: const Icon(Icons.search),
            label: const Text('Start Discovering'),
          ).animate().scale(),
        ],
      ),
    );
  }
}
class MatesPage extends StatelessWidget {
  const MatesPage({super.key});
  @override
  Widget build(BuildContext context) => const Center(child: Text('Mates'));
}
class MutualPage extends StatelessWidget {
  const MutualPage({super.key});
  @override
  Widget build(BuildContext context) => const Center(child: Text('Mutual'));
}
class ExPage extends StatelessWidget {
  const ExPage({super.key});
  @override
  Widget build(BuildContext context) => const Center(child: Text('Ex'));
}
