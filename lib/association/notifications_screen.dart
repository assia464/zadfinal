import 'package:flutter/material.dart';

class ZadColors {
  static const Color darkNavy = Color(0xFF1A2B4A);
  static const Color teal = Color(0xFF2E7D7D);
  static const Color leafGreen = Color(0xFF2E7D32);
  static const Color background = Color(0xFFFFFFFF);
  static const Color labelGrey = Color(0xFF6B7A8D);
  static const Color cardBg = Color(0xFFF5F7FA);
}

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  String _filter = 'Tous';
  final List<String> _filters = [
    'Tous',
    'Non lus',
    'Dons',
    'Missions',
    'Système',
  ];

  final List<Map<String, dynamic>> _notifs = [
    {
      'titre': 'Nouveau don urgent disponible !',
      'desc': 'Restaurant Al Zitouni · 15 portions · expire dans 35 min',
      'time': 'il y a 2 min',
      'lu': false,
      'type': 'Dons',
      'icon': Icons.restaurant,
      'color': Color(0xFFE53935),
    },
    {
      'titre': 'Karim M. a accepté la mission',
      'desc': 'Pain · Boulangerie Atlas · ETA 15 min',
      'time': 'il y a 15 min',
      'lu': false,
      'type': 'Missions',
      'icon': Icons.directions_bike,
      'color': Color(0xFF1565C0),
    },
    {
      'titre': 'Évaluez votre bénévole',
      'desc': 'Mission complétée il y a 1h · Karim M.',
      'time': 'il y a 1h',
      'lu': false,
      'type': 'Missions',
      'icon': Icons.star_outline,
      'color': Color(0xFFFFB800),
    },
    {
      'titre': 'Don livré avec succès',
      'desc': 'Hier 14h35',
      'time': 'Hier',
      'lu': true,
      'type': 'Dons',
      'icon': Icons.check_circle_outline,
      'color': Color(0xFF2E7D32),
    },
    {
      'titre': 'Don expiré non réservé',
      'desc': 'Hier 10h00',
      'time': 'Hier',
      'lu': true,
      'type': 'Dons',
      'icon': Icons.timer_off_outlined,
      'color': Color(0xFF9E9E9E),
    },
    {
      'titre': 'Rapport mensuel disponible',
      'desc': 'il y a 3 jours',
      'time': 'il y a 3 jours',
      'lu': true,
      'type': 'Système',
      'icon': Icons.bar_chart,
      'color': Color(0xFF6A1B9A),
    },
  ];

  List<Map<String, dynamic>> get _filtered {
    if (_filter == 'Tous') return _notifs;
    if (_filter == 'Non lus') return _notifs.where((n) => !n['lu']).toList();
    return _notifs.where((n) => n['type'] == _filter).toList();
  }

  List<Map<String, dynamic>> get _nonLus =>
      _filtered.where((n) => !n['lu']).toList();

  List<Map<String, dynamic>> get _lus =>
      _filtered.where((n) => n['lu']).toList();

  @override
  Widget build(BuildContext context) {
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
                const Expanded(
                  child: Text(
                    'Notifications',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => setState(() {
                    for (var n in _notifs) n['lu'] = true;
                  }),
                  child: const Text(
                    'Tout lire',
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: Column(
              children: [
                // ── Filters ───────────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _filters.map((f) {
                        final active = _filter == f;
                        final nonLusCount = f == 'Non lus'
                            ? _notifs.where((n) => !n['lu']).length
                            : 0;
                        return GestureDetector(
                          onTap: () => setState(() => _filter = f),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            margin: const EdgeInsets.only(right: 8),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 7,
                            ),
                            decoration: BoxDecoration(
                              color: active
                                  ? ZadColors.darkNavy
                                  : ZadColors.cardBg,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              nonLusCount > 0 ? '$f ($nonLusCount)' : f,
                              style: TextStyle(
                                color: active
                                    ? Colors.white
                                    : ZadColors.labelGrey,
                                fontSize: 12,
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
                ),

                // ── List ──────────────────────────────
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: [
                      if (_nonLus.isNotEmpty) ...[
                        const Padding(
                          padding: EdgeInsets.only(bottom: 8),
                          child: Text(
                            'NON LUS',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: ZadColors.labelGrey,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ),
                        ..._nonLus.map(
                          (n) => _NotifCard(
                            data: n,
                            onTap: () => setState(() => n['lu'] = true),
                          ),
                        ),
                      ],
                      if (_lus.isNotEmpty) ...[
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            'DÉJÀ LUS',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: ZadColors.labelGrey,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ),
                        ..._lus.map((n) => _NotifCard(data: n, onTap: () {})),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ── Bottom Nav ────────────────────────────
          _BottomNav(active: 0),
        ],
      ),
    );
  }
}

class _NotifCard extends StatelessWidget {
  final Map<String, dynamic> data;
  final VoidCallback onTap;
  const _NotifCard({required this.data, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: data['lu'] ? ZadColors.cardBg : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: data['lu']
              ? null
              : Border.all(color: const Color(0xFFE8F5E9), width: 1),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: (data['color'] as Color).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                data['icon'] as IconData,
                color: data['color'] as Color,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data['titre'],
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: data['lu']
                          ? FontWeight.w500
                          : FontWeight.w700,
                      color: ZadColors.darkNavy,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    data['desc'],
                    style: const TextStyle(
                      fontSize: 12,
                      color: ZadColors.labelGrey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    data['time'],
                    style: const TextStyle(
                      fontSize: 11,
                      color: ZadColors.labelGrey,
                    ),
                  ),
                ],
              ),
            ),
            if (!data['lu'])
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: ZadColors.leafGreen,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
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
