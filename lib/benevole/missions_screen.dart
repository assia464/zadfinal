// ============================================================
// 📄 lib/screens/benevole/missions_screen.dart
// ============================================================

import 'package:flutter/material.dart';
import 'evaluate_association_screen.dart';
import 'evaluate_donor_screen.dart';

class BenevoleMissionsScreen extends StatefulWidget {
  const BenevoleMissionsScreen({super.key});

  @override
  State<BenevoleMissionsScreen> createState() =>
      _BenevoleMissionsScreenState();
}

class _BenevoleMissionsScreenState
    extends State<BenevoleMissionsScreen> {
  static const _green     = Color(0xFF4CAF50);
  static const _greenDark = Color(0xFF388E3C);
  static const _greenPale = Color(0xFFE8F5E9);
  static const _orange    = Color(0xFFFF8F00);
  static const _blue      = Color(0xFF1565C0);
  static const _blueBg    = Color(0xFFE3F2FD);
  static const _red       = Color(0xFFD32F2F);
  static const _redBg     = Color(0xFFFFEBEE);
  static const _divider   = Color(0xFFEEEEEE);
  static const _subText   = Color(0xFF757575);
  static const _textDark  = Color(0xFF1B1B1B);

  String _activeFilter = 'Toutes';

  final List<Map<String, dynamic>> _missions = [
    {
      'icon': '🍞',
      'title': 'Pain — Boulangerie Atlas',
      'assoc': 'Association El Fath · 30 unités',
      'associationName': 'Association El Fath',
      'donorName': 'Boulangerie Atlas',
      'quantity': '30 unités',
      'status': 'en_cours',
      'statusLabel': 'En route vers association',
      'pts': '+15 pts',
      'date': "Aujourd'hui",
    },
    {
      'icon': '🍲',
      'title': 'Repas — Restaurant Zitoun',
      'assoc': 'Association El Fath · 15 portions',
      'associationName': 'Association El Fath',
      'donorName': 'Restaurant Zitoun',
      'quantity': '15 portions',
      'status': 'termine',
      'statusLabel': 'Livré hier à 14h35',
      'pts': '+15 pts',
      'date': 'Hier',
    },
    {
      'icon': '🥦',
      'title': 'Légumes — Marché Central',
      'assoc': 'Association Nour · 8 kg',
      'associationName': 'Association Nour',
      'donorName': 'Marché Central',
      'quantity': '8 kg',
      'status': 'termine',
      'statusLabel': 'Livré il y a 3 jours',
      'pts': '+10 pts',
      'date': 'Il y a 3j',
    },
    {
      'icon': '🍰',
      'title': 'Pâtisseries — Nour Sweets',
      'assoc': 'Association Rahma · 20 pièces',
      'associationName': 'Association Rahma',
      'donorName': 'Nour Sweets',
      'quantity': '20 pièces',
      'status': 'termine',
      'statusLabel': 'Livré il y a 5 jours',
      'pts': '+12 pts',
      'date': 'Il y a 5j',
    },
    {
      'icon': '🍞',
      'title': 'Pain — Atlas',
      'assoc': 'Association El Fath · 10 unités',
      'associationName': 'Association El Fath',
      'donorName': 'Boulangerie Atlas',
      'quantity': '10 unités',
      'status': 'annule',
      'statusLabel': 'Annulée · Avertissement reçu',
      'pts': '−5 pts',
      'date': 'Il y a 7j',
    },
  ];

  List<Map<String, dynamic>> get _filtered {
    switch (_activeFilter) {
      case '🔄 En cours':
        return _missions.where((m) => m['status'] == 'en_cours').toList();
      case '✅ Terminées':
        return _missions.where((m) => m['status'] == 'termine').toList();
      case '❌ Annulées':
        return _missions.where((m) => m['status'] == 'annule').toList();
      default:
        return _missions;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBF9),
      body: Column(
        children: [
          _buildHeader(),
          _buildStats(),
          _buildFilterRow(),
          Expanded(
            child: _filtered.isEmpty
                ? _buildEmpty()
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    physics: const BouncingScrollPhysics(),
                    itemCount: _filtered.length,
                    itemBuilder: (_, i) => _buildMissionCard(_filtered[i]),
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
            color: Color(0x554CAF50),
            blurRadius: 16,
            offset: Offset(0, 6),
          ),
        ],
      ),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 12,
        bottom: 18,
        left: 18,
        right: 18,
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
            child: Text('Mes missions',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                )),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              '${_missions.length} total',
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 11,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStats() {
    final termine = _missions.where((m) => m['status'] == 'termine').length;
    final enCours = _missions.where((m) => m['status'] == 'en_cours').length;
    final annule  = _missions.where((m) => m['status'] == 'annule').length;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          _statItem('✅', '$termine', 'Terminées', _green),
          _dividerV(),
          _statItem('🔄', '$enCours', 'En cours', _blue),
          _dividerV(),
          _statItem('❌', '$annule', 'Annulées', _red),
          _dividerV(),
          _statItem('⭐', '245', 'Points', _orange),
        ],
      ),
    );
  }

  Widget _statItem(String icon, String val, String label, Color color) {
    return Expanded(
      child: Column(
        children: [
          Text(icon, style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 3),
          Text(val,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: color,
              )),
          Text(label,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 9,
                color: _subText,
              )),
        ],
      ),
    );
  }

  Widget _dividerV() {
    return Container(
      width: 1, height: 40,
      color: _divider,
      margin: const EdgeInsets.symmetric(horizontal: 4),
    );
  }

  Widget _buildFilterRow() {
    final filters = ['Toutes', '🔄 En cours', '✅ Terminées', '❌ Annulées'];
    return Padding(
      padding: const EdgeInsets.only(top: 14),
      child: SizedBox(
        height: 38,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: filters.length,
          itemBuilder: (_, i) {
            final active = _activeFilter == filters[i];
            return GestureDetector(
              onTap: () => setState(() => _activeFilter = filters[i]),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 7),
                decoration: BoxDecoration(
                  gradient: active
                      ? const LinearGradient(
                          colors: [_greenDark, _green])
                      : null,
                  color: active ? null : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: active ? _green : _divider,
                    width: 1.5,
                  ),
                  boxShadow: active
                      ? [BoxShadow(
                          color: _green.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        )]
                      : [],
                ),
                child: Text(filters[i],
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: active ? Colors.white : _subText,
                    )),
              ),
            );
          },
        ),
      ),
    );
  }

  // ── MISSION CARD (MODIFIÉ - avec bouton Évaluer pour les missions terminées) ────
  Widget _buildMissionCard(Map<String, dynamic> m) {
    final status    = m['status'] as String;
    final isEnCours = status == 'en_cours';
    final isAnnule  = status == 'annule';
    final isTermine = status == 'termine';

    Color borderColor = _green;
    Color statusColor = _green;
    Color statusBg    = _greenPale;
    IconData statusIcon = Icons.check_circle;

    if (isEnCours) {
      borderColor = _blue;
      statusColor = _blue;
      statusBg    = _blueBg;
      statusIcon  = Icons.sync;
    } else if (isAnnule) {
      borderColor = _red;
      statusColor = _red;
      statusBg    = _redBg;
      statusIcon  = Icons.cancel;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: borderColor.withOpacity(0.1),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 4,
            decoration: BoxDecoration(
              color: borderColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                // Icon
                Container(
                  width: 52, height: 52,
                  decoration: BoxDecoration(
                    color: isAnnule
                        ? _redBg
                        : isEnCours
                            ? _blueBg
                            : _greenPale,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Center(
                    child: Text(m['icon'],
                        style: const TextStyle(fontSize: 26)),
                  ),
                ),
                const SizedBox(width: 12),
                
                // Info principale
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(m['title'],
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: _textDark,
                          )),
                      const SizedBox(height: 2),
                      Text(m['assoc'],
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 10,
                            color: _subText,
                          )),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: statusBg,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(statusIcon,
                                color: statusColor, size: 11),
                            const SizedBox(width: 4),
                            Text(m['statusLabel'],
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 9,
                                  fontWeight: FontWeight.w600,
                                  color: statusColor,
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Points, date et bouton Évaluer
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(m['pts'],
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: isAnnule ? _red : _green,
                        )),
                    const SizedBox(height: 4),
                    Text(m['date'],
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 9,
                          color: _subText,
                        )),
                    
                    // ✅ BOUTON ÉVALUER (uniquement pour les missions terminées)
                    if (isTermine) ...[
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: () {
                          _showEvaluationDialog(m);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 5),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFFF9A825), Color(0xFFFF8F00)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFFF8F00).withOpacity(0.3),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.star, color: Colors.white, size: 12),
                              SizedBox(width: 4),
                              Text('Évaluer',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ✅ Dialogue de choix entre évaluer l'association ou le donateur
  void _showEvaluationDialog(Map<String, dynamic> mission) {
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
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Évaluer votre expérience',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: _textDark,
                )),
            const SizedBox(height: 8),
            Text('Mission : ${mission['title']}',
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  color: _subText,
                )),
            const SizedBox(height: 20),
            
            // Bouton Évaluer l'association
            GestureDetector(
              onTap: () {
                Navigator.pop(ctx);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EvaluateAssociationScreen(
                      associationName: mission['associationName'],
                      missionTitle: mission['title'],
                      quantity: mission['quantity'],
                    ),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _greenPale,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: _green, width: 1),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 50, height: 50,
                      decoration: BoxDecoration(
                        color: _green,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Icon(Icons.people, color: Colors.white, size: 28),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Évaluer l\'association',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: _textDark,
                              )),
                          Text(mission['associationName'],
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 11,
                                color: _subText,
                              )),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios, size: 16, color: _subText),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 12),
            
            // Bouton Évaluer le donateur
            GestureDetector(
              onTap: () {
                Navigator.pop(ctx);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EvaluateDonorScreen(
                      donorName: mission['donorName'],
                      missionTitle: mission['title'],
                      quantity: mission['quantity'],
                    ),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _blueBg,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: _blue, width: 1),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 50, height: 50,
                      decoration: BoxDecoration(
                        color: _blue,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Icon(Icons.store, color: Colors.white, size: 28),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Évaluer le donateur',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: _textDark,
                              )),
                          Text(mission['donorName'],
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 11,
                                color: _subText,
                              )),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios, size: 16, color: _subText),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Annuler',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13,
                    color: _subText,
                  )),
            ),
            
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('📋', style: TextStyle(fontSize: 48)),
          SizedBox(height: 12),
          Text('Aucune mission',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: _textDark,
              )),
          SizedBox(height: 6),
          Text('Pas de mission dans cette catégorie',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                color: _subText,
              )),
        ],
      ),
    );
  }
}