import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FileSelection extends StatefulWidget {
  @override
  _FileSelectionState createState() => _FileSelectionState();
}

class _FileSelectionState extends State<FileSelection> {
  String _selectedFilePath = '';

  Future<void> _pickPDFFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null) {
        setState(() {
          _selectedFilePath = result.files.single.path!;
        });
      }
    } catch (e) {
      print('Error picking PDF file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF File Selection'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _pickPDFFile,
              child: Text('Pick PDF File'),
            ),
            SizedBox(height: 16.0),
            Text(
              'Selected PDF File: $_selectedFilePath',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
