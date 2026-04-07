import 'package:flutter/material.dart';
import '../main.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() =>
      _NotificationsScreenState();
}

class _NotificationsScreenState
    extends State<NotificationsScreen> {
  int _selectedFilter = 0;

  final List<Map<String, dynamic>> _allNotifications = [
    {
      'icon': Icons.directions_car,
      'iconBg': ZADColors.primarySoft,
      'iconColor': ZADColors.primary,
      'title': 'Karim est en route pour collecter !',
      'sub': 'Pain 30 unités · Arrive dans ~8 min',
      'time': 'Il y a 2 min',
      'unread': true,
      'type': 'benevole',
    },
    {
      'icon': Icons.star,
      'iconBg': Color(0xFFFFF8E1),
      'iconColor': ZADColors.accentYellow,
      'title': 'Karim vous a évalué ⭐ 4.9/5 !',
      'sub': 'Merci pour ce don de qualité 🌿',
      'time': 'Il y a 1h',
      'unread': true,
      'type': 'benevole',
    },
    {
      'icon': Icons.check_circle,
      'iconBg': Color(0xFFE8F5E9),
      'iconColor': ZADColors.success,
      'title': 'Don livré avec succès !',
      'sub': 'Pain 30 unités · Association El Fath\nHier 14h35',
      'time': '',
      'unread': false,
      'type': 'don',
    },
    {
      'icon': Icons.person_add_outlined,
      'iconBg': ZADColors.primarySoft,
      'iconColor': ZADColors.primary,
      'title': 'Bénévole trouvé pour votre don',
      'sub': 'Sara Benali accepte votre croissant\nIl y a 2h',
      'time': '',
      'unread': false,
      'type': 'benevole',
    },
    {
      'icon': Icons.warning_amber_rounded,
      'iconBg': Color(0xFFFFF3E0),
      'iconColor': ZADColors.accentOrange,
      'title': 'Don expiré sans bénévole',
      'sub': 'Fromages 5 kg · Personne disponible\nIl y a 7 jours',
      'time': '',
      'unread': false,
      'type': 'don',
    },
  ];

  List<Map<String, dynamic>> get _filtered {
    switch (_selectedFilter) {
      case 1:
        return _allNotifications
            .where((n) => n['unread'] == true)
            .toList();
      case 2:
        return _allNotifications
            .where((n) => n['type'] == 'don')
            .toList();
      case 3:
        return _allNotifications
            .where((n) => n['type'] == 'benevole')
            .toList();
      default:
        return _allNotifications;
    }
  }

  int get _unreadCount =>
      _allNotifications.where((n) => n['unread'] == true).length;

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
                      child: Text('Notifications',
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
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 10),
            child: Row(
              children: [
                _FilterChip(
                    label: 'Tout',
                    active: _selectedFilter == 0,
                    onTap: () =>
                        setState(() => _selectedFilter = 0)),
                const SizedBox(width: 8),
                _FilterChip(
                    label: 'Non lus ($_unreadCount)',
                    active: _selectedFilter == 1,
                    onTap: () =>
                        setState(() => _selectedFilter = 1)),
                const SizedBox(width: 8),
                _FilterChip(
                    label: 'Dons',
                    active: _selectedFilter == 2,
                    onTap: () =>
                        setState(() => _selectedFilter = 2)),
                const SizedBox(width: 8),
                _FilterChip(
                    label: 'Bénévoles',
                    active: _selectedFilter == 3,
                    onTap: () =>
                        setState(() => _selectedFilter = 3)),
              ],
            ),
          ),
          Expanded(
            child: _filtered.isEmpty
                ? const Center(
                    child: Text('Aucune notification',
                        style:
                            TextStyle(color: ZADColors.textLight)))
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _filtered.length,
                    itemBuilder: (context, index) {
                      final n = _filtered[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: _NotifItem(
                          icon: n['icon'],
                          iconBg: n['iconBg'],
                          iconColor: n['iconColor'],
                          title: n['title'],
                          sub: n['sub'],
                          time: n['time'],
                          unread: n['unread'],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: const ZADBottomNav(currentIndex: 0),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _FilterChip(
      {required this.label,
      required this.active,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: active ? ZADColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color:
                  active ? ZADColors.primary : ZADColors.divider),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: active ? Colors.white : ZADColors.textMedium,
            fontWeight:
                active ? FontWeight.w700 : FontWeight.w500,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

class _NotifItem extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String title;
  final String sub;
  final String time;
  final bool unread;

  const _NotifItem({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.title,
    required this.sub,
    required this.time,
    required this.unread,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: unread ? ZADColors.primarySoft : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: unread
            ? Border.all(color: ZADColors.accent.withOpacity(0.4))
            : null,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2))
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        fontWeight: unread
                            ? FontWeight.w800
                            : FontWeight.w600,
                        fontSize: 14,
                        color: ZADColors.textDark)),
                const SizedBox(height: 2),
                Text(sub,
                    style: const TextStyle(
                        color: ZADColors.textMedium,
                        fontSize: 12)),
              ],
            ),
          ),
          if (time.isNotEmpty)
            Text(time,
                style: const TextStyle(
                    color: ZADColors.textLight, fontSize: 10)),
          if (unread)
            Container(
              width: 10,
              height: 10,
              margin: const EdgeInsets.only(top: 4, left: 8),
              decoration: const BoxDecoration(
                  color: ZADColors.primary, shape: BoxShape.circle),
            ),
        ],
      ),
    );
  }
}