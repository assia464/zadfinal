import 'package:flutter/material.dart';
import '../main.dart';
import 'chat_screen.dart'; 

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  String _searchQuery = '';

  final List<Map<String, dynamic>> _allMessages = [
    {
      'initials': 'KM',
      'name': 'Karim Mansouri',
      'lastMsg': "D'accord, j'arrive vers 14h25 🚗",
      'bgColor': ZADColors.primaryLight,
      'time': '14:05',
      'unread': true,
      'phone': '+213 555 123 456',
      'avatarText': 'KM',
    },
    {
      'initials': 'SB',
      'name': 'Sara Benali',
      'lastMsg': 'Le pain sera prêt à 14h00 🍞',
      'bgColor': ZADColors.accentOrange,
      'time': 'Hier',
      'unread': false,
      'phone': '+213 555 654 321',
      'avatarText': 'SB',
    },
    {
      'initials': 'EF',
      'name': 'Association El Fath',
      'lastMsg': "Je suis devant l'association ✅",
      'bgColor': ZADColors.primaryLight,
      'time': 'Hier',
      'unread': false,
      'phone': '+213 555 789 012',
      'avatarText': 'EF',
    },
    {
      'initials': 'OK',
      'name': 'Omar Khelifi',
      'lastMsg': 'Merci pour votre don ! 🙏',
      'bgColor': ZADColors.success,
      'time': '2j',
      'unread': false,
      'phone': '+213 555 321 654',
      'avatarText': 'OK',
    },
    {
      'initials': 'LF',
      'name': 'Leila Fares',
      'lastMsg': 'Je confirme ma venue demain',
      'bgColor': ZADColors.warning,
      'time': '3j',
      'unread': false,
      'phone': '+213 555 987 654',
      'avatarText': 'LF',
    },
  ];

  List<Map<String, dynamic>> get _filteredMessages {
    if (_searchQuery.isEmpty) return _allMessages;
    return _allMessages.where((msg) {
      return msg['name'].toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  void _showCallDialog(String name, String phone) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text('Contacter $name',
            style: const TextStyle(
                fontWeight: FontWeight.w800, color: ZADColors.primary)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.phone, size: 48, color: ZADColors.primary),
            const SizedBox(height: 12),
            Text(phone,
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            const Text('Appeler ce numéro ?',
                style: TextStyle(color: ZADColors.textMedium)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Annuler',
                style: TextStyle(color: ZADColors.textLight)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Appel en cours... (simulation)'),
                  backgroundColor: ZADColors.primary,
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: const Text('Appeler',
                style: TextStyle(color: ZADColors.primary)),
          ),
        ],
      ),
    );
  }

  void _openChat(Map<String, dynamic> contact) {
    // تمرير معلومات الشخص إلى صفحة المحادثة
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatScreen(
          contactName: contact['name'],
          contactInitials: contact['initials'],
          contactBgColor: contact['bgColor'],
          contactPhone: contact['phone'],
        ),
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
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back_ios_new,
                          color: Colors.white, size: 18),
                    ),
                    const Expanded(
                      child: Text('Messages',
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
          // Barre de recherche
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 2))
                ],
              ),
              child: Row(
                children: [
                  const Icon(Icons.search,
                      color: ZADColors.textLight, size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                        });
                      },
                      decoration: const InputDecoration(
                        hintText: 'Rechercher un contact...',
                        hintStyle: TextStyle(
                            color: ZADColors.textLight, fontSize: 14),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  if (_searchQuery.isNotEmpty)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _searchQuery = '';
                        });
                      },
                      child: const Icon(Icons.clear,
                          color: ZADColors.textLight, size: 18),
                    ),
                ],
              ),
            ),
          ),
          // Liste des messages
          Expanded(
            child: _filteredMessages.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.chat_bubble_outline,
                            size: 64, color: ZADColors.textLight),
                        SizedBox(height: 16),
                        Text('Aucune conversation trouvée',
                            style: TextStyle(
                                color: ZADColors.textLight,
                                fontSize: 14)),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    itemCount: _filteredMessages.length,
                    itemBuilder: (context, index) {
                      final msg = _filteredMessages[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: _MessageItem(
                          initials: msg['initials'],
                          name: msg['name'],
                          lastMsg: msg['lastMsg'],
                          bgColor: msg['bgColor'],
                          time: msg['time'],
                          unread: msg['unread'],
                          onTap: () => _openChat(msg),
                          onCall: () => _showCallDialog(
                              msg['name'], msg['phone']),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: const ZADBottomNav(currentIndex: 4),
    );
  }
}

class _MessageItem extends StatelessWidget {
  final String initials;
  final String name;
  final String lastMsg;
  final Color bgColor;
  final String time;
  final bool unread;
  final VoidCallback onTap;
  final VoidCallback onCall;

  const _MessageItem({
    required this.initials,
    required this.name,
    required this.lastMsg,
    required this.bgColor,
    required this.time,
    required this.unread,
    required this.onTap,
    required this.onCall,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: unread ? ZADColors.primarySoft : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: unread
              ? Border.all(color: ZADColors.primary.withOpacity(0.3))
              : null,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2))
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                  color: bgColor, borderRadius: BorderRadius.circular(14)),
              child: Center(
                child: Text(initials,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 16)),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(name,
                            style: TextStyle(
                                fontWeight: unread
                                    ? FontWeight.w800
                                    : FontWeight.w600,
                                fontSize: 15,
                                color: ZADColors.textDark)),
                      ),
                      Text(time,
                          style: const TextStyle(
                              color: ZADColors.textLight, fontSize: 11)),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(lastMsg,
                      style: TextStyle(
                          color: unread
                              ? ZADColors.textDark
                              : ZADColors.textMedium,
                          fontSize: 13,
                          fontWeight:
                              unread ? FontWeight.w600 : FontWeight.w400),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // زر الاتصال
            GestureDetector(
              onTap: onCall,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: ZADColors.primarySoft,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Icon(Icons.phone,
                    color: ZADColors.primary, size: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}