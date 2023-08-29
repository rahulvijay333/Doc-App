import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewerScreen extends StatelessWidget {
  final String pdfPath; // The path or URL of the PDF file.

  PdfViewerScreen({required this.pdfPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View uploaded Certificate'),
      ),
      body: Container(
        child: SfPdfViewer.network(pdfPath),
      ),
    );
  }
}
