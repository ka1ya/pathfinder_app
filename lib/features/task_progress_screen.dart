import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/path_bloc_bloc.dart';
import 'results_list_screen.dart';

class TaskProgressScreen extends StatefulWidget {
  final String apiUrl;
  final List<dynamic> apiData;
  TaskProgressScreen({required this.apiUrl, required this.apiData});

  @override
  State<TaskProgressScreen> createState() => _TaskProgressScreenState();
}

class _TaskProgressScreenState extends State<TaskProgressScreen> {
  void _sendResults(BuildContext context) {
    final state = context.read<PathBloc>().state;
    print('ListProps: ${state.props}');
    if (state is PathsCalculated) {
      BlocProvider.of<PathBloc>(context)
          .add(SendResultsEvent(state.results, widget.apiUrl));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PathBloc()..add(CalculatePathsEvent(widget.apiData)),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Process Screen'),
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
        body: BlocConsumer<PathBloc, PathBlocState>(
          listener: (context, state) {
            if (state is PathResultsSent) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResultsListScreen(
                    pathData: state.calculatedData,
                    apiData: state.responseData,
                    gridSizeList: widget.apiData
                        .map((element) => (element['field'] as List).length)
                        .toList(),
                  ),
                ),
              );
            } else if (state is PathfinderError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Spacer(),
                    if (state is PathfinderInitial ||
                        state is PathfinderLoading)
                      CircularProgressIndicator()
                    else if (state is PathfinderLoaded ||
                        state is PathsCalculated) ...[
                      CircularProgressIndicator(
                          value: state is PathsCalculated ? 1.0 : 0.0),
                      const Text(
                        '\nYou can send result to server',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ],
                    Spacer(),
                    Container(
                      width: MediaQuery.of(context).size.width * 1,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromRGBO(244, 243, 243, 1),
                        border: Border.all(color: Colors.black),
                      ),
                      child: ElevatedButton(
                        onPressed: state is PathsCalculated
                            ? () => _sendResults(context)
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
                          'Send results to server',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                      ),
                    ),
                    if (state is PathfinderError)
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Text(
                          state.message,
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
