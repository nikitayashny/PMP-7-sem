import 'package:equatable/equatable.dart';

abstract class GameEvent extends Equatable {

  @override
  List<Object> get props => [];
}

class LoadGames extends GameEvent {}