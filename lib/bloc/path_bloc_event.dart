part of 'path_bloc_bloc.dart';

abstract class PathBlocEvent extends Equatable {
  const PathBlocEvent();

  @override
  List<Object> get props => [];
}

class FetchDataEvent extends PathBlocEvent {
  final String baseUrl;

  FetchDataEvent(this.baseUrl);

  @override
  List<Object> get props => [baseUrl];
}

class SendResultsEvent extends PathBlocEvent {
  final dynamic results;
  final String baseUrl;
  SendResultsEvent(this.results, this.baseUrl);

  @override
  List<Object> get props => [results, baseUrl];
}
