import 'package:flutter/material.dart';
import '../main.dart';

class MyDonsScreen extends StatefulWidget {
  const MyDonsScreen({super.key});

  @override
  State<MyDonsScreen> createState() => _MyDonsScreenState();
}

class _MyDonsScreenState extends State<MyDonsScreen> {
  int _tab = 0;
  final _tabs = ['Tous (45)', 'En cours', 'Livrés', 'Expirés'];

  // قائمة التبرعات الديناميكية
  List<Map<String, dynamic>> _pendingDons = [
    {
      'id': '1',
      'emoji': '🥐',
      'title': 'Croissants du matin',
      'meta': '20 unités · Publié il y a 30 min',
      'statusLabel': 'En attente bénévole',
      'statusColor': ZADColors.warning,
      'actionLabel': 'Annuler',
      'actionColor': ZADColors.danger,
      'statusIcon': null,
    },
    {
      'id': '2',
      'emoji': '🥣',
      'title': 'Repas du midi',
      'meta': '15 portions · Bénévole en route',
      'statusLabel': 'Karim en route',
      'statusColor': ZADColors.primary,
      'actionLabel': 'Suivre',
      'actionColor': ZADColors.primary,
      'statusIcon': Icons.directions_car,
    },
  ];

  List<Map<String, dynamic>> _livresDons = [
    {
      'emoji': '✅',
      'title': 'Pain — 30 unités',
      'meta': 'Livré hier à 14h35 · ⭐ 4.9',
      'date': 'Hier',
      'color': ZADColors.success,
    },
    {
      'emoji': '✅',
      'title': 'Légumes — 8 kg',
      'meta': 'Livré il y a 3j · ⭐ 5.0',
      'date': 'Il y a 3j',
      'color': ZADColors.success,
    },
    {
      'emoji': '✅',
      'title': 'Viennoiseries — 15 unités',
      'meta': 'Livré il y a 5j · ⭐ 4.7',
      'date': 'Il y a 5j',
      'color': ZADColors.success,
    },
  ];

  List<Map<String, dynamic>> _expiresDons = [
    {
      'emoji': '❌',
      'title': 'Fromages — 5 kg',
      'meta': 'Expiré · Aucun bénévole disponible',
      'date': 'Il y a 7j',
      'color': ZADColors.danger,
    },
    {
      'emoji': '❌',
      'title': 'Gâteaux — 12 unités',
      'meta': 'Expiré · Aucun bénévole disponible',
      'date': 'Il y a 14j',
      'color': ZADColors.danger,
    },
  ];

