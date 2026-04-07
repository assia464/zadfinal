import 'package:flutter/material.dart';
import '../main.dart';
import 'home_screen.dart'; 

class EvaluateVolunteerScreen extends StatefulWidget {
  final String volunteerName;
  final String volunteerInitials;
  final double currentRating;

  const EvaluateVolunteerScreen({
    super.key,
    required this.volunteerName,
    required this.volunteerInitials,
    required this.currentRating,
  });

  @override
  State<EvaluateVolunteerScreen> createState() => _EvaluateVolunteerScreenState();
}

class _EvaluateVolunteerScreenState extends State<EvaluateVolunteerScreen> {
  int _globalRating = 5;
  int _ponctuality = 5;
  int _soin = 5;
  int _comportement = 5;
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ZADColors.background,
      body: Column(
        children: [
          // رأس الصفحة - مستطيل أخضر ممتد بالكامل
          Container(
            width: double.infinity,
            color: ZADColors.headerBg,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                child: Column(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                          color: ZADColors.primaryLight,
                          borderRadius: BorderRadius.circular(16)),
                      child: Center(
                          child: Text(widget.volunteerInitials,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 20))),
                    ),
                    const SizedBox(height: 10),
                    Text('Évaluer ${widget.volunteerName}',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w800)),
                    const Text("Collecte · Pain 30 unités · Aujourd'hui",
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Note globale du bénévole',
                      style: TextStyle(
                          color: ZADColors.textMedium,
                          fontSize: 14,
                          fontWeight: FontWeight.w500)),
                  const SizedBox(height: 12),
                  _StarRating(
                      rating: _globalRating,
                      size: 36,
                      onChanged: (v) =>
                          setState(() => _globalRating = v)),
                  const SizedBox(height: 6),
                  Text(
                    '${_getRatingText(_globalRating)} — $_globalRating/5 ⭐',
                    style: const TextStyle(
                        color: ZADColors.textMedium,
                        fontWeight: FontWeight.w600,
                        fontSize: 14),
                  ),
                  const SizedBox(height: 24),
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Critères :',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              color: ZADColors.textDark))),
                  const SizedBox(height: 12),
                  _CriteriaRow(
                      icon: Icons.access_time,
                      label: 'Ponctualité',
                      rating: _ponctuality,
                      onChanged: (v) =>
                          setState(() => _ponctuality = v)),
                  const SizedBox(height: 10),
                  _CriteriaRow(
                      icon: Icons.volunteer_activism,
                      label: 'Soin du don',
                      rating: _soin,
                      onChanged: (v) => setState(() => _soin = v)),
                  const SizedBox(height: 10),
                  _CriteriaRow(
                      icon: Icons.sentiment_satisfied_alt,
                      label: 'Comportement',
                      rating: _comportement,
                      onChanged: (v) =>
                          setState(() => _comportement = v)),
                  const SizedBox(height: 20),
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Commentaire :',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              color: ZADColors.textDark))),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 3))
                      ],
                    ),
                    child: TextField(
                      controller: _commentController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Très ponctuel et professionnel...',
                        hintStyle: TextStyle(
                            color: ZADColors.textLight, fontSize: 14),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: ZADColors.primarySoft,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      children: [
                        Text('🏆', style: TextStyle(fontSize: 18)),
                        SizedBox(width: 8),
                        Expanded(
                            child: Text(
                                'Votre évaluation aide Karim à gagner des badges !',
                                style: TextStyle(
                                    color: ZADColors.primary,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13))),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  ZADButton(
                      label: "Soumettre l'évaluation",
                      icon: Icons.star,
                      onTap: () {
                        _submitEvaluation(context);
                      },
                      color: ZADColors.primary),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () {
                      // ✅ العودة إلى HomeScreen مباشرة
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const HomeScreen()),
                        (route) => false,
                      );
                    },
                    child: const Center(
                        child: Text('Ignorer',
                            style: TextStyle(
                                color: ZADColors.textLight,
                                fontSize: 14,
                                fontWeight: FontWeight.w500))),
                  ),
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

  String _getRatingText(int rating) {
    switch (rating) {
      case 5:
        return 'Excellent';
      case 4:
        return 'Très bien';
      case 3:
        return 'Bien';
      case 2:
        return 'Moyen';
      default:
        return 'Faible';
    }
  }

  void _submitEvaluation(BuildContext context) {
    final double avgRating = (_globalRating + _ponctuality + _soin + _comportement) / 4;
    
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text('Merci !',
            style: TextStyle(
                fontWeight: FontWeight.w800, color: ZADColors.primary)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.thumb_up, size: 48, color: ZADColors.primary),
            const SizedBox(height: 12),
            Text(
              'Vous avez évalué ${widget.volunteerName}',
              style: const TextStyle(fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Note: ${avgRating.toStringAsFixed(1)}/5 ⭐',
              style: const TextStyle(color: ZADColors.primary),
            ),
            const SizedBox(height: 8),
            const Text(
              'Votre évaluation a été enregistrée !',
              style: TextStyle(color: ZADColors.textMedium, fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx); // إغلاق الـ Dialog
              // ✅ العودة إلى HomeScreen بعد التقييم
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
                (route) => false,
              );
            },
            child: const Text('Fermer',
                style: TextStyle(color: ZADColors.primary)),
          ),
        ],
      ),
    );
  }
}

class _StarRating extends StatelessWidget {
  final int rating;
  final double size;
  final ValueChanged<int>? onChanged;

  const _StarRating(
      {required this.rating, this.size = 24, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) {
        return GestureDetector(
          onTap: onChanged != null ? () => onChanged!(i + 1) : null,
          child: Icon(
            i < rating
                ? Icons.star_rounded
                : Icons.star_outline_rounded,
            color: i < rating
                ? ZADColors.accentYellow
                : ZADColors.divider,
            size: size,
          ),
        );
      }),
    );
  }
}

class _CriteriaRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final int rating;
  final ValueChanged<int> onChanged;

  const _CriteriaRow(
      {required this.icon,
      required this.label,
      required this.rating,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2))
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: ZADColors.primaryLight, size: 18),
              const SizedBox(width: 8),
              Text(label,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: ZADColors.textDark,
                      fontSize: 14)),
            ],
          ),
          _StarRating(rating: rating, size: 20, onChanged: onChanged),
        ],
      ),
    );
  }
}