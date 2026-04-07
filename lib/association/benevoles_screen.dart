import 'package:flutter/material.dart';



class ZadColors {
  static const Color darkNavy = Color(0xFF1A2B4A);
  static const Color teal = Color(0xFF2E7D7D);
  static const Color leafGreen = Color(0xFF2E7D32);
  static const Color background = Color(0xFFFFFFFF);
  static const Color labelGrey = Color(0xFF6B7A8D);
  static const Color cardBg = Color(0xFFF5F7FA);
  static const Color textDark = Color(0xFF1A2B4A);
}

class BenevolesScreen extends StatefulWidget {
  const BenevolesScreen({super.key});

  @override
  State<BenevolesScreen> createState() => _BenevolesScreenState();
}

class _BenevolesScreenState extends State<BenevolesScreen> {
  final _searchController = TextEditingController();
  String _search = '';
  String _filter = 'Tous';

  final List<String> _filters = ['Tous', 'Disponibles', 'En mission'];

  final List<Map<String, dynamic>> _benevoles = [
    {
      'nom': 'IHAB SLIMANI',
      'note': 4.9,
      'missions': 28,
      'transport': 'Voiture',
      'statut': 'En mission',
      'initiales': 'IS',
      'color': Color(0xFF1B5E20),
    },
    {
      'nom': 'WISAL AMARA',
      'note': 4.7,
      'missions': 15,
      'transport': 'Vélo',
      'statut': 'Inactif',
      'initiales': 'WA',
      'color': Color(0xFFE65100),
    },
    {
      'nom': 'ISHAQ FRED',
      'note': 4.8,
      'missions': 33,
      'transport': 'Voiture',
      'statut': 'Disponible',
      'initiales': 'IF',
      'color': Color(0xFF6A1B9A),
    },
    {
      'nom': 'LAMIA HADA',
      'note': 4.6,
      'missions': 8,
      'transport': 'Moto',
      'statut': 'En mission',
      'initiales': 'LH',
      'color': Color(0xFF00838F),
    },
    {
      'nom': 'AYA BERKAN',
      'note': 4.9,
      'missions': 41,
      'transport': 'Voiture',
      'statut': 'Disponible',
      'initiales': 'AB',
      'color': Color(0xFFF9A825),
    },
  ];

  List<Map<String, dynamic>> get _filtered {
    return _benevoles.where((b) {
      final matchSearch = b['nom'].toString().toLowerCase().contains(
        _search.toLowerCase(),
      );
      final matchFilter =
          _filter == 'Tous' ||
          (_filter == 'Disponibles' && b['statut'] == 'Disponible') ||
          (_filter == 'En mission' && b['statut'] == 'En mission');
      return matchSearch && matchFilter;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
                const Text(
                  'Bénévoles',
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
            child: Column(
              children: [
                // ── Search ────────────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (v) => setState(() => _search = v),
                    decoration: InputDecoration(
                      hintText: 'Rechercher un bénévole...',
                      hintStyle: TextStyle(
                        color: ZadColors.labelGrey,
                        fontSize: 14,
                      ),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: ZadColors.labelGrey,
                      ),
                      suffixIcon: _search.isNotEmpty
                          ? IconButton(
                              icon: const Icon(
                                Icons.close,
                                color: ZadColors.labelGrey,
                              ),
                              onPressed: () => setState(() {
                                _search = '';
                                _searchController.clear();
                              }),
                            )
                          : null,
                      filled: true,
                      fillColor: ZadColors.cardBg,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),

                // ── Filters ───────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _filters.map((f) {
                        final active = _filter == f;
                        return GestureDetector(
                          onTap: () => setState(() => _filter = f),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            margin: const EdgeInsets.only(right: 8),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 7,
                            ),
                            decoration: BoxDecoration(
                              color: active
                                  ? ZadColors.darkNavy
                                  : ZadColors.cardBg,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              f == 'Tous' ? 'Tous (${_benevoles.length})' : f,
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
                ),

                const SizedBox(height: 12),

                // ── List ──────────────────────────────
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _filtered.length,
                    itemBuilder: (context, index) {
                      return _BenevoleCard(data: _filtered[index]);
                    },
                  ),
                ),
              ],
            ),
          ),

          // ── Bottom Nav ────────────────────────────
          _BottomNav(active: 1),
        ],
      ),
    );
  }
}

class _BenevoleCard extends StatelessWidget {
  final Map<String, dynamic> data;
  const _BenevoleCard({required this.data});

  Color get _statutColor {
    switch (data['statut']) {
      case 'Disponible':
        return const Color(0xFF2E7D32);
      case 'En mission':
        return const Color(0xFF1565C0);
      case 'Inactif':
        return const Color(0xFF9E9E9E);
      default:
        return const Color(0xFF2E7D32);
    }
  }

  Color get _statutBg {
    switch (data['statut']) {
      case 'Disponible':
        return const Color(0xFFE8F5E9);
      case 'En mission':
        return const Color(0xFFE3F2FD);
      case 'Inactif':
        return const Color(0xFFF5F5F5);
      default:
        return const Color(0xFFE8F5E9);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: ZadColors.cardBg,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: data['color'],
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                data['initiales'],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data['nom'],
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: ZadColors.darkNavy,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(Icons.star, color: Color(0xFFFFB800), size: 13),
                    Text(
                      ' ${data['note']} · ${data['missions']} missions · ${data['transport']}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: ZadColors.labelGrey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Statut
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: _statutBg,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              data['statut'],
              style: TextStyle(
                fontSize: 11,
                color: _statutColor,
                fontWeight: FontWeight.w600,
              ),
            ),
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
            onTap: () {},
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
