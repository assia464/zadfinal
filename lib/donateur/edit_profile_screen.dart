import 'dart:io';
import 'package:flutter/material.dart';
import '../main.dart';

// ─────────────────────────────────────────────
// SCREEN 14: EDIT PROFILE
// MODIFIED: image_picker حقيقي — الصورة تظهر في الأفاتار
// ─────────────────────────────────────────────
class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  // صورة حقيقية من الجهاز
  File? _profilePhoto;

  final _nomController =
      TextEditingController(text: 'Boulangerie Atlas');
  final _emailController =
      TextEditingController(text: 'atlas.boulangerie@email.com');
  final _phoneController =
      TextEditingController(text: '+213 555 123 456');
  final _adresseController =
      TextEditingController(text: 'Rue Ibn Badis · Tlemcen Centre');
  final _quartierController =
      TextEditingController(text: 'Tlemcen Centre');

  // ── image picker حقيقي ──
  Future<void> _pickProfilePhoto() async {
    final file = await showImagePickerSheet(
      context,
      title: 'Photo de profil',
    );
    if (file != null) setState(() => _profilePhoto = file);
  }

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
                      child: Text('Modifier le profil',
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
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 16),

                  // ── Avatar (الصورة الحقيقية) ──
                  GestureDetector(
                    onTap: _pickProfilePhoto,
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          width: 90, height: 90,
                          decoration: BoxDecoration(
                            color: ZADColors.primaryLight,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: _profilePhoto != null
                                  ? ZADColors.primary
                                  : ZADColors.divider,
                              width: 3,
                            ),
                          ),
                          child: ClipOval(
                            child: _profilePhoto != null
                                // ── عرض الصورة الحقيقية ──
                                ? Image.file(
                                    _profilePhoto!,
                                    fit: BoxFit.cover,
                                    width: 90,
                                    height: 90,
                                  )
                                : const Center(
                                    child: Text('BA',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w900,
                                            fontSize: 28)),
                                  ),
                          ),
                        ),
                        Container(
                          width: 30, height: 30,
                          decoration: BoxDecoration(
                            color: ZADColors.primary,
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Colors.white, width: 2),
                          ),
                          child: const Icon(Icons.camera_alt,
                              size: 14, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 6),
                  GestureDetector(
                    onTap: _pickProfilePhoto,
                    child: Text(
                      _profilePhoto != null
                          ? 'Photo ajoutée — Appuyez pour changer'
                          : 'Ajouter une photo de profil',
                      style: const TextStyle(
                          color: ZADColors.primary,
                          fontWeight: FontWeight.w600,
                          fontSize: 13),
                    ),
                  ),
                  const SizedBox(height: 28),

                  // ── Informations générales ──
                  _EditSectionLabel(label: 'Informations générales'),
                  const SizedBox(height: 12),
                  _EditableField(
                    label: "Nom de l'établissement",
                    controller: _nomController,
                    icon: Icons.storefront_outlined,
                  ),
                  const SizedBox(height: 12),
                  _EditableField(
                    label: 'Adresse email',
                    controller: _emailController,
                    icon: Icons.email_outlined,
                    keyboard: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 12),
                  _EditableField(
                    label: 'Téléphone',
                    controller: _phoneController,
                    icon: Icons.phone_outlined,
                    keyboard: TextInputType.phone,
                  ),
                  const SizedBox(height: 24),

                  // ── Localisation ──
                  _EditSectionLabel(label: 'Localisation'),
                  const SizedBox(height: 12),
                  _EditableField(
                    label: 'Adresse complète',
                    controller: _adresseController,
                    icon: Icons.location_on_outlined,
                  ),
                  const SizedBox(height: 12),
                  _EditableField(
                    label: 'Quartier',
                    controller: _quartierController,
                    icon: Icons.map_outlined,
                  ),
                  const SizedBox(height: 28),
                  ZADButton(
                    label: 'Enregistrer les modifications',
                    icon: Icons.check,
                    onTap: () => Navigator.pop(context),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EditSectionLabel extends StatelessWidget {
  final String label;
  const _EditSectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(label,
          style: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 15,
              color: ZADColors.textDark)),
    );
  }
}

class _EditableField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final IconData icon;
  final TextInputType? keyboard;

  const _EditableField({
    required this.label,
    required this.controller,
    required this.icon,
    this.keyboard,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 8, 14, 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(
                  color: ZADColors.textLight,
                  fontSize: 11,
                  fontWeight: FontWeight.w500)),
          Row(
            children: [
              Icon(icon, color: ZADColors.primary, size: 18),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: controller,
                  keyboardType: keyboard,
                  style: const TextStyle(
                      color: ZADColors.textDark,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 6),
                  ),
                ),
              ),
              const Icon(Icons.edit,
                  color: ZADColors.textLight, size: 16),
            ],
          ),
        ],
      ),
    );
  }
}
