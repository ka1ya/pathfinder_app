import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pathfinding_app/models/grid_data_model.dart';
import 'package:pathfinding_app/utils/pathfinding.dart';

import '../api/api_service.dart';

part 'path_bloc_event.dart';
part 'path_bloc_state.dart';

class PathBloc extends Bloc<PathBlocEvent, PathBlocState> {
  PathBloc() : super(PathfinderInitial()) {
    ApiService apiService = ApiService();

    on<FetchDataEvent>((event, emit) async {
      emit(PathfinderLoading());
      try {
        final response = await apiService.fetchTasks(event.baseUrl);
        emit(PathfinderLoaded(response['data']));
      } catch (e) {
        emit(PathfinderError('Failed to fetch data'));
      }
    });

    on<SendResultsEvent>((event, emit) async {
      try {
        final List<Map<String, dynamic>> jsonResults = event.results
            .map<Map<String, dynamic>>((result) => result.toJson())
            .toList();

        final response =
            await apiService.sendResults(jsonResults, event.baseUrl);
        emit(PathResultsSent(jsonResults, response["data"]));
      } catch (e) {
        emit(PathfinderError("Failed to send results"));
      }
    });

    on<CalculatePathsEvent>((event, emit) async {
      try {
        final List<GridData> dataList = List.generate(
          event.data.length,
          (index) => GridData.fromJson(event.data[index]),
        );

        final List<PathResult> results = [];
        for (var gridData in dataList) {
          final result = Pathfinding.findShortestPath(
              gridData.field, gridData.start, gridData.end);
          results.add(PathResult(id: gridData.id, result: result));
        }
        emit(PathsCalculated(results));
      } catch (e) {
        emit(PathfinderError('Error calculating paths'));
      }
    });
  }
}