  // دالة لإلغاء التبرع (حذفه)
  void _cancelDonation(Map<String, dynamic> donation) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text(
          'Annuler le don',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: ZADColors.danger,
          ),
        ),
        content: Text(
          'Êtes-vous sûr de vouloir annuler le don "${donation['title']}" ?',
          style: const TextStyle(color: ZADColors.textDark),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Non',
                style: TextStyle(color: ZADColors.textLight)),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _pendingDons.removeWhere((item) => item['id'] == donation['id']);
              });
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Don annulé avec succès'),
                  backgroundColor: ZADColors.success,
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: const Text('Oui, annuler',
                style: TextStyle(color: ZADColors.danger)),
          ),
        ],
      ),
    );
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back_ios_new,
                          color: Colors.white, size: 18),
                    ),
                    const Text(
                      'Mes dons',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w800),
                    ),
                    GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, '/publish'),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.add,
                            color: Colors.white, size: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 10),
              child: Row(
                children: List.generate(_tabs.length, (i) {
                  final active = i == _tab;
                  Color chipColor;
                  IconData chipIcon;
                  switch (i) {
                    case 1:
                      chipColor = ZADColors.warning;
                      chipIcon = Icons.refresh;
                      break;
                    case 2:
                      chipColor = ZADColors.success;
                      chipIcon = Icons.check_circle;
                      break;
                    case 3:
                      chipColor = ZADColors.danger;
                      chipIcon = Icons.close;
                      break;
                    default:
                      chipColor = ZADColors.primary;
                      chipIcon = Icons.list_alt;
                  }
                  return GestureDetector(
                    onTap: () => setState(() => _tab = i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: active
                            ? chipColor.withOpacity(0.12)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: active ? chipColor : ZADColors.divider,
                          width: active ? 2 : 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(chipIcon,
                              color: active
                                  ? chipColor
                                  : ZADColors.textLight,
                              size: 14),
                          const SizedBox(width: 6),
                          Text(
                            _tabs[i],
                            style: TextStyle(
                              color: active
                                  ? chipColor
                                  : ZADColors.textMedium,
                              fontWeight: active
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _buildTabContent(),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const ZADBottomNav(currentIndex: 1),
    );
  }

  List<Widget> _buildTabContent() {
    switch (_tab) {
      case 1:
        return [
          _DonGroupTitle(
              label: 'EN COURS', color: ZADColors.warning),
          const SizedBox(height: 10),
          ..._pendingDons.map((don) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _MyDonItem(
                  id: don['id'],
                  emoji: don['emoji'],
                  title: don['title'],
                  meta: don['meta'],
                  statusLabel: don['statusLabel'],
                  statusColor: don['statusColor'],
                  actionLabel: don['actionLabel'],
                  actionColor: don['actionColor'],
                  onAction: don['actionLabel'] == 'Annuler'
                      ? () => _cancelDonation(don)
                      : () => Navigator.pushNamed(context, '/tracking'),
                  statusIcon: don['statusIcon'],
                ),
              )),
          const SizedBox(height: 40),
        ];
      case 2:
        return [
          _DonGroupTitle(
              label: 'LIVRÉS', color: ZADColors.success),
          const SizedBox(height: 10),
          ..._livresDons.map((don) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: _CompactDonItem(
                  emoji: don['emoji'],
                  title: don['title'],
                  meta: don['meta'],
                  date: don['date'],
                  color: don['color'],
                ),
              )),
          const SizedBox(height: 40),
        ];
      case 3:
        return [
          _DonGroupTitle(
              label: 'EXPIRÉS', color: ZADColors.danger),
          const SizedBox(height: 10),
          ..._expiresDons.map((don) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: _CompactDonItem(
                  emoji: don['emoji'],
                  title: don['title'],
                  meta: don['meta'],
                  date: don['date'],
                  color: don['color'],
                ),
              )),
          const SizedBox(height: 40),
        ];
      default:
        return [
          _DonGroupTitle(
              label: 'EN COURS', color: ZADColors.warning),
          const SizedBox(height: 10),
          ..._pendingDons.map((don) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _MyDonItem(
                  id: don['id'],
                  emoji: don['emoji'],
                  title: don['title'],
                  meta: don['meta'],
                  statusLabel: don['statusLabel'],
                  statusColor: don['statusColor'],
                  actionLabel: don['actionLabel'],
                  actionColor: don['actionColor'],
                  onAction: don['actionLabel'] == 'Annuler'
                      ? () => _cancelDonation(don)
                      : () => Navigator.pushNamed(context, '/tracking'),
                  statusIcon: don['statusIcon'],
                ),
              )),
          const SizedBox(height: 16),
          _DonGroupTitle(
              label: 'LIVRÉS', color: ZADColors.success),
          const SizedBox(height: 10),
          ..._livresDons.map((don) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: _CompactDonItem(
                  emoji: don['emoji'],
                  title: don['title'],
                  meta: don['meta'],
                  date: don['date'],
                  color: don['color'],
                ),
              )),
          const SizedBox(height: 16),
          _DonGroupTitle(
              label: 'EXPIRÉS', color: ZADColors.danger),
          const SizedBox(height: 10),
          ..._expiresDons.map((don) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: _CompactDonItem(
                  emoji: don['emoji'],
                  title: don['title'],
                  meta: don['meta'],
                  date: don['date'],
                  color: don['color'],
                ),
              )),
          const SizedBox(height: 40),
        ];
    }
  }
}

class _DonGroupTitle extends StatelessWidget {
  final String label;
  final Color color;

  const _DonGroupTitle({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            width: 4,
            height: 16,
            color: color,
            margin: const EdgeInsets.only(right: 8)),
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 12,
            color: color,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }
}

class _MyDonItem extends StatelessWidget {
  final String? id;
  final String emoji;
  final String title;
  final String meta;
  final String statusLabel;
  final Color statusColor;
  final String actionLabel;
  final Color actionColor;
  final VoidCallback onAction;
  final IconData? statusIcon;

  const _MyDonItem({
    this.id,
    required this.emoji,
    required this.title,
    required this.meta,
    required this.statusLabel,
    required this.statusColor,
    required this.actionLabel,
    required this.actionColor,
    required this.onAction,
    this.statusIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 28)),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                        color: ZADColors.textDark)),
                Text(meta,
                    style: const TextStyle(
                        color: ZADColors.textLight, fontSize: 12)),
                const SizedBox(height: 6),
                Row(
                  children: [
                    if (statusIcon != null)
                      Icon(statusIcon, color: statusColor, size: 14),
                    if (statusIcon != null) const SizedBox(width: 4),
                    Text(statusLabel,
                        style: TextStyle(
                            color: statusColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onAction,
            child: Text(actionLabel,
                style: TextStyle(
                    color: actionColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 14)),
          ),
        ],
      ),
    );
  }
}

class _CompactDonItem extends StatelessWidget {
  final String emoji;
  final String title;
  final String meta;
  final String date;
  final Color color;

  const _CompactDonItem({
    required this.emoji,
    required this.title,
    required this.meta,
    required this.date,
    required this.color,
  });

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
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
                child: Text(emoji,
                    style: const TextStyle(fontSize: 16))),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: ZADColors.textDark)),
                Text(meta,
                    style: TextStyle(
                        color: color,
                        fontSize: 12,
                        fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          Text(date,
              style: const TextStyle(
                  color: ZADColors.textLight, fontSize: 12)),
        ],
      ),
    );
  }
}