// ============================================================
// 📄 lib/screens/benevole/notifications_screen.dart
// ============================================================

import 'package:flutter/material.dart';

class BenevoleNotificationsScreen extends StatefulWidget {
  const BenevoleNotificationsScreen({super.key});

  @override
  State<BenevoleNotificationsScreen> createState() =>
      _BenevoleNotificationsScreenState();
}

class _BenevoleNotificationsScreenState
    extends State<BenevoleNotificationsScreen> {
  // ── Colors ───────────────────────────────────────────────
  static const _green     = Color(0xFF4CAF50);
  static const _greenDark = Color(0xFF388E3C);
  static const _greenBg   = Color(0xFFF1F8E9);
  static const _red       = Color(0xFFD32F2F);
  static const _divider   = Color(0xFFEEEEEE);
  static const _subText   = Color(0xFF757575);
  static const _textDark  = Color(0xFF1B1B1B);

  // ── Filter ───────────────────────────────────────────────
  String _activeFilter = 'Tout';

  // ── Notifications ────────────────────────────────────────
  final List<Map<String, dynamic>> _notifications = [
    {
      'icon': '🍽️',
      'iconBg': const Color(0xFFE8F5E9),
      'title': 'Nouveau don à 1,2 km de vous !',
      'body': 'Boulangerie Atlas · Pain 30 unités · ⏰ 1h30',
      'time': 'Il y a 3 min',
      'type': 'don',
      'unread': true,
    },
    {
      'icon': '⭐',
      'iconBg': const Color(0xFFFFF3E0),
      'title': 'El Fath vous a évalué ⭐ 4.9/5 !',
      'body': 'Félicitations ! +5 pts bonus ajoutés',
      'time': 'Il y a 1h',
      'type': 'evaluation',
      'unread': true,
    },
    {
      'icon': '✅',
      'iconBg': const Color(0xFFE8F5E9),
      'title': 'Mission terminée avec succès !',
      'body': '+15 pts ajoutés à votre score',
      'time': 'Hier 14h35',
      'type': 'mission',
      'unread': false,
    },
    {
      'icon': '🏅',
      'iconBg': const Color(0xFFF3E5F5),
      'title': 'Badge "Engagé" débloqué ! 🥈',
      'body': '20 missions réalisées · Continuez comme ça !',
      'time': 'Il y a 3 jours',
      'type': 'badge',
      'unread': false,
    },
    {
      'icon': '🎟️',
      'iconBg': const Color(0xFFFFFDE7),
      'title': 'Repas gratuit débloqué !',
      'body': 'Restaurant Al Assil · Valable jusqu\'au 15 mars',
      'time': 'Il y a 4 jours',
      'type': 'recompense',
      'unread': false,
    },
    {
      'icon': '⚠️',
      'iconBg': const Color(0xFFFFEBEE),
      'title': 'Rappel : évitez les annulations',
      'body': '3 annulations = avertissement de l\'admin',
      'time': 'Il y a 5 jours',
      'type': 'alerte',
      'unread': false,
    },
    {
      'icon': '🍽️',
      'iconBg': const Color(0xFFE8F5E9),
      'title': 'Don urgent à 2,1 km !',
      'body': 'Restaurant Le Zitoun · 15 portions · ⚡ 35 min',
      'time': 'Il y a 6 jours',
      'type': 'don',
      'unread': false,
    },
  ];

  List<Map<String, dynamic>> get _filtered {
    switch (_activeFilter) {
      case 'Non lus':
        return _notifications.where((n) => n['unread'] == true).toList();
      case '🍽️ Dons':
        return _notifications.where((n) => n['type'] == 'don').toList();
      case '🏅 Badges':
        return _notifications
            .where((n) => n['type'] == 'badge' || n['type'] == 'recompense')
            .toList();
      default:
        return _notifications;
    }
  }

  int get _unreadCount =>
      _notifications.where((n) => n['unread'] == true).length;

  void _markAllRead() {
    setState(() {
      for (var n in _notifications) {
        n['unread'] = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBF9),
      body: Column(
        children: [
          _buildHeader(),
          _buildFilterRow(),
          Expanded(
            child: _filtered.isEmpty
                ? _buildEmpty()
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    physics: const BouncingScrollPhysics(),
                    itemCount: _filtered.length,
                    itemBuilder: (_, i) {
                      final n = _filtered[i];
                      // Section label
                      final showSection = i == 0 ||
                          (_filtered[i]['unread'] != _filtered[i - 1]['unread']);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (showSection && n['unread'] == true)
                            _sectionLabel('NON LUS'),
                          if (showSection && n['unread'] == false &&
                              i > 0)
                            _sectionLabel('DÉJÀ LUS'),
                          _buildNotifCard(n),
                        ],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  // ── HEADER ───────────────────────────────────────────────
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
            child: Text('Notifications',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                )),
          ),
          if (_unreadCount > 0)
            GestureDetector(
              onTap: _markAllRead,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text('Tout lire',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 11,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    )),
              ),
            ),
        ],
      ),
    );
  }

  // ── FILTER ROW ───────────────────────────────────────────
  Widget _buildFilterRow() {
    final filters = ['Tout', 'Non lus', '🍽️ Dons', '🏅 Badges'];
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
            final isNonLus = filters[i] == 'Non lus';
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
                child: Row(
                  children: [
                    Text(filters[i],
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: active ? Colors.white : _subText,
                        )),
                    if (isNonLus && _unreadCount > 0) ...[
                      const SizedBox(width: 5),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 1),
                        decoration: BoxDecoration(
                          color: active
                              ? Colors.white.withOpacity(0.3)
                              : _red,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text('$_unreadCount',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                              color: active ? Colors.white : Colors.white,
                            )),
                      ),
                    ],
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // ── SECTION LABEL ────────────────────────────────────────
  Widget _sectionLabel(String label) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 6),
      child: Text(label,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 9,
            fontWeight: FontWeight.w600,
            color: _subText,
            letterSpacing: 0.5,
          )),
    );
  }

  // ── NOTIF CARD ───────────────────────────────────────────
  Widget _buildNotifCard(Map<String, dynamic> n) {
    final unread = n['unread'] as bool;
    return GestureDetector(
      onTap: () {
        setState(() => n['unread'] = false);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: unread
              ? _greenBg
              : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: unread ? _green.withOpacity(0.3) : _divider,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: unread
                  ? _green.withOpacity(0.08)
                  : Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon
            Container(
              width: 44, height: 44,
              decoration: BoxDecoration(
                color: n['iconBg'] as Color,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(n['icon'],
                    style: const TextStyle(fontSize: 20)),
              ),
            ),
            const SizedBox(width: 12),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(n['title'],
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        fontWeight: unread
                            ? FontWeight.w700
                            : FontWeight.w500,
                        color: _textDark,
                      )),
                  const SizedBox(height: 3),
                  Text(n['body'],
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 10,
                        color: _subText,
                        height: 1.4,
                      )),
                  const SizedBox(height: 5),
                  Text(n['time'],
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 9,
                        color: unread ? _green : _subText,
                        fontWeight: unread
                            ? FontWeight.w600
                            : FontWeight.w400,
                      )),
                ],
              ),
            ),
            // Unread dot
            if (unread)
              Container(
                width: 8, height: 8,
                margin: const EdgeInsets.only(top: 4),
                decoration: const BoxDecoration(
                  color: _green,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }

  // ── EMPTY STATE ──────────────────────────────────────────
  Widget _buildEmpty() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('🔔', style: TextStyle(fontSize: 48)),
          SizedBox(height: 12),
          Text('Aucune notification',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: _textDark,
              )),
          SizedBox(height: 6),
          Text('Vous êtes à jour !',
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