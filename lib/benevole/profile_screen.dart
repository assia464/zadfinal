// ============================================================
// 📄 lib/screens/benevole/profile_screen.dart
// ============================================================

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'edit_profile_screen.dart';
import 'missions_screen.dart';
import 'badges_screen.dart';
import 'notification_settings_screen.dart';
import 'login_screen.dart';

class BenevoleProfileScreen extends StatefulWidget {
  const BenevoleProfileScreen({super.key});

  @override
  State<BenevoleProfileScreen> createState() =>
      _BenevoleProfileScreenState();
}

class _BenevoleProfileScreenState extends State<BenevoleProfileScreen> {
  static const _green     = Color(0xFF4CAF50);
  static const _greenDark = Color(0xFF388E3C);
  static const _greenPale = Color(0xFFE8F5E9);
  static const _orange    = Color(0xFFFF8F00);
  static const _orangeBg  = Color(0xFFFFF3E0);
  static const _blue      = Color(0xFF1565C0);
  static const _blueBg    = Color(0xFFE3F2FD);
  static const _red       = Color(0xFFD32F2F);
  static const _redBg     = Color(0xFFFFEBEE);
  static const _purple    = Color(0xFF7B1FA2);
  static const _purpleBg  = Color(0xFFF3E5F5);
  static const _divider   = Color(0xFFEEEEEE);
  static const _subText   = Color(0xFF757575);
  static const _textDark  = Color(0xFF1B1B1B);

  File? _profileImage;
  final _picker = ImagePicker();
  String _selectedTransport = 'Voiture';

