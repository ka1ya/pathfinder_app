import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pathfinding_app/bloc/path_bloc_bloc.dart';
import 'result_detail_screen.dart';

class ResultsListScreen extends StatefulWidget {
  final List<dynamic> pathData;
  final List<dynamic> apiData;
  final List<int> gridSizeList;
  ResultsListScreen(
      {required this.pathData,
      required this.apiData,
      required this.gridSizeList});

  @override
  State<ResultsListScreen> createState() => _ResultsListScreenState();
}

class _ResultsListScreenState extends State<ResultsListScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PathBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Result list'),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: BlocBuilder<PathBloc, PathBlocState>(
          builder: (context, state) {
            return ListView.builder(
              itemCount: widget.pathData.length,
              itemBuilder: (context, index) {
                final String result = widget.pathData[index]['result']['path'];
                return ListTile(
                  titleAlignment: ListTileTitleAlignment.center,
                  title: Center(
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        Text(
                          result,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Divider(),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ResultDetailScreen(
                                pathData: widget.pathData[index],
                                gridSize: widget.gridSizeList[index],
                              )),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
