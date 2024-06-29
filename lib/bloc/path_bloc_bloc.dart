import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pathfinding_app/models/api_model.dart';

import '../api/api_service.dart';

part 'path_bloc_event.dart';
part 'path_bloc_state.dart';

class PathBlocBloc extends Bloc<PathBlocEvent, PathBlocState> {
  PathBlocBloc() : super(PathfinderInitial()) {
    ApiService apiService = ApiService();

    on<FetchDataEvent>((event, emit) async {
      final response = await apiService.fetchTasks(event.baseUrl);

      // emit(PathfinderLoaded(response));
      print('response: ${response}');
    });

    on<SendResultsEvent>((event, emit) async {
      final response =
          await apiService.sendResults(event.results, event.baseUrl);

      // emit(PathfinderLoaded(response));
      print('response: ${response}');
    });
  }
}
