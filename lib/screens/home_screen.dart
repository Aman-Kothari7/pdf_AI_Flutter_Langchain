import 'package:data_ai_chatbpt/screens/notifiers/index_notifier.dart';
import 'package:data_ai_chatbpt/screens/notifiers/query_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final _formKey = GlobalKey<FormState>();

class homeScreen extends HookConsumerWidget {
  const homeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final queryState = ref.watch(queryNotifierProvider);
    final queryTextController = useTextEditingController();

    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Ask a question'),
                TextField(
                  controller: queryTextController,
                  decoration: const InputDecoration(
                    hintText: 'Enter a query',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: ElevatedButton(
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) return;
                      ref
                          .read(queryNotifierProvider.notifier)
                          .queryPineConeIndex(queryTextController.text);
                    },
                    child: Text('Ask'),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                OutlinedButton(
                  onPressed: () {
                    print("Clicked upload");
                    ref
                        .read(indexNotifierProvider.notifier)
                        .createAndUploadPineConeindex();
                  },
                  child: Text("Upload PDF"),
                ),
                const SizedBox(
                  height: 20,
                ),
                if (queryState.state == QueryEnum.loading)
                  const LinearProgressIndicator(),
                if (queryState.state == QueryEnum.loaded)
                  Align(
                      alignment: Alignment.center,
                      child: Text(queryState.result))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
