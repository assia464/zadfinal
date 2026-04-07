// ============================================================
// 📄 lib/screens/benevole/dashboard_screen.dart
// ============================================================

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'map_screen.dart';
import 'missions_screen.dart';
import 'badges_screen.dart';
import 'notifications_screen.dart';
import 'profile_screen.dart';
import 'messages_screen.dart';

class BenevoleDashboardScreen extends StatefulWidget {
  const BenevoleDashboardScreen({super.key});

  @override
  State<BenevoleDashboardScreen> createState() =>
      _BenevoleDashboardScreenState();
}

class _BenevoleDashboardScreenState extends State<BenevoleDashboardScreen> {
  static const _green      = Color(0xFF4CAF50);
  static const _greenDark  = Color(0xFF388E3C);
  static const _greenLight = Color(0xFF81C784);
  static const _greenBg    = Color(0xFFF1F8E9);
  static const _greenPale  = Color(0xFFE8F5E9);
  static const _orange     = Color(0xFFFF8F00);
  static const _orangeBg   = Color(0xFFFFF3E0);
  static const _blue       = Color(0xFF1565C0);
  static const _red        = Color(0xFFD32F2F);
  static const _redBg      = Color(0xFFFFEBEE);
  static const _divider    = Color(0xFFEEEEEE);
  static const _subText    = Color(0xFF757575);
  static const _textDark   = Color(0xFF1B1B1B);

  int    _currentIndex = 0;
  String _activeFilter = 'Tous';

  final LatLng _myLocation = const LatLng(34.8828, 1.3167);

  // ── قائمة الدونات (قابلة للتعديل لإزالة المرفوضة) ──────
  late List<Map<String, dynamic>> _dons;

  @override
  void initState() {
    super.initState();
    _dons = [
      {
        'icon': '🍞',
        'title': 'Pain & Viennoiseries',
        'place': 'Boulangerie Atlas · Rue Ibn Badis',
        'qty': '30 unités',
        'dist': 1.2,
        'distLabel': '1,2 km',
        'time': '1h 30min',
        'urgent': false,
        'lat': 34.8850,
        'lng': 1.3180,
      },
      {
        'icon': '🍲',
        'title': 'Repas cuisinés',
        'place': 'Restaurant Le Zitoun · Centre-ville',
        'qty': '15 portions',
        'dist': 2.1,
        'distLabel': '2,1 km',
        'time': '35 min',
        'urgent': true,
        'lat': 34.8800,
        'lng': 1.3150,
      },
      {
        'icon': '🥦',
        'title': 'Légumes frais',
        'place': 'Marché Central · Boudghène',
        'qty': '8 kg',
        'dist': 3.4,
        'distLabel': '3,4 km',
        'time': '2h',
        'urgent': false,
        'lat': 34.8870,
        'lng': 1.3200,
      },
      {
        'icon': '🍰',
        'title': 'Pâtisseries',
        'place': 'Nour Sweets · Imama',
        'qty': '20 pièces',
        'dist': 0.8,
        'distLabel': '0,8 km',
        'time': '1h',
        'urgent': false,
        'lat': 34.8840,
        'lng': 1.3140,
      },
    ];
  }

  List<Map<String, dynamic>> get _filteredDons {
    switch (_activeFilter) {
      case '< 1km':
        return _dons.where((d) => (d['dist'] as double) < 1.0).toList();
      case '< 3km':
        return _dons.where((d) => (d['dist'] as double) < 3.0).toList();
      case '⚡ Urgent':
        return _dons.where((d) => d['urgent'] == true).toList();
      default:
        return _dons;
    }
  }

