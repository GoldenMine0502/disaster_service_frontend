import 'dart:async';

import 'package:flutter/material.dart';
import 'package:synchronized/synchronized.dart';

import 'api/api_chat.dart';
import 'api/dto/dto_chat.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> with WidgetsBindingObserver {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatDTO> _messages = [];
  Timer? _timer;
  final lock = Lock();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    startTimer();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    _timer?.cancel(); // 기존 타이머가 있으면 취소
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (mounted) {
        _updateMessages();
        }
    });
  }

  Future<void> _sendMessage() async {
    if (_controller.text.isNotEmpty) {
      var text = _controller.text;
      _controller.clear();
      await sendChat(RequestSendChat(text: text));
      _updateMessages();
    }
  }

  Future<void> _updateMessages() async {
    var alreadyScrolled = _isScrolledToBottom();
    var messages = await fetchChatList();

    await lock.synchronized(() async {
      _messages.clear();
      _messages.addAll(messages.list);

    });

    if(alreadyScrolled) {
      _scrollToBottom();
    }

    setState(() {});
  }

  bool _isScrolledToBottom() {
    return _scrollController.offset >= _scrollController.position.maxScrollExtent;
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                var chat = _messages[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          chat.ip, // Display the IP
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Container(
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: Colors.blue[100],
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text(
                            chat.text,
                            style: const TextStyle(fontSize: 16.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Type a message",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}