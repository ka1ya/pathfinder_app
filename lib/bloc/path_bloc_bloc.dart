import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'path_bloc_event.dart';
part 'path_bloc_state.dart';

class PathBlocBloc extends Bloc<PathBlocEvent, PathBlocState> {
  PathBlocBloc() : super(PathBlocInitial()) {
    on<PathBlocEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
