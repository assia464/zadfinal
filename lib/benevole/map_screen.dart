// ============================================================
// 📄 lib/screens/benevole/map_screen.dart
// ============================================================

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class BenevoleMapScreen extends StatefulWidget {
  const BenevoleMapScreen({super.key});

  @override
  State<BenevoleMapScreen> createState() => _BenevoleMapScreenState();
}

class _BenevoleMapScreenState extends State<BenevoleMapScreen> {
  // ── Colors ───────────────────────────────────────────────
  static const _green    = Color(0xFF2E7D32);
  static const _greenBg  = Color(0xFFF1F8E9);
  static const _orange   = Color(0xFFFF8F00);
  static const _red      = Color(0xFFD32F2F);
  static const _blue     = Color(0xFF1565C0);
  static const _subText  = Color(0xFF757575);
  static const _textDark = Color(0xFF1B1B1B);

  // ── Controllers ──────────────────────────────────────────
  final MapController _mapController = MapController();
  final TextEditingController _searchController = TextEditingController();

  // ── State ────────────────────────────────────────────────
  final LatLng _myLocation = const LatLng(34.8828, 1.3167);
  Map<String, dynamic>? _selectedDon;
  String _activeFilter = 'Tous';
  String _searchQuery = '';
  bool _searchFocused = false;

  // ── Tous les dons ────────────────────────────────────────
  final List<Map<String, dynamic>> _allDons = [
    {
      'icon': '🍞',
      'title': 'Pain & Viennoiseries',
      'place': 'Boulangerie Atlas',
      'qty': '30 unités',
      'dist': '1,2 km',
      'distKm': 1.2,
      'time': '1h 30min',
      'urgent': false,
      'lat': 34.8850,
      'lng': 1.3180,
    },
    {
      'icon': '🍲',
      'title': 'Repas cuisinés',
      'place': 'Restaurant Le Zitoun',
      'qty': '15 portions',
      'dist': '2,1 km',
      'distKm': 2.1,
      'time': '35 min',
      'urgent': true,
      'lat': 34.8800,
      'lng': 1.3150,
    },
    {
      'icon': '🥦',
      'title': 'Légumes frais',
      'place': 'Marché Central',
      'qty': '8 kg',
      'dist': '3,4 km',
      'distKm': 3.4,
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
      'dist': '1,8 km',
      'distKm': 1.8,
      'time': '1h',
      'urgent': false,
      'lat': 34.8840,
      'lng': 1.3140,
    },
  ];

  // ── Dons filtrés ─────────────────────────────────────────
  List<Map<String, dynamic>> get _filteredDons {
    return _allDons.where((don) {
      // Filtre par distance/urgent
      final passFilter = switch (_activeFilter) {
        '< 1km'    => (don['distKm'] as double) < 1.0,
        '< 3km'    => (don['distKm'] as double) < 3.0,
        '⚡ Urgent' => don['urgent'] == true,
        _          => true,
      };

      // Filtre par recherche
      final query = _searchQuery.toLowerCase().trim();
      final passSearch = query.isEmpty ||
          (don['title'] as String).toLowerCase().contains(query) ||
          (don['place'] as String).toLowerCase().contains(query);

      return passFilter && passSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final dons = _filteredDons;

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: Stack(
        children: [
          // ── Carte plein écran ──────────────────────────
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _myLocation,
              initialZoom: 14.5,
              onTap: (_, __) => setState(() {
                _selectedDon = null;
                _searchFocused = false;
                FocusScope.of(context).unfocus();
              }),
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.zad',
              ),
              MarkerLayer(
                markers: [
                  // Ma position
                  Marker(
                    point: _myLocation,
                    width: 24,
                    height: 24,
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
                  // Pins des dons filtrés
                  ...dons.map((don) => Marker(
                    point: LatLng(don['lat'], don['lng']),
                    width: 44,
                    height: 50,
                    child: GestureDetector(
                      onTap: () => setState(() {
                        _selectedDon = don;
                        FocusScope.of(context).unfocus();
                      }),
                      child: Column(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: don['urgent'] ? _red : _green,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: _selectedDon == don
                                    ? Colors.white
                                    : Colors.transparent,
                                width: 2.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: (don['urgent'] ? _red : _green)
                                      .withOpacity(0.4),
                                  blurRadius: 8,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(don['icon'],
                                  style: const TextStyle(fontSize: 18)),
                            ),
                          ),
                          Container(
                            width: 2,
                            height: 8,
                            color: don['urgent'] ? _red : _green,
                          ),
                        ],
                      ),
                    ),
                  )),
                ],
              ),
            ],
          ),

