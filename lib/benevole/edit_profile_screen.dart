// ============================================================
// 📄 lib/screens/benevole/edit_profile_screen.dart
// ============================================================

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class BenevoleEditProfileScreen extends StatefulWidget {
  const BenevoleEditProfileScreen({super.key});

  @override
  State<BenevoleEditProfileScreen> createState() =>
      _BenevoleEditProfileScreenState();
}

class _BenevoleEditProfileScreenState
    extends State<BenevoleEditProfileScreen> {
  static const _green     = Color(0xFF4CAF50);
  static const _greenDark = Color(0xFF388E3C);
  static const _greenBg   = Color(0xFFF1F8E9);
  static const _greenPale = Color(0xFFE8F5E9);
  static const _divider   = Color(0xFFEEEEEE);
  static const _subText   = Color(0xFF757575);
  static const _textDark  = Color(0xFF1B1B1B);

  final _nomController   = TextEditingController(text: 'Karim Mansouri');
  final _emailController = TextEditingController(text: 'karim@email.com');
  final _phoneController = TextEditingController(text: '+213 555 123 456');
  final _bioController   = TextEditingController(
      text: 'Bénévole passionné à Tlemcen 🌿');

  File?  _profileImage;
  String _selectedTransport = 'Voiture';
  String _selectedQuartier  = 'Centre-ville';
  bool   _isSaving          = false;

  final _picker = ImagePicker();

  final List<String> _quartiers = [
    'Centre-ville', 'Boudghène', 'Imama', 'Kiffan El Ouad',
    'Hay Salam', 'Plateau', 'Mansourah', 'Chetouane', 'Autre',
  ];

  @override
  void dispose() {
    _nomController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _bioController.dispose();
    super.dispose();
  }

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
                color: _divider, borderRadius: BorderRadius.circular(2)),
            ),
            const SizedBox(height: 16),
            const Text('Changer la photo',
                style: TextStyle(
                  fontFamily: 'Poppins', fontSize: 16,
                  fontWeight: FontWeight.w600)),
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
                if (p != null) setState(() => _profileImage = File(p.path));
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
                if (p != null) setState(() => _profileImage = File(p.path));
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _save() async {
    setState(() => _isSaving = true);
    await Future.delayed(const Duration(milliseconds: 1200));
    if (!mounted) return;
    setState(() => _isSaving = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('✅ Profil mis à jour !'),
        backgroundColor: _green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)),
      ),
    );
    Navigator.pop(context);
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
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
              child: Column(
                children: [
                  _buildAvatarSection(),
                  const SizedBox(height: 16),
                  _buildInfoSection(),
                  const SizedBox(height: 12),
                  _buildTransportSection(),
                  const SizedBox(height: 12),
                  _buildQuartierSection(),
                  const SizedBox(height: 24),
                  _buildSaveButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [_greenDark, _green],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x554CAF50), blurRadius: 16,
            offset: Offset(0, 6),
          ),
        ],
      ),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 12,
        bottom: 18, left: 18, right: 18,
      ),
      child: Row(
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
          const SizedBox(width: 12),
          const Expanded(
            child: Text('Modifier le profil',
                style: TextStyle(
                  fontFamily: 'Poppins', fontSize: 18,
                  fontWeight: FontWeight.w700, color: Colors.white,
                )),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarSection() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Center(
        child: GestureDetector(
          onTap: _pickImage,
          child: Stack(
            children: [
              Container(
                width: 90, height: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: _green, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: _green.withOpacity(0.2),
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: ClipOval(
                  child: _profileImage != null
                      ? Image.file(_profileImage!, fit: BoxFit.cover)
                      : Container(
                          color: _greenPale,
                          child: const Center(
                            child: Text('KM',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 28,
                                  fontWeight: FontWeight.w700,
                                  color: _green,
                                )),
                          ),
                        ),
                ),
              ),
              Positioned(
                bottom: 0, right: 0,
                child: Container(
                  width: 28, height: 28,
                  decoration: BoxDecoration(
                    color: _green,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const Icon(Icons.edit,
                      color: Colors.white, size: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10, offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Informations personnelles',
              style: TextStyle(
                fontFamily: 'Poppins', fontSize: 13,
                fontWeight: FontWeight.w700, color: _textDark,
              )),
          const SizedBox(height: 14),
          _buildEditField(Icons.person_outline, 'Nom complet', _nomController),
          const SizedBox(height: 10),
          _buildEditField(Icons.email_outlined, 'Email', _emailController,
              keyboardType: TextInputType.emailAddress),
          const SizedBox(height: 10),
          _buildEditField(Icons.phone_outlined, 'Téléphone', _phoneController,
              keyboardType: TextInputType.phone),
          const SizedBox(height: 10),
          _buildEditField(Icons.info_outline, 'Bio', _bioController,
              maxLines: 2),
        ],
      ),
    );
  }

  Widget _buildTransportSection() {
    final transports = [
      {'icon': '🚗', 'name': 'Voiture'},
      {'icon': '🏍️', 'name': 'Moto'},
      {'icon': '🚲', 'name': 'Vélo'},
      {'icon': '🚶', 'name': 'À pied'},
    ];
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10, offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Moyen de transport',
              style: TextStyle(
                fontFamily: 'Poppins', fontSize: 13,
                fontWeight: FontWeight.w700, color: _textDark,
              )),
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
                      color: sel ? _greenPale : const Color(0xFFF5F5F5),
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
                              fontFamily: 'Poppins', fontSize: 9,
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

  Widget _buildQuartierSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10, offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Quartier',
              style: TextStyle(
                fontFamily: 'Poppins', fontSize: 13,
                fontWeight: FontWeight.w700, color: _textDark,
              )),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            initialValue: _selectedQuartier,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: _divider),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: _divider),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: _green, width: 1.5),
              ),
            ),
            items: _quartiers.map((q) => DropdownMenuItem(
              value: q,
              child: Text(q,
                  style: const TextStyle(
                    fontFamily: 'Poppins', fontSize: 13)),
            )).toList(),
            onChanged: (v) => setState(() => _selectedQuartier = v!),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: _isSaving ? null : _save,
        style: ElevatedButton.styleFrom(
          backgroundColor: _green,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14)),
          elevation: 6,
          shadowColor: _green.withOpacity(0.4),
        ),
        child: _isSaving
            ? const SizedBox(
                width: 22, height: 22,
                child: CircularProgressIndicator(
                    color: Colors.white, strokeWidth: 2.5))
            : const Text('💾 Sauvegarder',
                style: TextStyle(
                  fontFamily: 'Poppins', fontSize: 15,
                  fontWeight: FontWeight.w600, color: Colors.white,
                )),
      ),
    );
  }

  Widget _buildEditField(
    IconData icon,
    String hint,
    TextEditingController controller, {
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: _greenBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _divider, width: 1.5),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Icon(icon, color: _green, size: 18),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              maxLines: maxLines,
              decoration: InputDecoration(
                hintText: hint,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 12),
                hintStyle: const TextStyle(
                    color: Color(0xFFBDBDBD), fontSize: 12),
              ),
              style: const TextStyle(
                fontFamily: 'Poppins', fontSize: 13, color: _textDark),
            ),
          ),
        ],
      ),
    );
  }
}