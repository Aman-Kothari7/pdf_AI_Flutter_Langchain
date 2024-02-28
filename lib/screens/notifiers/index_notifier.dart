import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:data_ai_chatbpt/core/config.dart';
import 'package:data_ai_chatbpt/services/langchain_service_impl.dart';
import 'package:flutter/services.dart';
import 'package:langchain/langchain.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
part 'index_notifier.g.dart';

enum IndexState {
  intial,
  loading,
  loaded,
  error,
}

@riverpod
class IndexNotifier extends _$IndexNotifier {
  @override
  IndexState build() => IndexState.intial;

  void createAndUploadPineConeindex() async {
    const vectorDimension = 1536;
    state = IndexState.loading;

    try {
      await ref
          .read(langchainServiceProvider)
          .createPineConeIndex(ServiceConfig.indexName, vectorDimension);

      final docs = await fetchDocuments();

      await ref
          .read(langchainServiceProvider)
          .updatePineConeIndex(ServiceConfig.indexName, docs);

      state = IndexState.error;
    } catch (e) {
      print("Error: $e");
      state = IndexState.error;
    }
  }

  Future<List<Document>> fetchDocuments() async {
    try {
      final textFilePathFromPdf = await convertPdfToTextAndSaveInDir();
      final loader = TextLoader(textFilePathFromPdf);
      final documents = await loader.load();
      return documents;
    } catch (e) {
      throw Exception("Error creating pinecone documents");
    }
  }

  Future<String> convertPdfToTextAndSaveInDir() async {
    try {
      final List<String> pdfFiles = [
        'assets/pdf/sample.pdf',
        'assets/pdf/B027_ML_Exp4.pdf',
      ];

      final StringBuffer allText = StringBuffer();
      for (String filePath in pdfFiles) {
        final pdfFromAsset = await rootBundle.load(filePath);
        final document =
            PdfDocument(inputBytes: pdfFromAsset.buffer.asUint8List());

        String text = PdfTextExtractor(document).extractText();
        allText.write(text);
        document.dispose();
      }

      final localPath = await _localPath;
      File file = File('$localPath/output.txt');
      final res = await file.writeAsString(allText.toString());

      return res.path;
    } catch (e) {
      throw Exception('Error converting pdfs to text');
    }
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
}
