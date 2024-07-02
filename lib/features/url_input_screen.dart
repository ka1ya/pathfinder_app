import 'package:flutter/material.dart';
import 'package:pathfinding_app/bloc/path_bloc_bloc.dart';
import 'task_progress_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UrlInputScreen extends StatefulWidget {
  @override
  _UrlInputScreenState createState() => _UrlInputScreenState();
}

class _UrlInputScreenState extends State<UrlInputScreen> {
  final TextEditingController _urlController = TextEditingController();
  String? _errorMessage;
  late String url;

  void _startProcess(BuildContext context) {
    url = _urlController.text;
    if (Uri.tryParse(url)?.hasAbsolutePath ?? false) {
      context.read<PathBloc>().add(FetchDataEvent(url));
    } else {
      setState(() {
        _errorMessage = 'Incorrect URL';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PathBloc(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('API URL'),
          backgroundColor: Colors.blue,
        ),
        body: BlocConsumer<PathBloc, PathBlocState>(
          listener: (context, state) {
            if (state is PathfinderLoaded) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      TaskProgressScreen(apiUrl: url, apiData: state.data),
                ),
              );
            } else if (state is PathfinderError) {
              setState(() {
                _errorMessage = state.message;
              });
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    alignment: Alignment.center,
                    height: 100,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextField(
                      controller: _urlController,
                      decoration: InputDecoration(
                        labelText: 'Enter API URL',
                        errorText: _errorMessage,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: MediaQuery.of(context).size.width * 1,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromRGBO(244, 243, 243, 1),
                      border: Border.all(color: Colors.black),
                    ),
                    child: ElevatedButton(
                      onPressed: () => _startProcess(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        'Start',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
