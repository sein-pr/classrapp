import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import '../../utils/app_colors.dart';

class ChatMessage {
  final String message;
  final DateTime sentTimestamp;
  final bool isFromUser;
  final File? attachment;

  ChatMessage({
    required this.message,
    required this.sentTimestamp,
    required this.isFromUser,
    this.attachment,
  });
}

class ChatWidget extends StatefulWidget {
  const ChatWidget({super.key});

  @override
  ChatWidgetState createState() => ChatWidgetState();

  static void addMessage(
    BuildContext context, {
    required String message,
    required bool isFromUser,
    File? attachment,
  }) {
    ChatWidgetState? state = ChatWidgetState.of(context);
    if (state != null) {
      state.addMessage(
        message: message,
        isFromUser: isFromUser,
        attachment: attachment,
      );
    }
  }
}

class ChatWidgetState extends State<ChatWidget> {
  static ChatWidgetState? of(BuildContext context) {
    return context.findAncestorStateOfType<ChatWidgetState>();
  }

  final List<ChatMessage> _messages = [];

  void addMessage({
    required String message,
    required bool isFromUser,
    File? attachment,
  }) {
    setState(() {
      _messages.add(
        ChatMessage(
          message: message,
          sentTimestamp: DateTime.now(),
          isFromUser: isFromUser,
          attachment: attachment,
        ),
      );
    });
  }

  void _bubbleSort(List<ChatMessage> messages) {
    int n = messages.length;
    for (int i = 0; i < n - 1; i++) {
      for (int j = 0; j < n - i - 1; j++) {
        if (messages[j].sentTimestamp.isAfter(messages[j + 1].sentTimestamp)) {
          // Swap elements
          ChatMessage temp = messages[j];
          messages[j] = messages[j + 1];
          messages[j + 1] = temp;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _bubbleSort(_messages);

    return ListView.builder(
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        final message = _messages[index];
        final messageTextStyle = TextStyle(
          color: message.isFromUser ? Colors.white : AppColors.primaryColor,
          fontSize: 16.0,
        );
        final timeTextStyle = TextStyle(
          color: message.isFromUser
              ? Colors.white.withOpacity(0.7)
              : AppColors.primaryColor.withOpacity(0.7),
          fontSize: 12.0,
        );

        List<TextSpan> messageTextSpans = [];
        final messageText = message.message;
        int currentIndex = 0;

        for (int i = 0; i < messageText.length; i++) {
          if (isEmoji(messageText[i])) {
            if (i > currentIndex) {
              messageTextSpans.add(
                TextSpan(
                  text: messageText.substring(currentIndex, i),
                  style: messageTextStyle,
                ),
              );
            }
            messageTextSpans.add(
              TextSpan(
                text: messageText[i],
                style: TextStyle(
                  color: Colors.yellow,
                  fontSize: 16.0,
                ),
              ),
            );
            currentIndex = i + 1;
          }
        }

        if (currentIndex < messageText.length) {
          messageTextSpans.add(
            TextSpan(
              text: messageText.substring(currentIndex),
              style: messageTextStyle,
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (message.isFromUser)
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                          bottomLeft: Radius.circular(20.0),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: messageTextSpans,
                            ),
                          ),
                          if (message.attachment != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12.0),
                                child: Image.file(
                                  message.attachment!,
                                  width: 150.0,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          const SizedBox(height: 4.0),
                          Text(
                            '${message.sentTimestamp.hour}:${message.sentTimestamp.minute}',
                            style: timeTextStyle,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              if (!message.isFromUser)
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: messageTextSpans,
                          ),
                        ),
                        if (message.attachment != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: Image.file(
                                message.attachment!,
                                width: 150.0,
                                height: 100.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        const SizedBox(height: 4.0),
                        Text(
                          '${message.sentTimestamp.hour}:${message.sentTimestamp.minute}',
                          style: timeTextStyle,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  bool isEmoji(String character) {
    // Check if the character is an emoji
    return character.codeUnitAt(0) > 0x1F000;
  }
}
