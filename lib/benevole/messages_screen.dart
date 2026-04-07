// ============================================================
// 📄 lib/screens/benevole/messages_screen.dart
// ============================================================

import 'package:flutter/material.dart';
import 'chat_screen.dart';

class BenevoleMessagesScreen extends StatefulWidget {
  const BenevoleMessagesScreen({super.key});

  @override
  State<BenevoleMessagesScreen> createState() =>
      _BenevoleMessagesScreenState();
}

class _BenevoleMessagesScreenState extends State<BenevoleMessagesScreen> {
  static const _green     = Color(0xFF4CAF50);
  static const _greenDark = Color(0xFF388E3C);
  static const _divider   = Color(0xFFEEEEEE);
  static const _subText   = Color(0xFF757575);
  static const _textDark  = Color(0xFF1B1B1B);

  final _searchController = TextEditingController();
  String _searchQuery = '';

  final List<Map<String, dynamic>> _conversations = [
    {
      'name': 'Association El Fath',
      'avatar': 'EF',
      'avatarColor': const Color(0xFF4CAF50),
      'lastMessage': 'Je suis devant l\'association ✅',
      'time': '14h35',
      'unread': 1,
      'online': true,
    },
    {
      'name': 'Boulangerie Atlas',
      'avatar': 'BA',
      'avatarColor': const Color(0xFFFF8F00),
      'lastMessage': 'Le pain sera prêt à 14h00 👍',
      'time': '13h55',
      'unread': 2,
      'online': true,
    },
    {
      'name': 'Association Nour',
      'avatar': 'NR',
      'avatarColor': const Color(0xFF1565C0),
      'lastMessage': 'Merci beaucoup Karim ! 🌿',
      'time': 'Hier',
      'unread': 0,
      'online': false,
    },
    {
      'name': 'Association Rahma',
      'avatar': 'RH',
      'avatarColor': const Color(0xFF7B1FA2),
      'lastMessage': 'Pouvez-vous venir demain matin ?',
      'time': 'Il y a 2j',
      'unread': 0,
      'online': false,
    },
    {
      'name': 'Restaurant Le Zitoun',
      'avatar': 'RZ',
      'avatarColor': const Color(0xFF00897B),
      'lastMessage': 'Don collecté avec succès !',
      'time': 'Il y a 3j',
      'unread': 0,
      'online': false,
    },
  ];

  List<Map<String, dynamic>> get _filtered {
    if (_searchQuery.isEmpty) return _conversations;
    return _conversations
        .where((c) => (c['name'] as String)
            .toLowerCase()
            .contains(_searchQuery.toLowerCase()))
        .toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBF9),
      body: Column(
        children: [
          _buildHeader(),
          _buildSearch(),
          Expanded(
            child: _filtered.isEmpty
                ? _buildEmpty()
                : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: _filtered.length,
                    itemBuilder: (_, i) =>
                        _buildConversationItem(_filtered[i]),
                  ),
          ),
        ],
      ),
    );
  }

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
            child: Text('Messages',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                )),
          ),
          // ← زر Edit محذوف
        ],
      ),
    );
  }

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 14),
              child: Icon(Icons.search, color: _subText, size: 20),
            ),
            Expanded(
              child: TextField(
                controller: _searchController,
                onChanged: (v) => setState(() => _searchQuery = v),
                decoration: const InputDecoration(
                  hintText: 'Rechercher une conversation...',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: 12, vertical: 13),
                  hintStyle: TextStyle(
                    color: Color(0xFFBDBDBD),
                    fontSize: 12,
                    fontFamily: 'Poppins',
                  ),
                ),
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  color: _textDark,
                ),
              ),
            ),
            if (_searchQuery.isNotEmpty)
              GestureDetector(
                onTap: () {
                  _searchController.clear();
                  setState(() => _searchQuery = '');
                },
                child: const Padding(
                  padding: EdgeInsets.only(right: 12),
                  child: Icon(Icons.close, color: _subText, size: 18),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildConversationItem(Map<String, dynamic> conv) {
    final hasUnread = (conv['unread'] as int) > 0;
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BenevoleChatScreen(
              name: conv['name'] as String,
              avatar: conv['avatar'] as String,
              avatarColor: conv['avatarColor'] as Color,
              isOnline: conv['online'] as bool,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: hasUnread
              ? const Color(0xFFF1F8E9)
              : Colors.white,
          border: const Border(
            bottom: BorderSide(color: _divider, width: 0.5),
          ),
        ),
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  width: 50, height: 50,
                  decoration: BoxDecoration(
                    color: conv['avatarColor'] as Color,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(conv['avatar'] as String,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        )),
                  ),
                ),
                if (conv['online'] as bool)
                  Positioned(
                    bottom: 2, right: 2,
                    child: Container(
                      width: 12, height: 12,
                      decoration: BoxDecoration(
                        color: _green,
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: Colors.white, width: 2),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(conv['name'] as String,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        fontWeight: hasUnread
                            ? FontWeight.w700
                            : FontWeight.w500,
                        color: _textDark,
                      )),
                  const SizedBox(height: 3),
                  Text(conv['lastMessage'] as String,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 11,
                        color: hasUnread ? _greenDark : _subText,
                        fontWeight: hasUnread
                            ? FontWeight.w500
                            : FontWeight.w400,
                      )),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(conv['time'] as String,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 10,
                      color: hasUnread ? _green : _subText,
                      fontWeight: hasUnread
                          ? FontWeight.w600
                          : FontWeight.w400,
                    )),
                const SizedBox(height: 4),
                if ((conv['unread'] as int) > 0)
                  Container(
                    width: 20, height: 20,
                    decoration: const BoxDecoration(
                      color: _green,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${conv['unread']}',
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('💬', style: TextStyle(fontSize: 48)),
          SizedBox(height: 12),
          Text('Aucune conversation',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: _textDark,
              )),
        ],
      ),
    );
  }
}