  // ── Dialog رفض الدون ────────────────────────────────────
  void _showRefuserDialog(Map<String, dynamic> don) {
    String? _selectedReason;
    final _autreController = TextEditingController();

    final reasons = [
      {'icon': '🕐', 'label': 'Pas disponible'},
      {'icon': '📍', 'label': 'Trop loin'},
      {'icon': '🚗', 'label': 'Pas de moyen de transport'},
      {'icon': '✏️', 'label': 'Autre'},
    ];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => StatefulBuilder(
        builder: (ctx, setModalState) => Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            top: 20,
            left: 20,
            right: 20,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40, height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Container(
                    width: 40, height: 40,
                    decoration: BoxDecoration(
                      color: _redBg,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text('❌', style: TextStyle(fontSize: 20)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Refuser ce don',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: _textDark,
                          ),
                        ),
                        Text(
                          don['title'],
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 11,
                            color: _subText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Pourquoi refusez-vous ?',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: _textDark,
                ),
              ),
              const SizedBox(height: 12),
              ...reasons.map((r) {
                final selected = _selectedReason == r['label'];
                return GestureDetector(
                  onTap: () => setModalState(
                      () => _selectedReason = r['label'] as String),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 12),
                    decoration: BoxDecoration(
                      color: selected ? _redBg : const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: selected ? _red : Colors.transparent,
                        width: 1.5,
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(r['icon']!,
                            style: const TextStyle(fontSize: 18)),
                        const SizedBox(width: 12),
                        Text(
                          r['label']!,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13,
                            fontWeight: selected
                                ? FontWeight.w600
                                : FontWeight.w400,
                            color: selected ? _red : _textDark,
                          ),
                        ),
                        const Spacer(),
                        if (selected)
                          const Icon(Icons.check_circle,
                              color: _red, size: 18),
                      ],
                    ),
                  ),
                );
              }),
              if (_selectedReason == 'Autre') ...[
                const SizedBox(height: 4),
                TextField(
                  controller: _autreController,
                  autofocus: true,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Précisez la raison...',
                    hintStyle: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13,
                      color: _subText,
                    ),
                    filled: true,
                    fillColor: const Color(0xFFF5F5F5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.all(14),
                  ),
                ),
              ],
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        height: 48,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Center(
                          child: Text(
                            'Annuler',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: _subText,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: _selectedReason == null
                          ? null
                          : () {
                              Navigator.pop(context);
                              setState(() => _dons.remove(don));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      '❌ Don refusé : ${don['title']}'),
                                  backgroundColor: _red,
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              );
                            },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        height: 48,
                        decoration: BoxDecoration(
                          color: _selectedReason != null
                              ? _red
                              : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: _selectedReason != null
                              ? [
                                  BoxShadow(
                                    color: _red.withOpacity(0.3),
                                    blurRadius: 8,
                                    offset: const Offset(0, 3),
                                  ),
                                ]
                              : null,
                        ),
                        child: const Center(
                          child: Text(
                            'Confirmer le refus',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBF9),
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  _buildMap(),
                  _buildFilterRow(),
                  _buildDonsList(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          _buildBottomNav(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [_greenDark, _green, _greenLight],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x554CAF50),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 12,
        bottom: 20,
        left: 18,
        right: 18,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text('🌿 ZAD',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: 1,
                    )),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(
                        builder: (_) => const BenevoleNotificationsScreen())),
                child: Stack(
                  children: [
                    Container(
                      width: 38, height: 38,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.notifications_outlined,
                          color: Colors.white, size: 20),
                    ),
                    Positioned(
                      top: 4, right: 4,
                      child: Container(
                        width: 12, height: 12,
                        decoration: BoxDecoration(
                          color: _orange,
                          shape: BoxShape.circle,
                          border: Border.all(color: _green, width: 1.5),
                        ),
                        child: const Center(
                          child: Text('2',
                              style: TextStyle(
                                fontSize: 7,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(
                        builder: (_) => const BenevoleProfileScreen())),
                child: Container(
                  width: 38, height: 38,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.person_outline,
                      color: Colors.white, size: 20),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(
                        builder: (_) => const BenevoleProfileScreen())),
                child: Container(
                  width: 44, height: 44,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.25),
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: Colors.white.withOpacity(0.5), width: 2),
                  ),
                  child: const Center(
                    child: Text('KM',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        )),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Bonjour 👋',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 11,
                          color: Colors.white70,
                        )),
                    Text('Karim Mansouri',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        )),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const BenevoleBadgesScreen(),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: Colors.white.withOpacity(0.3), width: 1),
                  ),
                  child: const Column(
                    children: [
                      Text('⭐ 245 pts',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 11,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          )),
                      Text('🥈 Engagé',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 10,
                            color: Colors.white70,
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMap() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      height: 175,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: _green.withOpacity(0.2),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            FlutterMap(
              options: MapOptions(
                initialCenter: _myLocation,
                initialZoom: 14.0,
                interactionOptions: const InteractionOptions(
                  flags: InteractiveFlag.none,
                ),
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.zad',
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: _myLocation,
                      width: 22, height: 22,
                      child: Container(
                        decoration: BoxDecoration(
                          color: _blue,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3),
                          boxShadow: [
                            BoxShadow(
                              color: _blue.withOpacity(0.4),
                              blurRadius: 10,
                              spreadRadius: 3,
                            ),
                          ],
                        ),
                      ),
                    ),
                    ..._dons.map((don) => Marker(
                          point: LatLng(don['lat'], don['lng']),
                          width: 36, height: 44,
                          child: Column(
                            children: [
                              Container(
                                width: 34, height: 34,
                                decoration: BoxDecoration(
                                  color: don['urgent'] ? _red : _green,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Colors.white, width: 2),
                                  boxShadow: [
                                    BoxShadow(
                                      color: (don['urgent'] ? _red : _green)
                                          .withOpacity(0.4),
                                      blurRadius: 8,
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(don['icon'],
                                      style:
                                          const TextStyle(fontSize: 16)),
                                ),
                              ),
                              Container(
                                  width: 2, height: 8,
                                  color: don['urgent'] ? _red : _green),
                            ],
                          ),
                        )),
                  ],
                ),
              ],
            ),
            Positioned(
              bottom: 0, left: 0, right: 0,
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.15),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 10, right: 12,
              child: GestureDetector(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(
                        builder: (_) => const BenevoleMapScreen())),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.12),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.map_outlined, color: _green, size: 14),
                      SizedBox(width: 4),
                      Text('Voir tout',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: _green,
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterRow() {
    final filters = ['Tous', '< 1km', '< 3km', '⚡ Urgent'];
    return Padding(
      padding: const EdgeInsets.only(top: 14),
      child: SizedBox(
        height: 38,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: filters.length,
          itemBuilder: (_, i) {
            final active = _activeFilter == filters[i];
            return GestureDetector(
              onTap: () => setState(() => _activeFilter = filters[i]),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 7),
                decoration: BoxDecoration(
                  gradient: active
                      ? const LinearGradient(
                          colors: [_greenDark, _green],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : null,
                  color: active ? null : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: active ? _green : _divider,
                    width: 1.5,
                  ),
                  boxShadow: active
                      ? [BoxShadow(
                          color: _green.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        )]
                      : [BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 4,
                        )],
                ),
                child: Text(filters[i],
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: active ? Colors.white : _subText,
                    )),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDonsList() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
          child: Row(
            children: [
              Container(
                width: 4, height: 18,
                decoration: BoxDecoration(
                  color: _green,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 8),
              const Text('Dons à proximité',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: _textDark,
                  )),
              const Spacer(),
              Text('${_filteredDons.length} résultat(s)',
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 10,
                    color: _subText,
                  )),
            ],
          ),
        ),
        if (_filteredDons.isEmpty)
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: _greenPale,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: _green.withOpacity(0.2)),
            ),
            child: const Column(
              children: [
                Text('🔍', style: TextStyle(fontSize: 36)),
                SizedBox(height: 10),
                Text('Aucun don dans ce rayon',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: _greenDark,
                    )),
                SizedBox(height: 4),
                Text('Essayez un filtre plus large',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 11,
                      color: _subText,
                    )),
              ],
            ),
          )
        else
          ..._filteredDons.map((don) => _buildDonCard(don)),
      ],
    );
  }

  Widget _buildDonCard(Map<String, dynamic> don) {
    final isUrgent = don['urgent'] as bool;
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: isUrgent
                ? _red.withOpacity(0.1)
                : _green.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 4,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isUrgent
                    ? [_red, Colors.redAccent]
                    : [_greenDark, _green],
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
            child: Row(
              children: [
                Container(
                  width: 54, height: 54,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: isUrgent
                          ? [_redBg, const Color(0xFFFFCDD2)]
                          : [_greenPale, _greenBg],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Center(
                    child: Text(don['icon'],
                        style: const TextStyle(fontSize: 26)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(don['title'],
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: _textDark,
                                )),
                          ),
                          if (isUrgent) ...[
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 7, vertical: 2),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFFD32F2F),
                                    Color(0xFFE53935),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(7),
                              ),
                              child: const Text('⚡ URGENT',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 8,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  )),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 3),
                      Text(don['place'],
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 10,
                            color: _subText,
                          )),
                      const SizedBox(height: 1),
                      Text(don['qty'],
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 10,
                            color: isUrgent ? _red : _green,
                            fontWeight: FontWeight.w500,
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            padding: const EdgeInsets.symmetric(
                horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFF9FBF9),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    _chip('📍 ${don['distLabel']}', _greenPale, _greenDark),
                    const SizedBox(width: 6),
                    _chip(
                      '⏰ ${don['time']}',
                      isUrgent ? _redBg : _orangeBg,
                      isUrgent ? _red : _orange,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _showRefuserDialog(don),
                        child: Container(
                          height: 38,
                          decoration: BoxDecoration(
                            color: _redBg,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: _red.withOpacity(0.3), width: 1),
                          ),
                          child: const Center(
                            child: Text(
                              '❌ Refuser',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: _red,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  '✅ Mission acceptée : ${don['title']}'),
                              backgroundColor: _green,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          );
                        },
                        child: Container(
                          height: 38,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: isUrgent
                                  ? [_red, Colors.redAccent]
                                  : [_greenDark, _green],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: (isUrgent ? _red : _green)
                                    .withOpacity(0.35),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              isUrgent ? '🚀 Urgent' : '✅ Accepter',
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ✅ Bottom Navigation Bar المعدل
  Widget _buildBottomNav() {
    final items = [
      {'icon': Icons.home_rounded,        'label': 'Accueil'},
      {'icon': Icons.map_rounded,          'label': 'Carte'},
      {'icon': Icons.assignment_rounded,   'label': 'Missions'},
      {'icon': Icons.emoji_events_rounded, 'label': 'Badges'},
      {'icon': Icons.chat_bubble_rounded,  'label': 'Messages'},
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).padding.bottom + 8,
        top: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (i) {
          final active = _currentIndex == i;
          return GestureDetector(
            onTap: () async {
              // تحديث المؤشر أولاً
              setState(() {
                _currentIndex = i;
              });
              
              // الانتقال إلى الصفحة المطلوبة
              if (i == 1) {
                await Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (_) => const BenevoleMapScreen())
                );
                // بعد العودة، تأكد من أن المؤشر لا يزال صحيحاً
                setState(() {});
              } else if (i == 2) {
                await Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (_) => const BenevoleMissionsScreen())
                );
                setState(() {});
              } else if (i == 3) {
                await Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (_) => const BenevoleBadgesScreen())
                );
                setState(() {});
              } else if (i == 4) {
                await Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (_) => const BenevoleMessagesScreen())
                );
                setState(() {});
              }
              // i == 0 هي الصفحة الحالية، لا حاجة للانتقال
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(
                  horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: active
                    ? _green.withOpacity(0.12)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    items[i]['icon'] as IconData,
                    color: active ? _green : const Color(0xFFBDBDBD),
                    size: 24,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    items[i]['label'] as String,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 9,
                      fontWeight: active
                          ? FontWeight.w700
                          : FontWeight.w400,
                      color: active ? _green : const Color(0xFFBDBDBD),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _chip(String label, Color bg, Color fg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(label,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 9,
            fontWeight: FontWeight.w600,
            color: fg,
          )),
    );
  }
}