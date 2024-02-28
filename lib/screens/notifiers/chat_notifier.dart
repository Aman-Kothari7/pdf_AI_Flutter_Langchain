import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatMessagesProvider =
    StateNotifierProvider<ChatMessagesNotifier, List<String>>((ref) {
  return ChatMessagesNotifier();
});

class ChatMessagesNotifier extends StateNotifier<List<String>> {
  ChatMessagesNotifier() : super([]);

  void addMessage(String message) {
    state = [...state, message];
    
  }
}
