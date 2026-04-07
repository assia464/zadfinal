import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'home_screen.dart';

class ZadColors {
  static const Color darkNavy = Color(0xFF1A2B4A);
  static const Color teal = Color(0xFF2E7D7D);
  static const Color leafGreen = Color(0xFF2E7D32);
  static const Color background = Color(0xFFFFFFFF);
  static const Color labelGrey = Color(0xFF6B7A8D);
  static const Color cardBg = Color(0xFFF5F7FA);
}

class DonsDisponiblesScreen extends StatefulWidget {
  const DonsDisponiblesScreen({super.key});

  @override
  State<DonsDisponiblesScreen> createState() => _DonsDisponiblesScreenState();
}

class _DonsDisponiblesScreenState extends State<DonsDisponiblesScreen> {
  String _filter = 'Tous';
  final List<String> _filters = ['Tous', 'Pain', 'Repas', 'Urgent'];

  final List<Map<String, dynamic>> _dons = [
    {
      'titre': 'Repas cuisinés',
      'source': 'Restaurant Le Zitouni',
      'adresse': 'Alger Centre, Alger',
      'latitude': 36.7538,
      'longitude': 3.0588,
      'distance': '2.1 km',
      'expiration': 'Expire dans 35 min',
      'quantite': '15 portions disponibles',
      'statut': 'Urgent',
      'type': 'Repas',
      'icon': Icons.restaurant,
    },
    {
      'titre': 'Pain',
      'source': 'Boulangerie Atlas',
      'adresse': 'BAB EL ASSA, Alger',
      'latitude': 36.7638,
      'longitude': 3.0688,
      'distance': '1.2 km',
      'expiration': 'Expire dans 2h',
      'quantite': '30 unités disponibles',
      'statut': 'En attente',
      'type': 'Pain',
      'icon': Icons.bakery_dining,
    },
    {
      'titre': 'Farine, Sucre',
      'source': 'Alimentation ISRAA',
      'adresse': 'KIFAN, Alger',
      'latitude': 36.7738,
      'longitude': 3.0788,
      'distance': '0.8 km',
      'expiration': 'Bénévole en route',
      'quantite': '20 pièces',
      'statut': 'Réservé',
      'type': 'Tous',
      'icon': Icons.kitchen,
    },
  ];

  List<Map<String, dynamic>> get _filtered {
    if (_filter == 'Tous') return _dons;
    if (_filter == 'Urgent')
      return _dons.where((d) => d['statut'] == 'Urgent').toList();
    return _dons.where((d) => d['type'] == _filter).toList();
  }

  void _goBackToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  // ✅ دالة فتح صفحة الخريطة
  void _openMap(double latitude, double longitude, String titre) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            MapScreen(latitude: latitude, longitude: longitude, titre: titre),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ZadColors.background,
      body: Column(
        children: [
          // Header
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
                  onTap: _goBackToHome,
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Dons disponibles',
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
                // Filters
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
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
                              horizontal: 18,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: active
                                  ? ZadColors.darkNavy
                                  : ZadColors.cardBg,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              f,
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
                // List
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _filtered.length,
                    itemBuilder: (context, index) {
                      return _DonCard(
                        data: _filtered[index],
                        onReserver: () {
                          Navigator.pushNamed(context, '/confirmer-reception');
                        },
                        onSuivre: () => _openMap(
                          _filtered[index]['latitude'],
                          _filtered[index]['longitude'],
                          _filtered[index]['source'],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DonCard extends StatelessWidget {
  final Map<String, dynamic> data;
  final VoidCallback onReserver;
  final VoidCallback onSuivre;

  const _DonCard({
    required this.data,
    required this.onReserver,
    required this.onSuivre,
  });

  Color get _statutColor {
    switch (data['statut']) {
      case 'Urgent':
        return const Color(0xFFE53935);
      case 'En attente':
        return const Color(0xFFFF9800);
      case 'Réservé':
        return const Color(0xFF2E7D32);
      default:
        return const Color(0xFF2E7D32);
    }
  }

  Color get _statutBg {
    switch (data['statut']) {
      case 'Urgent':
        return const Color(0xFFFFEBEE);
      case 'En attente':
        return const Color(0xFFFFF3E0);
      case 'Réservé':
        return const Color(0xFFE8F5E9);
      default:
        return const Color(0xFFE8F5E9);
    }
  }

  bool get _isUrgent => data['statut'] == 'Urgent';
  bool get _isReserve => data['statut'] == 'Réservé';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _isUrgent ? const Color(0xFFFFF8F8) : ZadColors.cardBg,
        borderRadius: BorderRadius.circular(14),
        border: _isUrgent
            ? Border.all(color: const Color(0xFFFFCDD2), width: 1)
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(data['icon'], color: ZadColors.leafGreen, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          data['titre'],
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: ZadColors.darkNavy,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 3,
                          ),
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
                    const SizedBox(height: 2),
                    Text(
                      data['source'],
                      style: const TextStyle(
                        fontSize: 12,
                        color: ZadColors.labelGrey,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 12,
                          color: ZadColors.labelGrey,
                        ),
                        Text(
                          ' ${data['distance']}',
                          style: const TextStyle(
                            fontSize: 11,
                            color: ZadColors.labelGrey,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.access_time,
                          size: 12,
                          color: ZadColors.labelGrey,
                        ),
                        Text(
                          ' ${data['expiration']}',
                          style: const TextStyle(
                            fontSize: 11,
                            color: ZadColors.labelGrey,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      data['quantite'],
                      style: const TextStyle(
                        fontSize: 11,
                        color: ZadColors.labelGrey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (_isReserve)
            SizedBox(
              width: double.infinity,
              height: 38,
              child: ElevatedButton(
                onPressed: onSuivre,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ZadColors.teal,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  'Suivre la livraison',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                ),
              ),
            )
          else
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 38,
                    child: ElevatedButton(
                      onPressed: onReserver,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ZadColors.leafGreen,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        _isUrgent ? 'Réserver maintenant' : 'Réserver',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

// ✅ صفحة الخريطة الجديدة
class MapScreen extends StatelessWidget {
  final double latitude;
  final double longitude;
  final String titre;

  const MapScreen({
    super.key,
    required this.latitude,
    required this.longitude,
    required this.titre,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titre),
        backgroundColor: const Color(0xFF1B5E20),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(latitude, longitude),
          initialZoom: 15.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.zad',
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: LatLng(latitude, longitude),
                width: 80,
                height: 80,
                child: const Icon(
                  Icons.location_pin,
                  color: Colors.red,
                  size: 40,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
