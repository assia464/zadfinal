import 'package:flutter/material.dart';
import 'ajouter_beneficiare_screen.dart';
import 'don_details_screen.dart';
import 'evaluer_benevole_screen.dart';
import 'dons_disponibles_screen.dart';
import 'beneficiaires_screen.dart';
import 'profil_screen.dart';
import 'chat_screen.dart';

class ZadColors {
  static const Color darkNavy = Color(0xFF1A2B4A);
  static const Color teal = Color(0xFF2E7D7D);
  static const Color leafGreen = Color(0xFF2E7D32);
  static const Color background = Color(0xFFFFFFFF);
  static const Color labelGrey = Color(0xFF6B7A8D);
  static const Color cardBg = Color(0xFFF5F7FA);
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex =
      0; // 0: Home, 1: Bénéficiaires, 2: Dons, 3: Chat, 4: Profil

  // قائمة الشاشات - نستخدم الشاشات الأصلية فقط
  static final List<Widget> _screens = [
    const HomeContent(), // المحتوى الرئيسي
    const BeneficiairesScreen(), // شاشة المستفيدين الأصلية
    const DonsDisponiblesScreen(), // شاشة التبرعات الأصلية
    const ChatScreen(), // شاشة الشات
    const ProfilScreen(), // شاشة الملف الشخصي
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ZadColors.background,
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: ZadColors.leafGreen,
          unselectedItemColor: ZadColors.labelGrey,
          selectedLabelStyle: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: const TextStyle(fontSize: 11),
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people_outline),
              activeIcon: Icon(Icons.people),
              label: 'Bénéficiaires',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.volunteer_activism_outlined),
              activeIcon: Icon(Icons.volunteer_activism),
              label: 'Dons',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_outlined),
              activeIcon: Icon(Icons.chat),
              label: 'Chat',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────
