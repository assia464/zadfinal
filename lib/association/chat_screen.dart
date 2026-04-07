import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _messageController = TextEditingController();
  // زدت ScrollController باش الشاشة تهبط وحدها كي تبعتي ميساج
  final _scrollController = ScrollController();

  final List<Map<String, dynamic>> _messages = [
    {
      'text': 'Bonjour ! Je suis arrivé à la boulangerie.',
      'isMe': false,
      'time': '14:20',
    },
    {
      'text': 'Parfait ! Le pain est bien préparé ?',
      'isMe': true,
      'time': '14:21',
    },
    {'text': 'Oui, 30 unités dans des sacs.', 'isMe': false, 'time': '14:22'},
    {'text': 'Merci beaucoup ! On vous attend', 'isMe': true, 'time': '14:25'},
  ];

  // 1. هادي هي الدالة اللي تبعت الميساج (زدتها لك)
  void _sendMessage() {
    String text = _messageController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _messages.add({
          'text': text,
          'isMe': true,
          'time':
              "${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}",
        });
        _messageController.clear(); // تفرغ الخانة بعد الإرسال
      });

      // باش تهبط لتحت لآخر ميساج
      Future.delayed(const Duration(milliseconds: 100), () {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header (كما هو)
          Container(
            padding: const EdgeInsets.fromLTRB(10, 50, 20, 20),
            decoration: const BoxDecoration(
              color: Color(0xFF1B5E20),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                    size: 20,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                const CircleAvatar(
                  backgroundColor: Colors.white24,
                  child: Text('AH', style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'ASSIA HASNAOUI',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.phone, color: Colors.white),
                  onPressed: () async {
                    final Uri callUri = Uri(
                      scheme: 'tel',
                      path: '+213123456789',
                    );
                    if (await canLaunchUrl(callUri)) await launchUrl(callUri);
                  },
                ),
              ],
            ),
          ),

          // Messages List
          Expanded(
            child: ListView.builder(
              controller: _scrollController, // ربطته هنا
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                bool isMe = msg['isMe'];
                return Align(
                  alignment: isMe
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: isMe
                          ? const Color(0xFF1B5E20)
                          : const Color(0xFFF5F7FA),
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(15),
                        topRight: const Radius.circular(15),
                        bottomLeft: Radius.circular(isMe ? 15 : 0),
                        bottomRight: Radius.circular(isMe ? 0 : 15),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: isMe
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        Text(
                          msg['text'],
                          style: TextStyle(
                            color: isMe ? Colors.white : Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          msg['time'],
                          style: TextStyle(
                            fontSize: 9,
                            color: isMe ? Colors.white70 : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Input Area (هنا عدلت الـ Button)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 30),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F7FA),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                        hintText: 'Message...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: const Color(0xFF1B5E20),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white, size: 18),
                    onPressed: _sendMessage, // 2. هنا ربطنا الزر بالدالة
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
