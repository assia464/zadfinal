// ============================================================
// 📄 lib/screens/benevole/badges_screen.dart
// ============================================================

import 'package:flutter/material.dart';
import 'coupon_qrcode_screen.dart';  // ✅ Import de la page QR code

class BenevoleBadgesScreen extends StatefulWidget {
  const BenevoleBadgesScreen({super.key});

  @override
  State<BenevoleBadgesScreen> createState() => _BenevoleBadgesScreenState();
}

class _BenevoleBadgesScreenState extends State<BenevoleBadgesScreen> {
  // ── Colors ───────────────────────────────────────────────
  static const _green     = Color(0xFF4CAF50);
  static const _greenDark = Color(0xFF388E3C);
  static const _greenBg   = Color(0xFFF1F8E9);
  static const _greenPale = Color(0xFFE8F5E9);
  static const _orange    = Color(0xFFFF8F00);
  static const _gold      = Color(0xFFF9A825);
  static const _goldBg    = Color(0xFFFFFDE7);
  static const _divider   = Color(0xFFEEEEEE);
  static const _subText   = Color(0xFF757575);
  static const _textDark  = Color(0xFF1B1B1B);

  // ── Filter ───────────────────────────────────────────────
  String _activeFilter = 'Tout';

  // ── Récompenses ──────────────────────────────────────────
  final List<Map<String, dynamic>> _recompenses = [
    {
      'icon': '🍲',
      'title': 'Repas complet offert',
      'partner': 'Restaurant Al Assil · Tlemcen',
      'type': 'meal',
      'code': 'ZAD-MEAL-25',
      'expiry': '15 mars 2025',
      'unlocked': true,
      'progress': 1.0,
      'progressLabel': '10/10 missions',
      'condition': '10 missions réalisées',
    },
    {
      'icon': '☕',
      'title': '30% sur votre commande',
      'partner': 'Café Bab El Qarmadine',
      'type': 'discount',
      'code': 'ZAD-30OFF',
      'expiry': '20 mars 2025',
      'unlocked': true,
      'progress': 1.0,
      'progressLabel': '5/5 missions',
      'condition': '5 missions réalisées',
    },
    {
      'icon': '🍕',
      'title': 'Pizza offerte',
      'partner': 'Pizza Casa · Boudghène',
      'type': 'meal',
      'code': '',
      'expiry': '',
      'unlocked': false,
      'progress': 0.75,
      'progressLabel': '15/20 missions',
      'condition': 'Encore 5 missions pour débloquer',
    },
    {
      'icon': '🍰',
      'title': 'Dessert + boisson offerts',
      'partner': 'Pâtisserie Nour · Imama',
      'type': 'meal',
      'code': '',
      'expiry': '',
      'unlocked': false,
      'progress': 0.49,
      'progressLabel': '245/500 pts',
      'condition': 'Atteindre le niveau Champion 🥇',
    },
  ];

  // ── Niveaux ───────────────────────────────────────────────
  final List<Map<String, dynamic>> _niveaux = [
    {'emoji': '🥉', 'name': 'Débutant',  'pts': '0–99',    'done': true,    'current': false},
    {'emoji': '🥈', 'name': 'Engagé',    'pts': '100–499', 'done': false,   'current': true},
    {'emoji': '🥇', 'name': 'Champion',  'pts': '500–999', 'done': false,   'current': false},
    {'emoji': '⭐', 'name': 'Légende',   'pts': '1000+',   'done': false,   'current': false},
  ];