  Future<void> _pickImage() async {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40, height: 4,
              decoration: BoxDecoration(
                  color: _divider,
                  borderRadius: BorderRadius.circular(2)),
            ),
            const SizedBox(height: 16),
            const Text('Changer la photo',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                )),
            const SizedBox(height: 12),
            ListTile(
              leading: Container(
                width: 44, height: 44,
                decoration: BoxDecoration(
                    color: _greenPale,
                    borderRadius: BorderRadius.circular(12)),
                child: const Icon(Icons.camera_alt, color: _green),
              ),
              title: const Text('Caméra',
                  style: TextStyle(fontFamily: 'Poppins')),
              onTap: () async {
                Navigator.pop(ctx);
                final p = await _picker.pickImage(
                    source: ImageSource.camera, imageQuality: 85);
                if (p != null) {
                  setState(() => _profileImage = File(p.path));
                }
              },
            ),
            ListTile(
              leading: Container(
                width: 44, height: 44,
                decoration: BoxDecoration(
                    color: _greenPale,
                    borderRadius: BorderRadius.circular(12)),
                child: const Icon(Icons.photo_library, color: _green),
              ),
              title: const Text('Galerie',
                  style: TextStyle(fontFamily: 'Poppins')),
              onTap: () async {
                Navigator.pop(ctx);
                final p = await _picker.pickImage(
                    source: ImageSource.gallery, imageQuality: 85);
                if (p != null) {
                  setState(() => _profileImage = File(p.path));
                }
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  void _navigate(Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBF9),
      body: Column(
        children: [
          _buildProfileHero(),
          _buildStats(),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
              child: Column(
                children: [
                  _buildTransportSection(),
                  const SizedBox(height: 12),
                  _buildMenuSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHero() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1B5E20), _greenDark, _green],
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
        bottom: 24,
        left: 18,
        right: 18,
      ),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 36, height: 36,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.arrow_back,
                      color: Colors.white, size: 18),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: _pickImage,
            child: Stack(
              children: [
                Container(
                  width: 80, height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 12,
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: _profileImage != null
                        ? Image.file(_profileImage!, fit: BoxFit.cover)
                        : Container(
                            color: Colors.white.withOpacity(0.25),
                            child: const Center(
                              child: Text('KM',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 26,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  )),
                            ),
                          ),
                  ),
                ),
                Positioned(
                  bottom: 0, right: 0,
                  child: Container(
                    width: 26, height: 26,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: const Icon(Icons.camera_alt,
                        color: _green, size: 14),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const Text('Karim Mansouri',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              )),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              '🤝 Bénévole · 🥈 Engagé · 🚗 Voiture',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 11,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 4),
          const Text('📍 Tlemcen Centre',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 10,
                color: Colors.white70,
              )),
        ],
      ),
    );
  }

  Widget _buildStats() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: _green.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          _statItem('28', 'Missions', _green),
          _dividerV(),
          _statItem('340kg', 'Sauvés', _blue),
          _dividerV(),
          _statItem('⭐4.9', 'Note', _orange),
          _dividerV(),
          _statItem('245', 'Points', _greenDark),
        ],
      ),
    );
  }

  Widget _statItem(String val, String label, Color color) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Column(
          children: [
            Text(val,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: color,
                )),
            const SizedBox(height: 2),
            Text(label,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 9,
                  color: _subText,
                )),
          ],
        ),
      ),
    );
  }

  Widget _dividerV() =>
      Container(width: 1, height: 40, color: _divider);

  Widget _buildTransportSection() {
    final transports = [
      {'icon': '🚗', 'name': 'Voiture'},
      {'icon': '🏍️', 'name': 'Moto'},
      {'icon': '🚲', 'name': 'Vélo'},
      {'icon': '🚶', 'name': 'À pied'},
    ];
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.directions_car_outlined,
                  color: _green, size: 18),
              SizedBox(width: 8),
              Text('Moyen de transport',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: _textDark,
                  )),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: transports.map((t) {
              final sel = _selectedTransport == t['name'];
              return Expanded(
                child: GestureDetector(
                  onTap: () =>
                      setState(() => _selectedTransport = t['name']!),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.only(right: 6),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: sel
                          ? _greenPale
                          : const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: sel ? _green : Colors.transparent,
                        width: 1.5,
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(t['icon']!,
                            style: const TextStyle(fontSize: 20)),
                        const SizedBox(height: 3),
                        Text(t['name']!,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 9,
                              fontWeight: FontWeight.w600,
                              color: sel ? _green : _subText,
                            )),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          _menuItem(
            icon: Icons.edit_outlined,
            iconBg: _greenPale,
            iconColor: _green,
            title: 'Modifier le profil',
            subtitle: 'Nom, photo, transport...',
            onTap: () => _navigate(const BenevoleEditProfileScreen()),
          ),
          const Divider(height: 1, indent: 60, endIndent: 16),
          _menuItem(
            icon: Icons.assignment_outlined,
            iconBg: _greenPale,
            iconColor: _green,
            title: 'Historique des missions',
            subtitle: '28 missions réalisées',
            onTap: () => _navigate(const BenevoleMissionsScreen()),
          ),
          const Divider(height: 1, indent: 60, endIndent: 16),
          _menuItem(
            icon: Icons.emoji_events_outlined,
            iconBg: const Color(0xFFFFFDE7),
            iconColor: const Color(0xFFF9A825),
            title: 'Mes badges & récompenses',
            subtitle: '3 récompenses disponibles',
            onTap: () => _navigate(const BenevoleBadgesScreen()),
          ),
          const Divider(height: 1, indent: 60, endIndent: 16),
          _menuItem(
            icon: Icons.notifications_outlined,
            iconBg: _orangeBg,
            iconColor: _orange,
            title: 'Paramètres notifications',
            subtitle: 'Gérer vos alertes',
            onTap: () => _navigate(
                const BenevoleNotificationSettingsScreen()),
          ),
          const Divider(height: 1, indent: 60, endIndent: 16),
          _menuItem(
            icon: Icons.help_outline,
            iconBg: _blueBg,
            iconColor: _blue,
            title: 'Aide et support',
            subtitle: 'FAQ · Contactez-nous',
            onTap: () => _showInfoDialog(
              '❓ Aide & Support',
              'Pour toute question :\n📧 support@zad-tlemcen.dz\n📞 +213 41 XX XX XX',
            ),
          ),
          const Divider(height: 1, indent: 60, endIndent: 16),
          _menuItem(
            icon: Icons.security_outlined,
            iconBg: _purpleBg,
            iconColor: _purple,
            title: 'Confidentialité',
            subtitle: 'Gérer vos données',
            onTap: () => _showInfoDialog(
              '🔒 Confidentialité',
              'Vos données sont protégées et ne sont jamais partagées avec des tiers.\n\nPolitique de confidentialité ZAD v1.0',
            ),
          ),
          const Divider(height: 1),
          _menuItem(
            icon: Icons.logout,
            iconBg: _redBg,
            iconColor: _red,
            title: 'Se déconnecter',
            subtitle: '',
            isLogout: true,
            onTap: () => _showLogoutDialog(),
          ),
        ],
      ),
    );
  }

  Widget _menuItem({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isLogout = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 14, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 40, height: 40,
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(11),
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: isLogout ? _red : _textDark,
                      )),
                  if (subtitle.isNotEmpty) ...[
                    const SizedBox(height: 1),
                    Text(subtitle,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 10,
                          color: _subText,
                        )),
                  ],
                ],
              ),
            ),
            if (!isLogout)
              const Icon(Icons.arrow_forward_ios,
                  color: _subText, size: 14),
          ],
        ),
      ),
    );
  }

  void _showInfoDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)),
        title: Text(title,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              fontSize: 16,
            )),
        content: Text(content,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 13,
              color: _subText,
              height: 1.6,
            )),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: _green,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text('OK',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                )),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)),
        title: const Text('Se déconnecter ?',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
            )),
        content: const Text(
            'Vous serez déconnecté de votre compte ZAD.',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 13,
              color: _subText,
            )),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: _subText,
                  fontWeight: FontWeight.w600,
                )),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (_) => const LoginScreen()),
                (route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _red,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text('Se déconnecter',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                )),
          ),
        ],
      ),
    );
  }
}