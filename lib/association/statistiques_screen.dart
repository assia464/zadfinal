import 'package:flutter/material.dart';

class ZadColors {
  static const Color darkNavy = Color(0xFF1A2B4A);
  static const Color teal = Color(0xFF2E7D7D);
  static const Color leafGreen = Color(0xFF2E7D32);
  static const Color background = Color(0xFFFFFFFF);
  static const Color labelGrey = Color(0xFF6B7A8D);
  static const Color cardBg = Color(0xFFF5F7FA);
}

class StatistiquesScreen extends StatefulWidget {
  const StatistiquesScreen({super.key});

  @override
  State<StatistiquesScreen> createState() => _StatistiquesScreenState();
}

class _StatistiquesScreenState extends State<StatistiquesScreen> {
  String _period = '3 mois';
  final List<String> _periods = ['7 jours', 'Ce mois', '3 mois', 'Année'];

  final List<Map<String, dynamic>> _weekData = [
    {'label': 'S1', 'value': 3},
    {'label': 'S2', 'value': 5},
    {'label': 'S3', 'value': 2},
    {'label': 'S4', 'value': 7},
    {'label': 'S5', 'value': 4},
    {'label': 'S6', 'value': 8},
    {'label': 'S7', 'value': 6},
    {'label': 'S8', 'value': 9},
    {'label': 'S9', 'value': 7},
    {'label': 'S10', 'value': 11},
  ];

  @override
  Widget build(BuildContext context) {
    final maxVal = _weekData
        .map((e) => e['value'] as int)
        .reduce((a, b) => a > b ? a : b);

    return Scaffold(
      backgroundColor: ZadColors.background,
      body: Column(
        children: [
          // ── Header ────────────────────────────────
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 52, 20, 20),
            decoration: const BoxDecoration(
              color: Color(0xFF1B5E20),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Statistiques',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Period filters ────────────────
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _periods.map((p) {
                        final active = _period == p;
                        return GestureDetector(
                          onTap: () => setState(() => _period = p),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            margin: const EdgeInsets.only(right: 8),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: active
                                  ? ZadColors.leafGreen
                                  : ZadColors.cardBg,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              p,
                              style: TextStyle(
                                color: active
                                    ? Colors.white
                                    : ZadColors.labelGrey,
                                fontSize: 13,
                                fontWeight: active
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // ── Impact total ──────────────────
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: ZadColors.leafGreen,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'IMPACT TOTAL CE MOIS',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.8,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          '48 kg',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 36,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          'de nourriture sauvée',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _ImpactStat(value: '23', label: 'Dons reçus'),
                            _ImpactStat(value: '156', label: 'Aides données'),
                            _ImpactStat(value: '45', label: 'Bénéficiaires'),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ── Bar chart ─────────────────────
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: ZadColors.cardBg,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Dons reçus par semaine',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: ZadColors.darkNavy,
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 120,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: _weekData.map((d) {
                              final ratio = d['value'] / maxVal;
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    width: 20,
                                    height: (100 * ratio).toDouble(),
                                    decoration: BoxDecoration(
                                      color: d['value'] == maxVal
                                          ? ZadColors.leafGreen
                                          : ZadColors.leafGreen.withOpacity(
                                              0.4,
                                            ),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    d['label'],
                                    style: const TextStyle(
                                      fontSize: 9,
                                      color: ZadColors.labelGrey,
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ── Types de dons ─────────────────
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: ZadColors.cardBg,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Types de dons reçus',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: ZadColors.darkNavy,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _TypeBar(
                          label: 'Pain',
                          percent: 0.58,
                          color: const Color(0xFF2E7D32),
                        ),
                        const SizedBox(height: 10),
                        _TypeBar(
                          label: 'Repas',
                          percent: 0.76,
                          color: const Color(0xFF1565C0),
                        ),
                        const SizedBox(height: 10),
                        _TypeBar(
                          label: 'Alimentaire',
                          percent: 0.24,
                          color: const Color(0xFFE65100),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ── Top bénévoles ─────────────────
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: ZadColors.cardBg,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Top bénévoles ce mois',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: ZadColors.darkNavy,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _TopBenevole(rang: 1, nom: 'IHAB SLIMANI', missions: 8),
                        _TopBenevole(rang: 2, nom: 'LAMIA HADA', missions: 6),
                        _TopBenevole(rang: 3, nom: 'AYA BERKAN', missions: 5),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),

          // ── Bottom Nav ────────────────────────────
          _BottomNav(active: 0),
        ],
      ),
    );
  }
}

class _ImpactStat extends StatelessWidget {
  final String value;
  final String label;
  const _ImpactStat({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
        Text(
          label,
          style: TextStyle(color: Colors.white.withOpacity(0.75), fontSize: 11),
        ),
      ],
    );
  }
}

class _TypeBar extends StatelessWidget {
  final String label;
  final double percent;
  final Color color;
  const _TypeBar({
    required this.label,
    required this.percent,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: const TextStyle(fontSize: 12, color: ZadColors.darkNavy),
          ),
        ),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: percent,
              backgroundColor: Colors.white,
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 10,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '${(percent * 100).toInt()}%',
          style: const TextStyle(fontSize: 12, color: ZadColors.labelGrey),
        ),
      ],
    );
  }
}

class _TopBenevole extends StatelessWidget {
  final int rang;
  final String nom;
  final int missions;
  const _TopBenevole({
    required this.rang,
    required this.nom,
    required this.missions,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: rang == 1 ? const Color(0xFFFFB800) : ZadColors.cardBg,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$rang',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: rang == 1 ? Colors.white : ZadColors.labelGrey,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              nom,
              style: const TextStyle(
                fontSize: 13,
                color: ZadColors.darkNavy,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            '$missions missions',
            style: const TextStyle(fontSize: 12, color: ZadColors.labelGrey),
          ),
        ],
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  final int active;
  const _BottomNav({required this.active});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavItem(
            icon: Icons.home_outlined,
            label: 'Home',
            active: active == 0,
            onTap: () => Navigator.pushNamed(context, '/home'),
          ),
          _NavItem(
            icon: Icons.people_outline,
            label: 'Bénéficiaires',
            active: active == 1,
            onTap: () => Navigator.pushNamed(context, '/beneficiaires'),
          ),
          _NavItem(
            icon: Icons.volunteer_activism,
            label: 'Dons',
            active: active == 2,
            onTap: () => Navigator.pushNamed(context, '/dons'),
          ),
          _NavItem(
            icon: Icons.chat_outlined,
            label: 'Chat',
            active: active == 3,
            onTap: () => Navigator.pushNamed(context, '/chat'),
          ),
          _NavItem(
            icon: Icons.person_outline,
            label: 'Profil',
            active: active == 4,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;
  const _NavItem({
    required this.icon,
    required this.label,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: active ? ZadColors.leafGreen : ZadColors.labelGrey,
            size: 22,
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: active ? ZadColors.leafGreen : ZadColors.labelGrey,
              fontWeight: active ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
