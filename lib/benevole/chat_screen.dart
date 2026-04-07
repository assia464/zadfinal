// ============================================================
// 📄 lib/screens/benevole/chat_screen.dart
// ============================================================

import 'package:flutter/material.dart';

class BenevoleChatScreen extends StatefulWidget {
  final String name;
  final String avatar;
  final Color avatarColor;
  final bool isOnline;

  const BenevoleChatScreen({
    super.key,
    required this.name,
    required this.avatar,
    required this.avatarColor,
    required this.isOnline,
  });

  @override
  State<BenevoleChatScreen> createState() => _BenevoleChatScreenState();
}

class _BenevoleChatScreenState extends State<BenevoleChatScreen> {
  static const _green     = Color(0xFF4CAF50);
  static const _greenDark = Color(0xFF388E3C);
  static const _greenPale = Color(0xFFE8F5E9);
  static const _subText   = Color(0xFF757575);
  static const _textDark  = Color(0xFF1B1B1B);

  final _messageController = TextEditingController();
  final _scrollController  = ScrollController();

  final List<Map<String, dynamic>> _messages = [
    {
      'text': 'Bonjour ! Je suis disponible pour une mission ?',
      'sent': false,
      'time': '14:10',
    },
    {
      'text': 'Oui, je suis disponible !',
      'sent': true,
      'time': '14:11',
    },
    {
      'text': 'Pain · Boulangerie Atlas · 30 unités · 14h45 🍞',
      'sent': false,
      'time': '14:12',
    },
    {
      'text': 'J\'accepte ! J\'arrive dans 10 min 🚗',
      'sent': true,
      'time': '14:13',
    },
    {
      'text': 'Merci beaucoup ! 🌿',
      'sent': false,
      'time': '14:13',
    },
    {
      'text': 'Je suis devant l\'association ✅',
      'sent': true,
      'time': '14:35',
    },
    {
      'text': 'On vous ouvre ! Merci infiniment 🙏🌿',
      'sent': false,
      'time': '14:36',
    },
  ];

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add({
        'text': text,
        'sent': true,
        'time':
            '${TimeOfDay.now().hour}:${TimeOfDay.now().minute.toString().padLeft(2, '0')}',
      });
    });
    _messageController.clear();
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBF9),
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              physics: const BouncingScrollPhysics(),
              itemCount: _messages.length,
              itemBuilder: (_, i) {
                final m = _messages[i];
                return Column(
                  children: [
                    if (i == 0)
                      const Padding(
                        padding: EdgeInsets.only(bottom: 12),
                        child: Text("Aujourd'hui",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 10,
                              color: _subText,
                            )),
                      ),
                    _buildBubble(m),
                  ],
                );
              },
            ),
          ),
          _buildInputBar(),
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
        boxShadow: [
          BoxShadow(
            color: Color(0x554CAF50),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 8,
        bottom: 12,
        left: 12,
        right: 16,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 34, height: 34,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_back,
                  color: Colors.white, size: 17),
            ),
          ),
          const SizedBox(width: 10),
          Stack(
            children: [
              Container(
                width: 38, height: 38,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.25),
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: Colors.white.withOpacity(0.4),
                      width: 1.5),
                ),
                child: Center(
                  child: Text(widget.avatar,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      )),
                ),
              ),
              if (widget.isOnline)
                Positioned(
                  bottom: 1, right: 1,
                  child: Container(
                    width: 10, height: 10,
                    decoration: BoxDecoration(
                      color: const Color(0xFF69F0AE),
                      shape: BoxShape.circle,
                      border: Border.all(color: _green, width: 1.5),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.name,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    )),
                Text(
                  widget.isOnline ? '🟢 En ligne' : '⚫ Hors ligne',
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 10,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          // ← زر الهاتف محذوف
        ],
      ),
    );
  }

  Widget _buildBubble(Map<String, dynamic> m) {
    final isSent = m['sent'] as bool;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment:
            isSent ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isSent) ...[
            Container(
              width: 28, height: 28,
              decoration: BoxDecoration(
                color: widget.avatarColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(widget.avatar,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    )),
              ),
            ),
            const SizedBox(width: 6),
          ],
          Column(
            crossAxisAlignment: isSent
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.65,
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 9),
                decoration: BoxDecoration(
                  gradient: isSent
                      ? const LinearGradient(
                          colors: [_greenDark, _green],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : null,
                  color: isSent ? null : Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(16),
                    topRight: const Radius.circular(16),
                    bottomLeft: Radius.circular(isSent ? 16 : 4),
                    bottomRight: Radius.circular(isSent ? 4 : 16),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: isSent
                          ? _green.withOpacity(0.2)
                          : Colors.black.withOpacity(0.05),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(m['text'] as String,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      color: isSent ? Colors.white : _textDark,
                      height: 1.4,
                    )),
              ),
              const SizedBox(height: 3),
              Text(m['time'] as String,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 9,
                    color: _subText,
                  )),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInputBar() {
    return Container(
      padding: EdgeInsets.fromLTRB(
          16, 8, 16, MediaQuery.of(context).padding.bottom + 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: _greenPale,
                borderRadius: BorderRadius.circular(24),
              ),
              child: TextField(
                controller: _messageController,
                decoration: const InputDecoration(
                  hintText: 'Écrire un message...',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: 16, vertical: 10),
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
                maxLines: null,
                onSubmitted: (_) => _sendMessage(),
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: _sendMessage,
            child: Container(
              width: 44, height: 44,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [_greenDark, _green],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Color(0x554CAF50),
                    blurRadius: 8,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: const Icon(Icons.send_rounded,
                  color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}