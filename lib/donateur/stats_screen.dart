import 'package:flutter/material.dart';
import '../main.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  int _period = 2;
  final _periods = ['Ce mois', 'Cette année', 'Total'];

  final List<Map<String, dynamic>> _monthlyData = [
    {'label': 'S1', 'value': 8},
    {'label': 'S2', 'value': 14},
    {'label': 'S3', 'value': 11},
    {'label': 'S4', 'value': 12},
  ];

  final List<Map<String, dynamic>> _yearlyData = [
    {'label': 'Jan', 'value': 15},
    {'label': 'Fév', 'value': 22},
    {'label': 'Mar', 'value': 18},
    {'label': 'Avr', 'value': 30},
    {'label': 'Mai', 'value': 25},
    {'label': 'Jun', 'value': 40},
    {'label': 'Jul', 'value': 35},
    {'label': 'Aoû', 'value': 28},
    {'label': 'Sep', 'value': 32},
    {'label': 'Oct', 'value': 45},
    {'label': 'Nov', 'value': 38},
    {'label': 'Déc', 'value': 12},
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
                      child: Text('Statistiques',
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
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 10,
                            offset: const Offset(0, 2))
                      ],
                    ),
                    child: Row(
                      children: List.generate(_periods.length, (i) {
                        final active = i == _period;
                        return Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => _period = i),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: active ? ZADColors.primary : Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                _periods[i],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: active ? Colors.white : ZADColors.textMedium,
                                  fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [ZADColors.primary, ZADColors.headerBgLight],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('340 kg',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 36,
                                fontWeight: FontWeight.w900)),
                        const Text('Nourriture sauvée ce mois',
                            style: TextStyle(
                                color: Colors.white70, fontSize: 13)),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _StatMini(value: '45', label: 'Dons publiés'),
                            _StatMini(value: '40', label: 'Livrés'),
                            _StatMini(value: '⭐ 4.8', label: 'Note moy.'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (_period == 0)
                    _ChartCard(
                        title: 'Dons ce mois (par semaine)',
                        data: _monthlyData)
                  else if (_period == 1)
                    _ChartCard(
                        title: 'Dons cette année (par mois)',
                        data: _yearlyData,
                        compact: true)
                  else
                    Container(
                      width: double.infinity,
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
                          const Text('Dons par type',
                              style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 15,
                                  color: ZADColors.textDark)),
                          const SizedBox(height: 16),
                          _BarRow(
                              label: 'Pain',
                              percentage: 0.50,
                              color: ZADColors.primary),
                          const SizedBox(height: 10),
                          _BarRow(
                              label: 'Repas',
                              percentage: 0.75,
                              color: ZADColors.primaryLight),
                          const SizedBox(height: 10),
                          _BarRow(
                              label: 'Autre',
                              percentage: 0.25,
                              color: ZADColors.accent),
                        ],
                      ),
                    ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const ZADBottomNav(currentIndex: 3),
    );
  }
}

// ─── Chart Card ───────────────────────────────────────────────────────────────

class _ChartCard extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> data;
  final bool compact;

  const _ChartCard(
      {required this.title, required this.data, this.compact = false});

  @override
  Widget build(BuildContext context) {
    const double totalH = 140;
    const double labelH = 16;
    const double valueH = 14;
    const double gapH = 10;
    final double barAreaH = totalH - labelH - (compact ? 0 : valueH) - gapH;

    final maxVal = data
        .map((d) => d['value'] as int)
        .reduce((a, b) => a > b ? a : b);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
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
          Text(title,
              style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 15,
                  color: ZADColors.textDark)),
          const SizedBox(height: 16),
          SizedBox(
            height: totalH,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (int i = 0; i < data.length; i++) ...[
                  if (i != 0) const SizedBox(width: 8),
                  Expanded(
                    child: _Bar(
                      value: data[i]['value'] as int,
                      label: data[i]['label'] as String,
                      maxVal: maxVal,
                      barAreaH: barAreaH,
                      labelH: labelH,
                      valueH: valueH,
                      compact: compact,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Single Bar ───────────────────────────────────────────────────────────────

class _Bar extends StatelessWidget {
  final int value;
  final String label;
  final int maxVal;
  final double barAreaH;
  final double labelH;
  final double valueH;
  final bool compact;

  const _Bar({
    required this.value,
    required this.label,
    required this.maxVal,
    required this.barAreaH,
    required this.labelH,
    required this.valueH,
    required this.compact,
  });

  @override
  Widget build(BuildContext context) {
    final double barH = barAreaH * (value / maxVal);

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (!compact)
          SizedBox(
            height: valueH,
            child: Text(
              '$value',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: ZADColors.primary,
              ),
            ),
          ),
        Container(
          height: barH,
          decoration: const BoxDecoration(
            color: ZADColors.primary,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(4),
              topRight: Radius.circular(4),
            ),
          ),
        ),
        SizedBox(
          height: labelH,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: compact ? 9 : 11,
              color: ZADColors.textMedium,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Stat Mini ────────────────────────────────────────────────────────────────

class _StatMini extends StatelessWidget {
  final String value;
  final String label;

  const _StatMini({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 18)),
        Text(label,
            style: const TextStyle(color: Colors.white70, fontSize: 11)),
      ],
    );
  }
}

// ─── Bar Row (Total tab) ──────────────────────────────────────────────────────

class _BarRow extends StatelessWidget {
  final String label;
  final double percentage;
  final Color color;

  const _BarRow({
    required this.label,
    required this.percentage,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label,
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: ZADColors.textDark)),
            Text('${(percentage * 100).toInt()}%',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    color: color)),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: LinearProgressIndicator(
            value: percentage,
            backgroundColor: color.withOpacity(0.12),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 10,
          ),
        ),
      ],
    );
  }
}