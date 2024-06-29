import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import '../bloc/path_bloc_bloc.dart';
import 'results_list_screen.dart';

class TaskProgressScreen extends StatefulWidget {
  final String apiUrl;

  TaskProgressScreen({required this.apiUrl});

  @override
  _TaskProgressScreenState createState() => _TaskProgressScreenState();
}

class _TaskProgressScreenState extends State<TaskProgressScreen> {
  double _progress = 0.0;
  bool _isLoading = false;
  String? _errorMessage;

  void _sendResults() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    // try {
    //   final response = await http.get(Uri.parse(widget.apiUrl));
    //   if (response.statusCode == 200) {
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //           builder: (context) =>
    //               ResultsListScreen(results: jsonDecode(response.body))),
    //     );
    //   } else {
    //     setState(() {
    //       _errorMessage = 'Помилка при відправці результатів';
    //     });
    //   }
    // } catch (e) {
    //   setState(() {
    //     _errorMessage = 'Помилка при відправці результатів';
    //   });
    // } finally {
    //   setState(() {
    //     _isLoading = false;
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Виконання завдання'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        leading: InkWell(
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: BlocBuilder<PathBlocBloc, PathBlocState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                LinearProgressIndicator(value: _progress),
                SizedBox(height: 20),
                if (_isLoading)
                  CircularProgressIndicator()
                else
                  ElevatedButton(
                    onPressed: _sendResults,
                    child: const Text('Send results to server'),
                  ),
                if (_errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text(
                      _errorMessage!,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
