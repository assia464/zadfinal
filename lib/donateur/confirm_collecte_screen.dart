import 'dart:io';
import 'package:flutter/material.dart';
import '../main.dart';

// ─────────────────────────────────────────────
// SCREEN 13: CONFIRM COLLECTE
// MODIFIED: image_picker حقيقي — تظهر الصورة في التطبيق
// ─────────────────────────────────────────────
class ConfirmCollecteScreen extends StatefulWidget {
  const ConfirmCollecteScreen({super.key});

  @override
  State<ConfirmCollecteScreen> createState() =>
      _ConfirmCollecteScreenState();
}

class _ConfirmCollecteScreenState extends State<ConfirmCollecteScreen> {
  File? _confirmPhoto;

  Future<void> _pickConfirmPhoto() async {
    final file = await showImagePickerSheet(
      context,
      title: 'Photo de confirmation',
    );
    if (file != null) setState(() => _confirmPhoto = file);
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
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
                child: Column(
                  children: [
                    Container(
                      width: 52, height: 52,
                      decoration: BoxDecoration(
                          color: ZADColors.primaryLight,
                          borderRadius: BorderRadius.circular(14)),
                      child: const Center(
                          child: Text('🍞',
                              style: TextStyle(fontSize: 26))),
                    ),
                    const SizedBox(height: 10),
                    const Text('Confirmer la collecte',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w800)),
                    const Text('Pain 30 unités · Karim Mansouri',
                        style: TextStyle(
                            color: Colors.white60, fontSize: 12)),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // ── Résumé ──
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 3))
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: ZADColors.primarySoft,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text('RÉSUMÉ DU DON',
                              style: TextStyle(
                                  color: ZADColors.primary,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 11,
                                  letterSpacing: 1)),
                        ),
                        const SizedBox(height: 16),
                        _SummaryRow(
                            label: 'Produit',
                            value: 'Pain & Viennoiseries'),
                        _SummaryRow(
                            label: 'Quantité', value: '30 unités'),
                        _SummaryRow(
                            label: 'Bénévole',
                            value: 'Karim Mansouri · ⭐4.9'),
                        _SummaryRow(
                            label: 'Heure',
                            value: 'Collecté à 14h28'),
                        _SummaryRow(
                          label: 'Destination',
                          value: 'Association El Fath',
                          isLast: true,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // ── Photo de confirmation (حقيقية) ──
                  if (_confirmPhoto != null) ...[
                    ImagePreviewBox(
                      imageFile: _confirmPhoto!,
                      onRemove: () =>
                          setState(() => _confirmPhoto = null),
                      onReplace: _pickConfirmPhoto,
                    ),
                  ] else ...[
                    GestureDetector(
                      onTap: _pickConfirmPhoto,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: ZADColors.primarySoft,
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
                              ),
                              child: const Icon(Icons.camera_alt_outlined,
                                  color: ZADColors.primary, size: 22),
                            ),
                            const SizedBox(width: 16),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      'Photo de confirmation (optionnel)',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: ZADColors.textDark,
                                          fontSize: 14)),
                                  Text(
                                      'Prenez le bénévole avec le don',
                                      style: TextStyle(
                                          color: ZADColors.textLight,
                                          fontSize: 12)),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                color: ZADColors.primary,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Text('Ajouter',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 16),

                  // ── Points badge ──
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: ZADColors.primarySoft,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                          color: ZADColors.accent.withOpacity(0.4)),
                    ),
                    child: const Row(
                      children: [
                        Text('🏆', style: TextStyle(fontSize: 18)),
                        SizedBox(width: 10),
                        Expanded(
                            child: Text(
                                "Karim gagnera +10 pts et pourra évaluer votre don.\nVous pourrez aussi l'évaluer !",
                                style: TextStyle(
                                    color: ZADColors.primary,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12))),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  ZADButton(
                    label: 'Confirmer la collecte',
                    icon: Icons.check_circle_outline,
                    onTap: () =>
                        Navigator.pushNamed(context, '/evaluate'),
                  ),
                  const SizedBox(height: 12),
                  ZADButton(
                    label: 'Signaler un problème',
                    icon: Icons.warning_amber_rounded,
                    onTap: () {},
                    color: ZADColors.danger,
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const ZADBottomNav(currentIndex: 1),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isLast;

  const _SummaryRow(
      {required this.label, required this.value, this.isLast = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label,
                  style: const TextStyle(
                      color: ZADColors.textMedium,
                      fontSize: 13,
                      fontWeight: FontWeight.w500)),
              Text(value,
                  style: const TextStyle(
                      color: ZADColors.textDark,
                      fontSize: 13,
                      fontWeight: FontWeight.w700)),
            ],
          ),
        ),
        if (!isLast)
          const Divider(height: 1, color: ZADColors.divider),
      ],
    );
  }
}