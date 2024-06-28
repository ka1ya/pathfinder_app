import 'package:flutter/material.dart';
import 'task_progress_screen.dart';

class UrlInputScreen extends StatefulWidget {
  @override
  _UrlInputScreenState createState() => _UrlInputScreenState();
}

class _UrlInputScreenState extends State<UrlInputScreen> {
  final TextEditingController _urlController = TextEditingController();
  String? _errorMessage;

  void _startProcess() {
    final url = _urlController.text;
    if (Uri.tryParse(url)?.hasAbsolutePath ?? false) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TaskProgressScreen(apiUrl: url)),
      );
    } else {
      setState(() {
        _errorMessage = 'Unccorect URL';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Введіть API URL'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _urlController,
              decoration: InputDecoration(
                labelText: 'API URL',
                errorText: _errorMessage,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _startProcess,
              child: Text('Start'),
            ),
          ],
        ),
      ),
    );
  }
}
