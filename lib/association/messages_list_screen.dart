import 'package:flutter/material.dart';
import 'chat_screen.dart'; // تأكدي باللي الملف الثاني مسمي هكذا

class MessagesListScreen extends StatefulWidget {
  const MessagesListScreen({super.key});

  @override
  State<MessagesListScreen> createState() => _MessagesListScreenState();
}

class _MessagesListScreenState extends State<MessagesListScreen> {
  // القائمة الأصلية
  final List<Map<String, String>> _allChats = [
    {
      'name': 'Assia HASNAOUI',
      'lastMsg': 'Merci beaucoup ! On vous attend',
      'time': '14:25',
      'initials': 'AH',
    },
    {
      'name': 'Restaurant Al Zitouni',
      'lastMsg': 'Le don est prêt à être récupéré',
      'time': 'Hier',
      'initials': 'RZ',
    },
    {
      'name': 'Association Al Khair',
      'lastMsg': 'Barak Allah fikom',
      'time': 'Lun',
      'initials': 'AK',
    },
  ];

  // القائمة اللي تظهر بعد البحث
  List<Map<String, String>> _foundChats = [];

  @override
  void initState() {
    _foundChats = _allChats;
    super.initState();
  }

  void _runFilter(String enteredKeyword) {
    setState(() {
      _foundChats = _allChats
          .where(
            (user) => user["name"]!.toLowerCase().contains(
              enteredKeyword.toLowerCase(),
            ),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header + Search Bar
          Container(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 25),
            decoration: const BoxDecoration(
              color: Color(0xFF1B5E20),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Mes Messages',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                    onChanged: (value) => _runFilter(value),
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: "Rechercher...",
                      hintStyle: TextStyle(color: Colors.white70),
                      prefixIcon: Icon(Icons.search, color: Colors.white70),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // List of Chats
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _foundChats.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ChatScreen()),
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F7FA),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: const Color(
                            0xFF1B5E20,
                          ).withOpacity(0.1),
                          child: Text(
                            _foundChats[index]['initials']!,
                            style: const TextStyle(color: Color(0xFF1B5E20)),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _foundChats[index]['name']!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                _foundChats[index]['lastMsg']!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          _foundChats[index]['time']!,
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                          ),
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
