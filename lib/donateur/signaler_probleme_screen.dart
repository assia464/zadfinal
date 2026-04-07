import 'package:flutter/material.dart';
import '../main.dart';

class SignalerProblemeScreen extends StatefulWidget {
  const SignalerProblemeScreen({super.key});

  @override
  State<SignalerProblemeScreen> createState() => _SignalerProblemeScreenState();
}

class _SignalerProblemeScreenState extends State<SignalerProblemeScreen> {
  String? _selectedProblemType;
  final TextEditingController _descriptionController = TextEditingController();

  final List<String> _problemTypes = [
    'Bénévole non présent',
    'Bénévole en retard',
    'Problème avec le don',
    'Problème de communication',
    'Autre problème',
  ];

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
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
                      child: Text(
                        'Signaler un problème',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w800),
                      ),
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
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: ZADColors.primarySoft,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: ZADColors.primary.withOpacity(0.3),
                      ),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.warning_amber_rounded,
                            color: ZADColors.warning, size: 24),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Veuillez décrire précisément le problème rencontré. Nous ferons le nécessaire pour vous aider.',
                            style: TextStyle(
                              color: ZADColors.textDark,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Type de problème',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: ZADColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ..._problemTypes.map((type) {
                    final isSelected = _selectedProblemType == type;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedProblemType = type;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                        decoration: BoxDecoration(
                          color: isSelected ? ZADColors.primarySoft : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected ? ZADColors.primary : ZADColors.divider,
                            width: 1.5,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 22,
                              height: 22,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isSelected ? ZADColors.primary : Colors.transparent,
                                border: Border.all(
                                  color: isSelected ? ZADColors.primary : ZADColors.divider,
                                  width: 2,
                                ),
                              ),
                              child: isSelected
                                  ? const Icon(Icons.check,
                                      color: Colors.white, size: 12)
                                  : null,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                type,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.w500,
                                  color: isSelected
                                      ? ZADColors.primary
                                      : ZADColors.textDark,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: 20),
                  const Text(
                    'Description du problème',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: ZADColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: ZADColors.divider, width: 1.5),
                    ),
                    child: TextField(
                      controller: _descriptionController,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        hintText: 'Décrivez le problème en détail...',
                        hintStyle: TextStyle(color: ZADColors.textLight, fontSize: 13),
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(fontSize: 13, color: ZADColors.textDark),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: ZADColors.primarySoft,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.info_outline, color: ZADColors.primary, size: 18),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Une notification sera envoyée à l\'équipe ZAD. Nous vous contacterons dans les plus brefs délais.',
                            style: TextStyle(
                              color: ZADColors.primary,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),
                  Row(
                    children: [
                      Expanded(
                        child: ZADButton(
                          label: 'Annuler',
                          onTap: () => Navigator.pop(context),
                          outlined: true,
                          color: ZADColors.textMedium,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ZADButton(
                          label: 'Envoyer',
                          icon: Icons.send,
                          onTap: () {
                            if (_selectedProblemType == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Veuillez sélectionner un type de problème'),
                                  backgroundColor: Colors.red,
                                  duration: Duration(seconds: 2),
                                ),
                              );
                              return;
                            }
                            if (_descriptionController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Veuillez décrire le problème'),
                                  backgroundColor: Colors.red,
                                  duration: Duration(seconds: 2),
                                ),
                              );
                              return;
                            }
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Votre signalement a été envoyé avec succès'),
                                backgroundColor: ZADColors.success,
                                duration: Duration(seconds: 2),
                              ),
                            );
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}