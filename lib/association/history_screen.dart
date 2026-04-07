import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // عدد الأقسام: الكل، تبرعات، توزيع
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Mon Historique',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: const Color(0xFF1B5E20),
          centerTitle: true,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
          bottom: const TabBar(
            indicatorColor: Colors.orange,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(text: "Tout"),
              Tab(text: "Recu"),
              Tab(text: "Distribué"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildHistoryList(), // قائمة الكل
            _buildHistoryList(filter: "Recu"), // قائمة المستلم فقط
            _buildHistoryList(filter: "Distribué"), // قائمة الموزع فقط
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryList({String? filter}) {
    // بيانات وهمية للتجربة (مستقبلاً تجي من الـ Database)
    final activities = [
      {
        "title": "Don de Repas",
        "date": "24 Mars 2026",
        "type": "Recu",
        "qty": "15 plats",
        "icon": Icons.fastfood,
      },
      {
        "title": "Distribution Médicaments",
        "date": "22 Mars 2026",
        "type": "Distribué",
        "qty": "4 boites",
        "icon": Icons.medical_services,
      },
      {
        "title": "Don de Vêtements",
        "date": "20 Mars 2026",
        "type": "Recu",
        "qty": "2 sacs",
        "icon": Icons.checkroom,
      },
    ];

    // تصفية البيانات حسب النوع إذا وُجد فلتر
    final filteredList = filter == null
        ? activities
        : activities.where((a) => a['type'] == filter).toList();

    return ListView.builder(
      padding: const EdgeInsets.all(15),
      itemCount: filteredList.length,
      itemBuilder: (context, index) {
        final item = filteredList[index];
        bool isRecu = item['type'] == "Recu";

        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 2,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: isRecu ? Colors.green[100] : Colors.orange[100],
              child: Icon(
                item['icon'] as IconData,
                color: isRecu ? Colors.green : Colors.orange,
              ),
            ),
            title: Text(
              item['title'] as String,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text("${item['date']} • ${item['qty']}"),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: isRecu ? Colors.green[50] : Colors.orange[50],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                isRecu ? "+ Recu" : "- Distribué",
                style: TextStyle(
                  color: isRecu ? Colors.green : Colors.orange,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
