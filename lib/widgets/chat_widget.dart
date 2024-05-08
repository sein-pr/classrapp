import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/app_colors.dart';

class ChatMessage {
  final String message;
  final DateTime timestamp;
  final bool isFromUser;

  ChatMessage({
    required this.message,
    required this.timestamp,
    required this.isFromUser,
  });
}

class ChatWidget extends StatelessWidget {
  final List<ChatMessage> _messages = [
    ChatMessage(
      message: 'This is a sample message from the user. 😀',
      timestamp: DateTime.now().subtract(Duration(minutes: 5)),
      isFromUser: true,
    ),
    ChatMessage(
      message: 'This is a sample message from the teacher. 🤔',
      timestamp: DateTime.now().subtract(Duration(minutes: 2)),
      isFromUser: false,
    ),
    ChatMessage(
      message: 'Another sample message from the user. 🎉',
      timestamp: DateTime.now(),
      isFromUser: true,
    ),
  ];

  void _bubbleSort(List<ChatMessage> messages) {
    int n = messages.length;
    for (int i = 0; i < n - 1; i++) {
      for (int j = 0; j < n - i - 1; j++) {
        if (messages[j].timestamp.isAfter(messages[j + 1].timestamp)) {
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
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.only(
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
                          SizedBox(height: 4.0),
                          Text(
                            '${message.timestamp.hour}:${message.timestamp.minute}',
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
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
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
                        SizedBox(height: 4.0),
                        Text(
                          '${message.timestamp.hour}:${message.timestamp.minute}',
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
