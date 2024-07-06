import 'package:flutter/material.dart';
import 'dart:io';
import '../../utils/app_colors.dart';

// Represents a chat message with optional attachment
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
  const ChatWidget({Key? key}) : super(key: key);

  @override
  ChatWidgetState createState() => ChatWidgetState();

  // Static method to add a new message to the chat
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
  // Static method to find the state of ChatWidget ancestor
  static ChatWidgetState? of(BuildContext context) {
    return context.findAncestorStateOfType<ChatWidgetState>();
  }

  final List<ChatMessage> _messages = [];

  // Adds a new message to the chat
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

  // Sorts messages by sentTimestamp using Dart's built-in sort function
  void _sortByTimestamp(List<ChatMessage> messages) {
    messages.sort((a, b) => a.sentTimestamp.compareTo(b.sentTimestamp));
  }

  @override
  Widget build(BuildContext context) {
    _sortByTimestamp(_messages); // Sort messages by timestamp

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

        // Detect and style emojis within the message
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

        // Add remaining text after the last detected emoji
        if (currentIndex < messageText.length) {
          messageTextSpans.add(
            TextSpan(
              text: messageText.substring(currentIndex),
              style: messageTextStyle,
            ),
          );
        }

        // Build and return the message UI based on sender
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

  // Function to detect emojis
  bool isEmoji(String character) {
    // Check if the character is an emoji
    return character.codeUnitAt(0) > 0x1F000;
  }
}
