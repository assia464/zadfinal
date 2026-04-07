import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../main.dart';
import 'chat_screen.dart'; // ✅ تمت إضافة هذا السطر لاستيراد صفحة المحادثة

class TrackingScreen extends StatefulWidget {
  const TrackingScreen({super.key});

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  static const LatLng _volunteerLocation = LatLng(34.8826, -1.3167);
  static const LatLng _destinationLocation = LatLng(34.8860, -1.3100);
  
  final MapController _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ZADColors.background,
      body: Column(
        children: [
          Container(
            color: ZADColors.headerBg,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back_ios_new,
                          color: Colors.white, size: 18),
                    ),
                    const Expanded(
                      child: Text('Suivi du bénévole',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w800)),
                    ),
                    const SizedBox(width: 26),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildVolunteerCard(),
                  const SizedBox(height: 16),
                  _buildMapCard(),
                  const SizedBox(height: 16),
                  _buildDonationDetails(),
                  const SizedBox(height: 16),
                  _buildActionButtons(context),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const ZADBottomNav(currentIndex: 0),
    );
  }

  Widget _buildVolunteerCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 3)),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: ZADColors.primarySoft,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Center(
              child: Text('KM',
                  style: TextStyle(
                      color: ZADColors.primary,
                      fontWeight: FontWeight.w900,
                      fontSize: 22)),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Karim Mansouri',
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                        color: ZADColors.textDark)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: ZADColors.success,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text('En ligne',
                        style: TextStyle(
                            color: ZADColors.textMedium, fontSize: 12)),
                    const SizedBox(width: 12),
                    const Icon(Icons.star,
                        color: ZADColors.accentYellow, size: 14),
                    const SizedBox(width: 4),
                    const Text('4.9',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.map_outlined,
                  color: ZADColors.primary, size: 20),
              const SizedBox(width: 8),
              const Text('Position du bénévole',
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                      color: ZADColors.textDark)),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: ZADColors.primarySoft,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.timer,
                        color: ZADColors.primary, size: 14),
                    SizedBox(width: 4),
                    Text('~8 min',
                        style: TextStyle(
                            color: ZADColors.primary,
                            fontWeight: FontWeight.w700,
                            fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text('Position actuelle: Route de Tlemcen',
              style: TextStyle(
                  color: ZADColors.textMedium, fontSize: 12)),
          const SizedBox(height: 12),
          SizedBox(
            height: 280,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  initialCenter: _volunteerLocation,
                  initialZoom: 15,
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.zad.donateur',
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        width: 80,
                        height: 80,
                        point: _volunteerLocation,
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: const [
                                  BoxShadow(color: Colors.black26, blurRadius: 4)
                                ],
                              ),
                              child: const Text('Karim',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: ZADColors.primary)),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: ZADColors.primary,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.person,
                                  color: Colors.white, size: 20),
                            ),
                          ],
                        ),
                      ),
                      Marker(
                        width: 80,
                        height: 80,
                        point: _destinationLocation,
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: const [
                                  BoxShadow(color: Colors.black26, blurRadius: 4)
                                ],
                              ),
                              child: const Text('Boulangerie',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: ZADColors.accentOrange)),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: ZADColors.accentOrange,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.location_on,
                                  color: Colors.white, size: 20),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  PolylineLayer(
                    polylines: [
                      Polyline(
                        points: [
                          _volunteerLocation,
                          LatLng(34.8840, -1.3130),
                          _destinationLocation,
                        ],
                        color: ZADColors.primary,
                        strokeWidth: 4,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _mapController.move(_volunteerLocation, 16);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 12),
                    decoration: BoxDecoration(
                      color: ZADColors.primarySoft,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.person_pin_circle,
                            color: ZADColors.primary, size: 18),
                        SizedBox(width: 8),
                        Text('Centrer sur Karim',
                            style: TextStyle(
                                color: ZADColors.primary,
                                fontWeight: FontWeight.w600,
                                fontSize: 13)),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _mapController.move(_destinationLocation, 16);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 12),
                    decoration: BoxDecoration(
                      color: ZADColors.primarySoft,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.location_on,
                            color: ZADColors.primary, size: 18),
                        SizedBox(width: 8),
                        Text('Centrer sur destination',
                            style: TextStyle(
                                color: ZADColors.primary,
                                fontWeight: FontWeight.w600,
                                fontSize: 13)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: ZADColors.primarySoft,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Row(
              children: [
                Icon(Icons.info_outline,
                    color: ZADColors.primary, size: 20),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '📍 Position actuelle de Karim',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                            color: ZADColors.textDark),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Route de Tlemcen, à 2.3 km de votre boulangerie',
                        style: TextStyle(
                            color: ZADColors.textLight, fontSize: 11),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '⏱️ Temps estimé: 8 minutes',
                        style: TextStyle(
                            color: ZADColors.primary,
                            fontSize: 11,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDonationDetails() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Détails de la collecte',
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                  color: ZADColors.textDark)),
          const SizedBox(height: 12),
          _buildInfoRow(Icons.restaurant_outlined, 'Produit', 'Pain & Viennoiseries'),
          _buildInfoRow(Icons.inventory_2_outlined, 'Quantité', '30 unités'),
          _buildInfoRow(Icons.location_on_outlined, 'Adresse', 'Rue Ibn Badis · Tlemcen Centre'),
          _buildInfoRow(Icons.access_time, 'Heure estimée', 'Arrive dans ~8 min'),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: ZADColors.primary, size: 18),
          const SizedBox(width: 12),
          SizedBox(
            width: 110,
            child: Text(label,
                style: const TextStyle(
                    color: ZADColors.textMedium, fontSize: 13)),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(value,
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: ZADColors.textDark,
                    fontSize: 13)),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ZADButton(
            label: 'Contacter',
            icon: Icons.phone,
            onTap: () => _showCallDialog(context, 'Karim Mansouri', '+213 555 123 456'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ZADButton(
            label: 'Message',
            icon: Icons.chat_bubble_outline,
            onTap: () {
              // ✅ فتح صفحة المحادثة مع Karim Mansouri
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(
                    contactName: 'Karim Mansouri',
                    contactInitials: 'KM',
                    contactBgColor: ZADColors.primaryLight,
                    contactPhone: '+213 555 123 456',
                  ),
                ),
              );
            },
            outlined: true,
          ),
        ),
      ],
    );
  }

  void _showCallDialog(BuildContext context, String name, String phone) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text('Contacter $name',
            style: const TextStyle(
                fontWeight: FontWeight.w800, color: ZADColors.primary)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.phone, size: 48, color: ZADColors.primary),
            const SizedBox(height: 12),
            Text(phone,
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            const Text('Appeler ce numéro ?',
                style: TextStyle(color: ZADColors.textMedium)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Annuler',
                style: TextStyle(color: ZADColors.textLight)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Appel en cours... (simulation)'),
                  backgroundColor: ZADColors.primary,
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: const Text('Appeler',
                style: TextStyle(color: ZADColors.primary)),
          ),
        ],
      ),
    );
  }
}