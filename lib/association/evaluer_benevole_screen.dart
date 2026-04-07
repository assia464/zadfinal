import 'package:flutter/material.dart';

class ZadColors {
  static const Color darkNavy = Color(0xFF1A2B4A);
  static const Color teal = Color(0xFF2E7D7D);
  static const Color leafGreen = Color(0xFF2E7D32);
  static const Color background = Color(0xFFFFFFFF);
  static const Color labelGrey = Color(0xFF6B7A8D);
  static const Color cardBg = Color(0xFFF5F7FA);
  static const Color textDark = Color(0xFF1A2B4A);
}

class EvaluerBenevoleScreen extends StatefulWidget {
  const EvaluerBenevoleScreen({super.key});

  @override
  State<EvaluerBenevoleScreen> createState() => _EvaluerBenevoleScreenState();
}

class _EvaluerBenevoleScreenState extends State<EvaluerBenevoleScreen> {
  int _noteGlobale = 4;
  int _notePonctualite = 5;
  int _noteSoin = 4;
  int _noteComportement = 4;
  final _commentaireController = TextEditingController();

  @override
  void dispose() {
    _commentaireController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    Navigator.pushNamedAndRemoveUntil(context, '/home', (r) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ZadColors.background,
      body: Column(
        children: [
          // ── Header ────────────────────────────────
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 52, 20, 24),
            decoration: const BoxDecoration(
              color: Color(0xFF1B5E20),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
            ),
            child: Column(
              children: [
                // Avatar
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.5),
                      width: 2,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'AH',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Évaluer ASSIA H.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Mission complétée · Pain 30 unités',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.75),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 8),

                  // ── Note globale ──────────────────
                  Text(
                    'Quelle note donnez-vous à ce bénévole ?',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: ZadColors.darkNavy,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (i) {
                      return GestureDetector(
                        onTap: () => setState(() => _noteGlobale = i + 1),
                        child: Icon(
                          i < _noteGlobale ? Icons.star : Icons.star_border,
                          color: const Color(0xFFFFB800),
                          size: 36,
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _noteLabel(_noteGlobale),
                    style: const TextStyle(
                      fontSize: 13,
                      color: ZadColors.labelGrey,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ── Critères ──────────────────────
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Critères d'évaluation :",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: ZadColors.darkNavy,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  _CritereRow(
                    label: 'Ponctualité',
                    note: _notePonctualite,
                    onChanged: (v) => setState(() => _notePonctualite = v),
                  ),
                  const SizedBox(height: 10),
                  _CritereRow(
                    label: 'Soin du don',
                    note: _noteSoin,
                    onChanged: (v) => setState(() => _noteSoin = v),
                  ),
                  const SizedBox(height: 10),
                  _CritereRow(
                    label: 'Comportement',
                    note: _noteComportement,
                    onChanged: (v) => setState(() => _noteComportement = v),
                  ),

                  const SizedBox(height: 20),

                  // ── Commentaire ───────────────────
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Commentaire (optionnel) :',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: ZadColors.darkNavy,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFFCCD6E0),
                        width: 1.2,
                      ),
                    ),
                    child: TextField(
                      controller: _commentaireController,
                      maxLines: 3,
                      style: const TextStyle(
                        fontSize: 14,
                        color: ZadColors.textDark,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Partagez votre expérience...',
                        hintStyle: TextStyle(
                          color: ZadColors.labelGrey.withOpacity(0.8),
                          fontSize: 13,
                        ),
                        filled: true,
                        fillColor: ZadColors.background,
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(14),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),

          // ── Submit button ─────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: _onSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ZadColors.leafGreen,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Soumettre l'évaluation",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _noteLabel(int note) {
    switch (note) {
      case 1:
        return 'Très mauvais — 1/5';
      case 2:
        return 'Mauvais — 2/5';
      case 3:
        return 'Moyen — 3/5';
      case 4:
        return 'Très bien — 4/5';
      case 5:
        return 'Excellent — 5/5';
      default:
        return '';
    }
  }
}

class _CritereRow extends StatelessWidget {
  final String label;
  final int note;
  final ValueChanged<int> onChanged;

  const _CritereRow({
    required this.label,
    required this.note,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: ZadColors.cardBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: ZadColors.darkNavy,
              ),
            ),
          ),
          Row(
            children: List.generate(5, (i) {
              return GestureDetector(
                onTap: () => onChanged(i + 1),
                child: Icon(
                  i < note ? Icons.star : Icons.star_border,
                  color: const Color(0xFFFFB800),
                  size: 22,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
