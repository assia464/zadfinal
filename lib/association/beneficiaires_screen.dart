import 'package:flutter/material.dart';
import 'home_screen.dart'; 

class ZadColors {
  static const Color darkNavy = Color(0xFF1A2B4A);
  static const Color teal = Color(0xFF2E7D7D);
  static const Color leafGreen = Color(0xFF2E7D32);
  static const Color background = Color(0xFFFFFFFF);
  static const Color labelGrey = Color(0xFF6B7A8D);
  static const Color cardBg = Color(0xFFF5F7FA);
}

class BeneficiairesScreen extends StatefulWidget {
  const BeneficiairesScreen({super.key});

  @override
  State<BeneficiairesScreen> createState() => _BeneficiairesScreenState();
}

class _BeneficiairesScreenState extends State<BeneficiairesScreen> {
  final _searchController = TextEditingController();
  String _search = '';

  final List<Map<String, dynamic>> _beneficiaires = [
    {
      'nom': 'Bouchra HOUALEF',
      'adresse': 'BAB EL ASSA',
      'personnes': 2,
      'besoin': 'Nourriture',
      'statut': 'Actif',
      'initiales': 'BH',
      'color': const Color(0xFF1565C0),
    },
    {
      'nom': 'MOHAMED JABI',
      'adresse': 'OUJLIDA',
      'personnes': 1,
      'besoin': 'Nourriture',
      'statut': 'Inactif',
      'initiales': 'MJ',
      'color': const Color(0xFF6A1B9A),
    },
    {
      'nom': 'SAMIA DIAZ',
      'adresse': 'IMAMA',
      'personnes': 2,
      'besoin': 'Nourriture',
      'statut': 'Actif',
      'initiales': 'SD',
      'color': const Color(0xFFAD1457),
    },
    {
      'nom': 'FATIHA KARIM',
      'adresse': 'KIFAN',
      'personnes': 4,
      'besoin': 'Nourriture',
      'statut': 'Urgent',
      'initiales': 'FK',
      'color': const Color(0xFFE65100),
    },
    {
      'nom': 'FATIMA TELLAS',
      'adresse': 'MOGHNIYA',
      'personnes': 3,
      'besoin': 'Nourriture',
      'statut': 'Actif',
      'initiales': 'FT',
      'color': const Color(0xFFF9A825),
    },
  ];

  // ✅ الحل السهل: دالة ترجع للصفحة الرئيسية
  void _goBackToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _beneficiaires
        .where(
          (b) =>
              b['nom'].toString().toLowerCase().contains(_search.toLowerCase()),
        )
        .toList();

    return Scaffold(
      backgroundColor: ZadColors.background,
      body: Column(
        children: [
          // Header مع زر رجوع يخدم مزيان
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 52, 20, 20),
            decoration: const BoxDecoration(
              color: Color(0xFF1B5E20),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: _goBackToHome, // ✅ زر الرجوع يخدم
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Bénéficiaires',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                // Search
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (v) => setState(() => _search = v),
                    decoration: InputDecoration(
                      hintText: 'Rechercher un bénéficiaire...',
                      hintStyle: TextStyle(
                        color: ZadColors.labelGrey,
                        fontSize: 14,
                      ),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: ZadColors.labelGrey,
                      ),
                      suffixIcon: _search.isNotEmpty
                          ? IconButton(
                              icon: const Icon(
                                Icons.close,
                                color: ZadColors.labelGrey,
                              ),
                              onPressed: () => setState(() {
                                _search = '';
                                _searchController.clear();
                              }),
                            )
                          : null,
                      filled: true,
                      fillColor: ZadColors.cardBg,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Text(
                        '${filtered.length} bénéficiaires enregistrés',
                        style: TextStyle(
                          fontSize: 13,
                          color: ZadColors.labelGrey,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                // List
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final b = filtered[index];
                      return _BeneficiaireCard(data: b);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/ajouter-beneficiaire'),
        backgroundColor: ZadColors.leafGreen,
        child: const Icon(Icons.person_add, color: Colors.white),
      ),
    );
  }
}

class _BeneficiaireCard extends StatelessWidget {
  final Map<String, dynamic> data;
  const _BeneficiaireCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F7FA),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: data['color'],
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                data['initiales'],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data['nom'],
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: ZadColors.darkNavy,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${data['personnes']} personne(s) · ${data['adresse']}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: ZadColors.labelGrey,
                  ),
                ),
                Text(
                  'Besoins : ${data['besoin']}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: ZadColors.labelGrey,
                  ),
                ),
              ],
            ),
          ),
          if (data['statut'] == 'Urgent')
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFFFEBEE),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Urgent',
                style: TextStyle(
                  fontSize: 11,
                  color: Color(0xFFE53935),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