  List<Map<String, dynamic>> get _filtered {
    switch (_activeFilter) {
      case '🍽️ Repas':
        return _recompenses.where((r) => r['type'] == 'meal').toList();
      case '🏷️ Réductions':
        return _recompenses.where((r) => r['type'] == 'discount').toList();
      case '🔒 À débloquer':
        return _recompenses.where((r) => r['unlocked'] == false).toList();
      default:
        return _recompenses;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBF9),
      body: Column(
        children: [
          _buildHero(),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  _buildNiveaux(),
                  _buildFilterRow(),
                  _buildRecompensesList(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── HERO SCORE ───────────────────────────────────────────
  Widget _buildHero() {
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
        bottom: 20,
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
              const SizedBox(width: 12),
              const Expanded(
                child: Text('Badges & Récompenses',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
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
                child: const Text('🥈 Engagé',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 11,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    )),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('⭐ 245 pts',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        )),
                    Text('Vos points de bénévolat',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 11,
                          color: Colors.white70,
                        )),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('28 missions',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      )),
                  Text('340 kg sauvés',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 11,
                        color: Colors.white70,
                      )),
                  Text('⭐ 4.9 / 5',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 11,
                        color: Colors.white70,
                      )),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: LinearProgressIndicator(
                  value: 0.49,
                  backgroundColor: Colors.white.withOpacity(0.2),
                  valueColor: const AlwaysStoppedAnimation<Color>(
                      Colors.white),
                  minHeight: 8,
                ),
              ),
              const SizedBox(height: 6),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('245 / 500 pts',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 9,
                        color: Colors.white60,
                      )),
                  Text('255 pts pour 🥇 Champion',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 9,
                        color: Colors.white60,
                      )),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── NIVEAUX ───────────────────────────────────────────────
  Widget _buildNiveaux() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Niveaux',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: _textDark,
              )),
          const SizedBox(height: 10),
          SizedBox(
            height: 90,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _niveaux.length,
              itemBuilder: (_, i) {
                final n = _niveaux[i];
                final isCurrent = n['current'] as bool;
                final isDone    = n['done'] as bool;
                final isLocked  = !isCurrent && !isDone;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 80,
                  margin: const EdgeInsets.only(right: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isCurrent ? _greenPale : Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isCurrent ? _green : _divider,
                      width: isCurrent ? 2 : 1.5,
                    ),
                    boxShadow: isCurrent
                        ? [BoxShadow(
                            color: _green.withOpacity(0.2),
                            blurRadius: 8,
                          )]
                        : [],
                  ),
                  child: Opacity(
                    opacity: isLocked ? 0.45 : 1.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(n['emoji'],
                            style: const TextStyle(fontSize: 22)),
                        const SizedBox(height: 4),
                        Text(n['name'],
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                              color: isCurrent
                                  ? _greenDark
                                  : _textDark,
                            )),
                        Text(n['pts'],
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 8,
                              color: _subText,
                            )),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ── FILTER ROW ───────────────────────────────────────────
  Widget _buildFilterRow() {
    final filters = ['Tout', '🍽️ Repas', '🏷️ Réductions', '🔒 À débloquer'];
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

  // ── RÉCOMPENSES LIST ─────────────────────────────────────
  Widget _buildRecompensesList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
          child: Row(
            children: [
              Container(
                width: 4, height: 18,
                decoration: BoxDecoration(
                  color: _green,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 8),
              const Text('Mes récompenses',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: _textDark,
                  )),
            ],
          ),
        ),
        ..._filtered.map((r) => _buildRecompenseCard(r)),
      ],
    );
  }

  Widget _buildRecompenseCard(Map<String, dynamic> r) {
    final unlocked = r['unlocked'] as bool;
    final isMeal   = r['type'] == 'meal';

    Color borderColor = unlocked
        ? (isMeal ? _gold : _green)
        : _divider;

    return Opacity(
      opacity: unlocked ? 1.0 : 0.7,
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: borderColor, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: borderColor.withOpacity(0.15),
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
                gradient: LinearGradient(
                  colors: unlocked
                      ? (isMeal
                          ? [_gold, const Color(0xFFFBC02D)]
                          : [_greenDark, _green])
                      : [_divider, _divider],
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 54, height: 54,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: unlocked
                                ? (isMeal
                                    ? [_goldBg, const Color(0xFFFFF9C4)]
                                    : [_greenPale, _greenBg])
                                : [
                                    const Color(0xFFF5F5F5),
                                    const Color(0xFFEEEEEE),
                                  ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Center(
                          child: Text(r['icon'],
                              style: TextStyle(
                                fontSize: 26,
                                color: unlocked
                                    ? null
                                    : Colors.grey,
                              )),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(r['title'],
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: _textDark,
                                )),
                            const SizedBox(height: 2),
                            Text(r['partner'],
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 10,
                                  color: _subText,
                                )),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: unlocked
                              ? (isMeal ? _goldBg : _greenPale)
                              : const Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          unlocked
                              ? (isMeal
                                  ? '🍽️ Gratuit'
                                  : '🏷️ -30%')
                              : '🔒 Bientôt',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            color: unlocked
                                ? (isMeal ? _gold : _greenDark)
                                : _subText,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9FBF9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: unlocked
                        ? Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets
                                      .symmetric(
                                      horizontal: 10,
                                      vertical: 6),
                                  decoration: BoxDecoration(
                                    color: isMeal
                                        ? _goldBg
                                        : _greenPale,
                                    borderRadius:
                                        BorderRadius.circular(8),
                                    border: Border.all(
                                      color: isMeal
                                          ? _gold
                                          : _green,
                                      width: 1,
                                      style: BorderStyle.solid,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize:
                                        MainAxisSize.min,
                                    children: [
                                      const Text('🎟️',
                                          style: TextStyle(
                                              fontSize: 12)),
                                      const SizedBox(width: 6),
                                      Text(r['code'],
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 11,
                                            fontWeight:
                                                FontWeight.w700,
                                            color: isMeal
                                                ? _gold
                                                : _greenDark,
                                            letterSpacing: 1,
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              GestureDetector(
                                onTap: () {
                                  _showCouponDialog(r);
                                },
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(
                                          horizontal: 14,
                                          vertical: 8),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: isMeal
                                          ? [_gold,
                                              const Color(
                                                  0xFFFBC02D)]
                                          : [_greenDark, _green],
                                    ),
                                    borderRadius:
                                        BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: (isMeal
                                                ? _gold
                                                : _green)
                                            .withOpacity(0.35),
                                        blurRadius: 8,
                                        offset:
                                            const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: const Text('Utiliser →',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 11,
                                        fontWeight:
                                            FontWeight.w600,
                                        color: Colors.white,
                                      )),
                                ),
                              ),
                            ],
                          )
                        : Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(r['condition'],
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 10,
                                    color: _subText,
                                  )),
                              const SizedBox(height: 6),
                              ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(4),
                                child: LinearProgressIndicator(
                                  value: r['progress'] as double,
                                  backgroundColor: _divider,
                                  valueColor:
                                      const AlwaysStoppedAnimation<
                                          Color>(_orange),
                                  minHeight: 6,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(r['progressLabel'],
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 9,
                                    color: _subText,
                                  )),
                            ],
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── COUPON DIALOG (MODIFIÉ AVEC NAVIGATION VERS QR CODE) ──
  void _showCouponDialog(Map<String, dynamic> r) {
    final isMeal = r['type'] == 'meal';
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle
            Container(
              width: 40, height: 4,
              decoration: BoxDecoration(
                color: _divider,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            
            // Preview QR Code
            Container(
              width: 80, height: 80,
              decoration: BoxDecoration(
                color: isMeal ? _goldBg : _greenPale,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Icon(Icons.qr_code_scanner,
                    size: 40, color: isMeal ? _gold : _green),
              ),
            ),
            
            const SizedBox(height: 16),
            
            Text(r['title'],
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: _textDark,
                )),
            const SizedBox(height: 4),
            Text(r['partner'],
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  color: _subText,
                )),
            
            const SizedBox(height: 16),
            
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isMeal ? _goldBg : _greenPale,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(r['code'],
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: isMeal ? _gold : _greenDark,
                    letterSpacing: 2,
                  )),
            ),
            
            const SizedBox(height: 8),
            
            Text('Valable jusqu\'au ${r['expiry']}',
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 10,
                  color: _subText,
                )),
            
            const SizedBox(height: 20),
            
            // Bouton Voir le QR code
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CouponQRCodeScreen(
                        title: r['title'],
                        partner: r['partner'],
                        code: r['code'],
                        expiry: r['expiry'],
                        type: r['type'],
                        missionsCompleted: 10,
                        kgSaved: 120,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isMeal ? _gold : _green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  '📱 Afficher le QR code',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 12),
            
            // Bouton fermer
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Fermer',
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
}