import 'package:flutter/material.dart';

class DocumentsScreen extends StatelessWidget {
  const DocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Documents Officiels',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF1B5E20),
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          // جزء التنبيه
          Container(
            padding: const EdgeInsets.all(15),
            color: Colors.orange.withValues(alpha: 0.1),
            child: const Row(
              children: [
                Icon(Icons.info_outline, color: Colors.orange),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "Veuillez garder vos documents à jour pour maintenir la validation de votre association.",
                    style: TextStyle(fontSize: 12, color: Colors.black87),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildDocCard(
                  context,
                  title: "Agrément de l'association",
                  date: "Ajouté le 12/01/2026",
                  status: "Validé",
                  icon: Icons.verified_user_outlined,
                ),
                const SizedBox(height: 15),
                _buildDocCard(
                  context,
                  title: "Statuts de l'association",
                  date: "Ajouté le 12/01/2026",
                  status: "En attente",
                  icon: Icons.description_outlined,
                ),
                const SizedBox(height: 15),
                _buildDocCard(
                  context,
                  title: "Identifiant Fiscal (NIF)",
                  date: "Non encore ajouté",
                  status: "Manquant",
                  icon: Icons.article_outlined,
                ),
              ],
            ),
          ),

          // زر إضافة وثيقة جديدة
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: () {
                  // هنا نزيدو Image Picker أو File Picker مستقبلاً
                },
                icon: const Icon(Icons.add_a_photo, color: Colors.white),
                label: const Text(
                  "Ajouter un nouveau document",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1B5E20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocCard(
    BuildContext context, {
    required String title,
    required String date,
    required String status,
    required IconData icon,
  }) {
    Color statusColor = status == "Validé"
        ? Colors.green
        : (status == "Manquant" ? Colors.red : Colors.orange);

    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F7FA),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: const Color(0xFF1B5E20)),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Text(
                status,
                style: TextStyle(
                  color: statusColor,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Icon(Icons.more_vert, color: Colors.grey),
            ],
          ),
        ],
      ),
    );
  }
}
