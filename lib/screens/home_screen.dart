import 'package:data_ai_chatbpt/screens/notifiers/chat_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:data_ai_chatbpt/screens/notifiers/index_notifier.dart';
import 'package:data_ai_chatbpt/screens/notifiers/query_notifier.dart';


class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final queryTextController = useTextEditingController();
    final messages =
        ref.watch(chatMessagesProvider); 

    ref.listen<QueryState>(queryNotifierProvider, (_, current) {
      if (current.state == QueryEnum.loaded) {
        ref
            .read(chatMessagesProvider.notifier)
            .addMessage("AI: ${current.result}");
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("PDF AI Chat"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final isUserMessage = message.startsWith("You:");
                return Align(
                  alignment:
                      isUserMessage ? Alignment.topRight : Alignment.topLeft,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    margin: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color:
                          isUserMessage ? Colors.blue[200] : Colors.grey[200],
                    ),
                    child: Text(message),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.attach_file),
                  onPressed: () {
                    ref
                        .read(indexNotifierProvider.notifier)
                        .createAndUploadPineConeindex();
                    ref
                        .read(chatMessagesProvider.notifier)
                        .addMessage("You: Uploaded a PDF");
                  },
                ),
                Expanded(
                  child: TextField(
                    controller: queryTextController,
                    decoration:
                        const InputDecoration(hintText: 'Send a message'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    final query = queryTextController.text.trim();
                    if (query.isNotEmpty) {
                      ref
                          .read(queryNotifierProvider.notifier)
                          .queryPineConeIndex(query);
                      ref
                          .read(chatMessagesProvider.notifier)
                          .addMessage("You: $query");
                      queryTextController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