          // ── AppBar + Search ───────────────────────────
          Positioned(
            top: 0, left: 0, right: 0,
            child: Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 8,
                bottom: 12,
                left: 14,
                right: 14,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withOpacity(0.97),
                    Colors.white.withOpacity(0.0),
                  ],
                ),
              ),
              child: Row(
                children: [
                  // ← Back
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 38, height: 38,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: const Icon(Icons.arrow_back,
                          color: _green, size: 18),
                    ),
                  ),
                  const SizedBox(width: 10),

                  // 🔍 Search bar (cliquable)
                  Expanded(
                    child: Container(
                      height: 38,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _searchController,
                        onChanged: (val) =>
                            setState(() => _searchQuery = val),
                        onTap: () =>
                            setState(() => _searchFocused = true),
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          color: _textDark,
                        ),
                        decoration: InputDecoration(
                          hintText: _searchFocused
                              ? 'Pain, légumes, pâtisserie...'
                              : 'Dons autour de moi · Tlemcen',
                          hintStyle: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            color: _subText,
                          ),
                          prefixIcon: const Icon(
                            Icons.location_on,
                            color: _green,
                            size: 16,
                          ),
                          // ✕ pour effacer
                          suffixIcon: _searchQuery.isNotEmpty
                              ? GestureDetector(
                                  onTap: () => setState(() {
                                    _searchController.clear();
                                    _searchQuery = '';
                                  }),
                                  child: const Icon(Icons.close,
                                      color: _subText, size: 16),
                                )
                              : null,
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10),
                          isDense: true,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Filter chips ──────────────────────────────
          Positioned(
            top: MediaQuery.of(context).padding.top + 58,
            left: 0, right: 0,
            child: SizedBox(
              height: 36,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                children: ['Tous', '< 1km', '< 3km', '⚡ Urgent']
                    .map((f) {
                  final active = _activeFilter == f;
                  return GestureDetector(
                    onTap: () => setState(() {
                      _activeFilter = f;
                      _selectedDon = null;
                    }),
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: active ? _green : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Text(
                        f,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: active ? Colors.white : _subText,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          // ── نتائج البحث ───────────────────────────────
          if (_searchQuery.isNotEmpty)
            Positioned(
              top: MediaQuery.of(context).padding.top + 100,
              left: 14, right: 14,
              child: Container(
                constraints: const BoxConstraints(maxHeight: 220),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: dons.isEmpty
                    ? const Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          'Aucun don trouvé',
                          style: TextStyle(
                            color: _subText,
                            fontFamily: 'Poppins',
                            fontSize: 13,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : ListView.separated(
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        itemCount: dons.length,
                        separatorBuilder: (_, __) => const Divider(
                          height: 1, indent: 56, endIndent: 16),
                        itemBuilder: (_, i) {
                          final don = dons[i];
                          return ListTile(
                            dense: true,
                            leading: Container(
                              width: 36, height: 36,
                              decoration: BoxDecoration(
                                color: don['urgent']
                                    ? const Color(0xFFFFEBEE)
                                    : _greenBg,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text(don['icon'],
                                    style:
                                        const TextStyle(fontSize: 18)),
                              ),
                            ),
                            title: Text(
                              don['title'],
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: _textDark,
                              ),
                            ),
                            subtitle: Text(
                              '${don['place']} · ${don['dist']}',
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 10,
                                color: _subText,
                              ),
                            ),
                            trailing: don['urgent']
                                ? Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFFEBEE),
                                      borderRadius:
                                          BorderRadius.circular(6),
                                    ),
                                    child: const Text('⚡ Urgent',
                                        style: TextStyle(
                                          fontSize: 9,
                                          color: _red,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  )
                                : null,
                            onTap: () {
                              setState(() {
                                _selectedDon = don;
                                _searchQuery = '';
                                _searchController.clear();
                                FocusScope.of(context).unfocus();
                              });
                              _mapController.move(
                                LatLng(don['lat'], don['lng']), 15.0);
                            },
                          );
                        },
                      ),
              ),
            ),

          // ── Detail card ───────────────────────────────
          if (_selectedDon != null)
            Positioned(
              bottom: 20, left: 14, right: 14,
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border(
                    left: BorderSide(
                      color: _selectedDon!['urgent'] ? _red : _green,
                      width: 3,
                    ),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.12),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 50, height: 50,
                          decoration: BoxDecoration(
                            color: _selectedDon!['urgent']
                                ? const Color(0xFFFFEBEE)
                                : _greenBg,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(_selectedDon!['icon'],
                                style: const TextStyle(fontSize: 26)),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _selectedDon!['title'],
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: _textDark,
                                ),
                              ),
                              Text(
                                _selectedDon!['place'],
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 10,
                                  color: _subText,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () =>
                              setState(() => _selectedDon = null),
                          child: const Icon(Icons.close,
                              color: _subText, size: 18),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        _chip('📍 ${_selectedDon!['dist']}',
                            _greenBg, _green),
                        const SizedBox(width: 6),
                        _chip(
                          '⏰ ${_selectedDon!['time']}',
                          _selectedDon!['urgent']
                              ? const Color(0xFFFFEBEE)
                              : const Color(0xFFFFF3E0),
                          _selectedDon!['urgent'] ? _red : _orange,
                        ),
                        const SizedBox(width: 6),
                        _chip('📦 ${_selectedDon!['qty']}',
                            const Color(0xFFE3F2FD), _blue),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('✅ Mission acceptée !'),
                                backgroundColor: _green,
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              color: _selectedDon!['urgent']
                                  ? _red
                                  : _green,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: (_selectedDon!['urgent']
                                          ? _red
                                          : _green)
                                      .withOpacity(0.3),
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                            child: Text(
                              _selectedDon!['urgent']
                                  ? '🚀 Urgent'
                                  : '✅ Accepter',
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

          // ── Bouton centrer ────────────────────────────
          Positioned(
            bottom: _selectedDon != null ? 160 : 20,
            right: 14,
            child: GestureDetector(
              onTap: () => _mapController.move(_myLocation, 14.5),
              child: Container(
                width: 44, height: 44,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.12),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: const Icon(Icons.my_location,
                    color: _blue, size: 22),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _chip(String label, Color bg, Color fg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 9,
          fontWeight: FontWeight.w600,
          color: fg,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}