//  محتوى الصفحة الرئيسية (Home) فقط - بدون تكرار
// ─────────────────────────────────────────

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: ZadColors.leafGreen,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  // دالة للتنقل بين شاشات BottomNavigationBar
  void _navigateToTab(BuildContext context, int index) {
    final homeScreenState = context.findAncestorStateOfType<_HomeScreenState>();
    if (homeScreenState != null) {
      homeScreenState._onItemTapped(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ZadColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 52, 20, 24),
              decoration: const BoxDecoration(
                color: Color(0xFF1B5E20),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(28),
                  bottomRight: Radius.circular(28),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: -10,
                    top: -10,
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ZadColors.leafGreen.withValues(alpha: 0.25),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 40,
                    top: -20,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ZadColors.teal.withValues(alpha: 0.20),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'ZAD',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1,
                            ),
                          ),
                          GestureDetector(
                            onTap: () =>
                                Navigator.pushNamed(context, '/notifications'),
                            child: Badge(
                              label: const Text(
                                '3',
                                style: TextStyle(fontSize: 10),
                              ),
                              backgroundColor: Colors.red,
                              child: Icon(
                                Icons.notifications_outlined,
                                color: Colors.white.withValues(alpha: 0.9),
                                size: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      const Text(
                        'Bienvenue 🌿',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Text(
                        'Association El Fath',
                        style: TextStyle(
                          color: Color(0xFFB0BEC5),
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 14),
                      GestureDetector(
                        onTap: () =>
                            Navigator.pushNamed(context, '/statistiques'),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.15),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Ce mois-ci : 48 kg de nourriture sauvée !',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Icon(
                                Icons.chevron_right,
                                color: Colors.white.withValues(alpha: 0.7),
                                size: 18,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      GestureDetector(
                        onTap: () =>
                            Navigator.pushNamed(context, '/statistiques'),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _HeaderStat(value: '23', label: 'Dons reçus'),
                            _Divider(),
                            _HeaderStat(value: '156', label: 'Repas'),
                            _Divider(),
                            _HeaderStat(value: '45', label: 'Bénéficiaires'),
                            _Divider(),
                            _HeaderStat(value: '12', label: 'Bénévoles'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Don urgent
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF3E0),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: const Color(0xFFFF9800),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Don urgent disponible !',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFFE65100),
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    'Restaurant Al Zitouni · 15 portions · expire dans 48 min',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Color(0xFF795548),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const DonDetailsScreen(),
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFF9800),
                                foregroundColor: Colors.white,
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 8,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: const Text(
                                'Voir',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0.0, end: 0.35),
                          duration: const Duration(milliseconds: 800),
                          builder: (context, value, _) => ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: value,
                              backgroundColor: const Color(0xFFFFCC80),
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                Color(0xFFFF9800),
                              ),
                              minHeight: 5,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          '48 min restantes',
                          style: TextStyle(
                            fontSize: 10,
                            color: Color(0xFF795548),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Mission en cours',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: ZadColors.darkNavy,
                    ),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () => _showSnackbar(
                      context,
                      'Mission en cours: Assia HASNAOUI - Boulangerie Atlas',
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: ZadColors.cardBg,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: const BoxDecoration(
                              color: Color(0xFFE8F5E9),
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Text(
                                'AH',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: ZadColors.leafGreen,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Assia HASNAOUI',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: ZadColors.darkNavy,
                                  ),
                                ),
                                Text(
                                  'En route · Boulangerie Atlas',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: ZadColors.labelGrey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE8F5E9),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'En route',
                              style: TextStyle(
                                fontSize: 11,
                                color: ZadColors.leafGreen,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Actions Rapides',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: ZadColors.darkNavy,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _ActionButton(
                    icon: Icons.add_circle_outline,
                    label: 'Publier un Besoin',
                    iconBg: const Color(0xFFE3F2FD),
                    iconColor: const Color(0xFF1565C0),
                    onTap: () =>
                        Navigator.pushNamed(context, '/publier_besoin'),
                  ),
                  _ActionButton(
                    icon: Icons.person_add_outlined,
                    label: 'Ajouter un bénéficiaire',
                    iconBg: const Color(0xFFE8F5E9),
                    iconColor: ZadColors.leafGreen,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const AjouterBeneficiaireScreen(),
                      ),
                    ),
                  ),
                  _ActionButton(
                    icon: Icons.volunteer_activism,
                    label: 'Dons reçus',
                    iconBg: const Color(0xFFFFF3E0),
                    iconColor: const Color(0xFFE65100),
                    onTap: () =>
                        _navigateToTab(context, 2), // ينتقل إلى تبويب Dons
                  ),
                  _ActionButton(
                    icon: Icons.directions_bike,
                    label: 'Liste des bénévoles',
                    iconBg: const Color(0xFFE3F2FD),
                    iconColor: const Color(0xFF1565C0),
                    onTap: () => Navigator.pushNamed(context, '/benevoles'),
                  ),
                  _ActionButton(
                    icon: Icons.people_outline,
                    label: 'Liste des bénéficiaires',
                    iconBg: const Color(0xFFF3E5F5),
                    iconColor: const Color(0xFF6A1B9A),
                    onTap: () => _navigateToTab(
                      context,
                      1,
                    ), // ينتقل إلى تبويب Bénéficiaires
                  ),
                  _ActionButton(
                    icon: Icons.star_rate_outlined,
                    label: 'Évaluer un bénévole',
                    iconBg: const Color(0xFFFFF8E1),
                    iconColor: const Color(0xFFFFB300),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const EvaluerBenevoleScreen(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Dernières notifications',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: ZadColors.darkNavy,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _NotifItem(
                    icon: Icons.restaurant,
                    text: 'Nouveau don de restaurant Al Zitouni',
                    time: 'il y a 5 min',
                    onTap: () => _showSnackbar(
                      context,
                      '📦 Nouveau don disponible: Restaurant Al Zitouni - 15 portions',
                    ),
                  ),
                  _NotifItem(
                    icon: Icons.directions_bike,
                    text: 'Bénévole Karim accepté la mission',
                    time: 'il y a 18 min',
                    onTap: () => _showSnackbar(
                      context,
                      '🚴 Bénévole Karim a accepté la mission',
                    ),
                  ),
                  _NotifItem(
                    icon: Icons.check_circle_outline,
                    text: 'Mission complétée avec succès',
                    time: 'il y a 1h',
                    onTap: () => _showSnackbar(
                      context,
                      '✅ Mission complétée avec succès!',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────
//  باقي الـ WIDGETS
// ─────────────────────────────────────────

class _NotifItem extends StatelessWidget {
  final IconData icon;
  final String text, time;
  final VoidCallback onTap;
  const _NotifItem({
    required this.icon,
    required this.text,
    required this.time,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: ZadColors.cardBg,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: ZadColors.leafGreen, size: 18),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(fontSize: 12, color: ZadColors.darkNavy),
              ),
            ),
            Text(
              time,
              style: TextStyle(
                fontSize: 10,
                color: ZadColors.labelGrey.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderStat extends StatelessWidget {
  final String value, label;
  const _HeaderStat({required this.value, required this.label});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
    width: 1,
    height: 30,
    color: Colors.white.withValues(alpha: 0.2),
  );
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color iconBg, iconColor;
  final VoidCallback onTap;
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.iconBg,
    required this.iconColor,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: ZadColors.cardBg,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: iconColor, size: 18),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  color: ZadColors.darkNavy,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: ZadColors.labelGrey,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
