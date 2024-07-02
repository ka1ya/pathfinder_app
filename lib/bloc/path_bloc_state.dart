part of 'path_bloc_bloc.dart';

abstract class PathBlocState extends Equatable {
  const PathBlocState();

  @override
  List<Object> get props => [];
}

class PathfinderInitial extends PathBlocState {}

class PathfinderLoading extends PathBlocState {}

class PathfinderLoaded extends PathBlocState {
  final List<dynamic> data;

  PathfinderLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class PathfinderError extends PathBlocState {
  final String message;

  PathfinderError(this.message);

  @override
  List<Object> get props => [message];
}

class PathResultsSent extends PathBlocState {
  final List<Map<String, dynamic>> calculatedData;
  final dynamic responseData;

  PathResultsSent(this.calculatedData, this.responseData);

  @override
  List<Object> get props => [calculatedData, responseData];
}

class PathsCalculated extends PathBlocState {
  final List<dynamic> results;

  PathsCalculated(this.results);

  @override
  List<Object> get props => [results];
}
