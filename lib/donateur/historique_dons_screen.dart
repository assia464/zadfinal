import 'package:flutter/material.dart';
import '../main.dart';

class HistoriqueDonsScreen extends StatelessWidget {
  const HistoriqueDonsScreen({super.key});

  final List<Map<String, dynamic>> _history = const [
    {
      'emoji': '🍞',
      'title': 'Pain — 30 unités',
      'date': '23 Mar 2025',
      'status': 'Livré',
      'color': ZADColors.success,
      'benevole': 'Karim M.',
      'rating': 4.9,
    },
    {
      'emoji': '🥦',
      'title': 'Légumes — 8 kg',
      'date': '20 Mar 2025',
      'status': 'Livré',
      'color': ZADColors.success,
      'benevole': 'Sara B.',
      'rating': 5.0,
    },
    {
      'emoji': '🥐',
      'title': 'Viennoiseries — 15 unités',
      'date': '18 Mar 2025',
      'status': 'Livré',
      'color': ZADColors.success,
      'benevole': 'Karim M.',
      'rating': 4.7,
    },
    {
      'emoji': '🧀',
      'title': 'Fromages — 5 kg',
      'date': '16 Mar 2025',
      'status': 'Expiré',
      'color': ZADColors.danger,
      'benevole': null,
      'rating': null,
    },
    {
      'emoji': '🥣',
      'title': 'Repas — 20 portions',
      'date': '10 Mar 2025',
      'status': 'Livré',
      'color': ZADColors.success,
      'benevole': 'Omar K.',
      'rating': 4.8,
    },
    {
      'emoji': '🥛',
      'title': 'Produits laitiers — 6 L',
      'date': '5 Mar 2025',
      'status': 'Livré',
      'color': ZADColors.success,
      'benevole': 'Sara B.',
      'rating': 5.0,
    },
  ];

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
                      child: Text('Historique des dons',
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
                horizontal: 20, vertical: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _HistoStat(value: '45', label: 'Total dons'),
                Container(
                    width: 1,
                    height: 30,
                    color: ZADColors.divider),
                _HistoStat(value: '40', label: 'Livrés'),
                Container(
                    width: 1,
                    height: 30,
                    color: ZADColors.divider),
                _HistoStat(value: '5', label: 'Expirés'),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _history.length,
              itemBuilder: (ctx, i) {
                final item = _history[i];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                            color:
                                Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 2))
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 46,
                          height: 46,
                          decoration: BoxDecoration(
                            color: (item['color'] as Color)
                                .withOpacity(0.12),
                            borderRadius:
                                BorderRadius.circular(12),
                          ),
                          child: Center(
                              child: Text(
                                  item['emoji'] as String,
                                  style: const TextStyle(
                                      fontSize: 22))),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(item['title'] as String,
                                  style: const TextStyle(
                                      fontWeight:
                                          FontWeight.w700,
                                      fontSize: 14,
                                      color:
                                          ZADColors.textDark)),
                              const SizedBox(height: 3),
                              Row(
                                children: [
                                  Icon(Icons.calendar_today,
                                      color:
                                          ZADColors.textLight,
                                      size: 11),
                                  const SizedBox(width: 4),
                                  Text(item['date'] as String,
                                      style: const TextStyle(
                                          color:
                                              ZADColors.textLight,
                                          fontSize: 11)),
                                  if (item['benevole'] !=
                                      null) ...[
                                    const SizedBox(width: 8),
                                    const Text('·',
                                        style: TextStyle(
                                            color: ZADColors
                                                .textLight)),
                                    const SizedBox(width: 8),
                                    Text(
                                        item['benevole']
                                            as String,
                                        style: const TextStyle(
                                            color:
                                                ZADColors.primary,
                                            fontWeight:
                                                FontWeight.w600,
                                            fontSize: 11)),
                                  ],
                                ],
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.end,
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 4),
                              decoration: BoxDecoration(
                                color: (item['color'] as Color)
                                    .withOpacity(0.12),
                                borderRadius:
                                    BorderRadius.circular(20),
                              ),
                              child: Text(
                                  item['status'] as String,
                                  style: TextStyle(
                                      color: item['color']
                                          as Color,
                                      fontWeight:
                                          FontWeight.w700,
                                      fontSize: 11)),
                            ),
                            if (item['rating'] != null) ...[
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.star,
                                      color:
                                          ZADColors.accentYellow,
                                      size: 12),
                                  const SizedBox(width: 2),
                                  Text(
                                      '${item['rating']}',
                                      style: const TextStyle(
                                          color:
                                              ZADColors.textMedium,
                                          fontSize: 11,
                                          fontWeight:
                                              FontWeight.w600)),
                                ],
                              ),
                            ],
                          ],
                        ),
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
}

class _HistoStat extends StatelessWidget {
  final String value;
  final String label;

  const _HistoStat({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 20,
                color: ZADColors.primary)),
        Text(label,
            style: const TextStyle(
                color: ZADColors.textLight, fontSize: 12)),
      ],
    );
  }
}