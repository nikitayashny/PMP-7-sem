import 'package:flutter_bloc/flutter_bloc.dart';
import 'game_event.dart';
import 'game_state.dart';
import 'game.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final List<Game> games;

  GameBloc(this.games) : super(GameInitial()) {
    on<LoadGames>((event, emit) async {
      emit(GameLoading());
      try {

        await Future.delayed(Duration(seconds: 2));
        emit(GameLoaded(games: games));
      } catch (e) {
        emit(GameError(message: 'Failed to load games'));
      }
    });
  }
}