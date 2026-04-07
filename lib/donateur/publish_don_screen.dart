import 'dart:io';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../main.dart';

// ─────────────────────────────────────────────
// SCREEN 4: PUBLISH DON
// MODIFIED: image_picker حقيقي — تظهر الصورة في التطبيق
// AJOUTÉ: Type de nourriture (dropdown) - placé AVANT Description
// SUPPRIMÉ: option "Autre" du dropdown
// ─────────────────────────────────────────────
class PublishDonScreen extends StatefulWidget {
  const PublishDonScreen({super.key});

  @override
  State<PublishDonScreen> createState() => _PublishDonScreenState();
}

class _PublishDonScreenState extends State<PublishDonScreen> {
  int _quantity = 30;
  String _urgency = 'Faible';
  TimeOfDay _collecteTime = const TimeOfDay(hour: 18, minute: 0);
  
  // AJOUTÉ: Type de nourriture
  String _foodType = 'Plat cuisiné'; // valeur par défaut

  // صورة حقيقية من الجهاز
  File? _photoFile;

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _collecteTime,
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: ZADColors.primary,
            onPrimary: Colors.white,
            surface: Colors.white,
            onSurface: ZADColors.textDark,
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) setState(() => _collecteTime = picked);
  }

  // ── image picker حقيقي ──
  Future<void> _pickPhoto() async {
    final file = await showImagePickerSheet(
      context,
      title: 'Photo de confirmation',
    );
    if (file != null) setState(() => _photoFile = file);
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
                      child: Text('Publier un don',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w800)),
                    ),
                    const SizedBox(width: 18),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Type de nourriture (DÉPLACÉ ICI - AVANT Description) ──
                  _SectionTitle(
                      icon: Icons.restaurant_outlined, label: 'Type de nourriture'),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _foodType,
                        isExpanded: true,
                        hint: const Text(
                          'Sélectionnez le type de nourriture',
                          style: TextStyle(color: ZADColors.textLight, fontSize: 14),
                        ),
                        icon: Icon(Icons.arrow_drop_down, color: ZADColors.primary),
                        dropdownColor: Colors.white,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: ZADColors.textDark,
                        ),
                        items: const [
                          DropdownMenuItem(value: 'Plat cuisiné', child: Text('🍲 Plat cuisiné')),
                          DropdownMenuItem(value: 'Produit sec', child: Text('🍚 Produit sec (riz, pâtes, légumineuses)')),
                          DropdownMenuItem(value: 'Conserve', child: Text('🥫 Conserve')),
                          DropdownMenuItem(value: 'Boulangerie', child: Text('🥖 Boulangerie (pain, viennoiseries)')),
                          DropdownMenuItem(value: 'Produit laitier', child: Text('🥛 Produit laitier')),
                          DropdownMenuItem(value: 'Fruits et légumes', child: Text('🍎 Fruits et légumes frais')),
                          DropdownMenuItem(value: 'Surgelé', child: Text('❄️ Aliment surgelé')),
                          DropdownMenuItem(value: 'Boisson', child: Text('🥤 Boisson')),
                          // خيار "Autre" تمت إزالته
                        ],
                        onChanged: (value) {
                          setState(() {
                            _foodType = value!;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // ── Description ──
                  _SectionTitle(
                      icon: Icons.edit_outlined, label: 'Description'),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 3)),
                      ],
                    ),
                    child: const TextField(
                      maxLines: 3,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Décrivez votre don...',
                        hintStyle: TextStyle(
                            color: ZADColors.textLight, fontSize: 14),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // ── Quantité ──
                  _SectionTitle(
                      icon: Icons.inventory_2_outlined, label: 'Quantité'),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 3)),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _QuantityBtn(
                          icon: Icons.remove,
                          onTap: () => setState(() =>
                              _quantity = math.max(1, _quantity - 1)),
                        ),
                        Text('$_quantity unités',
                            style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 18,
                                color: ZADColors.textDark)),
                        _QuantityBtn(
                          icon: Icons.add,
                          onTap: () => setState(() => _quantity++),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // ── Heure ──
                  _SectionTitle(
                      icon: Icons.access_time,
                      label: 'Heure limite de collecte'),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: _pickTime,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 3)),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.access_time,
                                  color: ZADColors.primary, size: 20),
                              const SizedBox(width: 12),
                              Text(
                                '${_collecteTime.hour.toString().padLeft(2, '0')}:${_collecteTime.minute.toString().padLeft(2, '0')}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 22,
                                    color: ZADColors.textDark),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: ZADColors.primarySoft,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Text('Modifier',
                                style: TextStyle(
                                    color: ZADColors.primary,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // ── Urgence ──
                  _SectionTitle(
                      icon: Icons.bolt, label: "Niveau d'urgence"),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _UrgencyChip(
                          label: 'Faible',
                          color: ZADColors.success,
                          selected: _urgency == 'Faible',
                          onTap: () => setState(() => _urgency = 'Faible')),
                      const SizedBox(width: 10),
                      _UrgencyChip(
                          label: 'Moyen',
                          color: ZADColors.warning,
                          selected: _urgency == 'Moyen',
                          onTap: () => setState(() => _urgency = 'Moyen')),
                      const SizedBox(width: 10),
                      _UrgencyChip(
                          label: 'Haute',
                          color: ZADColors.danger,
                          selected: _urgency == 'Haute',
                          onTap: () => setState(() => _urgency = 'Haute')),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // ── Photo (حقيقية) ──
                  _SectionTitle(
                      icon: Icons.photo_camera_outlined,
                      label: 'Photo de confirmation (optionnel)'),
                  const SizedBox(height: 10),

                  if (_photoFile != null) ...[
                    ImagePreviewBox(
                      imageFile: _photoFile!,
                      onRemove: () => setState(() => _photoFile = null),
                      onReplace: _pickPhoto,
                    ),
                  ] else ...[
                    GestureDetector(
                      onTap: _pickPhoto,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: ZADColors.primaryLight.withOpacity(0.5),
                            width: 1.5,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: ZADColors.primarySoft),
                              ),
                              child: const Icon(Icons.camera_alt_outlined,
                                  color: ZADColors.primary, size: 22),
                            ),
                            const SizedBox(width: 16),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Photo de confirmation',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: ZADColors.textDark,
                                          fontSize: 14)),
                                  Text('Caméra ou galerie · optionnel',
                                      style: TextStyle(
                                          color: ZADColors.textLight,
                                          fontSize: 12)),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: ZADColors.primarySoft,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Text('Ajouter',
                                  style: TextStyle(
                                      color: ZADColors.primary,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 28),
                  ZADButton(
                    label: 'Publier le don',
                    icon: Icons.upload_rounded,
                    onTap: () =>
                        Navigator.pushNamed(context, '/my_dons'),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const ZADBottomNav(currentIndex: 2),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final IconData icon;
  final String label;
  const _SectionTitle({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: ZADColors.primary, size: 18),
        const SizedBox(width: 8),
        Text(label,
            style: const TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 15,
                color: ZADColors.textDark)),
      ],
    );
  }
}

class _QuantityBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _QuantityBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40, height: 40,
        decoration: BoxDecoration(
          color: ZADColors.primarySoft,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: ZADColors.primary, size: 20),
      ),
    );
  }
}

class _UrgencyChip extends StatelessWidget {
  final String label;
  final Color color;
  final bool selected;
  final VoidCallback onTap;
  const _UrgencyChip(
      {required this.label,
      required this.color,
      required this.selected,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: selected ? color.withOpacity(0.12) : Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
                color: selected ? color : ZADColors.divider,
                width: selected ? 2 : 1),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2)),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 10, height: 10,
                decoration:
                    BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              const SizedBox(width: 6),
              Text(label,
                  style: TextStyle(
                      color: selected ? color : ZADColors.textMedium,
                      fontWeight: selected
                          ? FontWeight.w700
                          : FontWeight.w500,
                      fontSize: 13)),
            ],
          ),
        ),
      ),
    );
  }
}