import 'package:equatable/equatable.dart';

//momentum
abstract class MomentumEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchMomentumData extends MomentumEvent {}

//match details
abstract class MatchEvent extends Equatable {
  const MatchEvent();

  @override
  List<Object> get props => [];
}

class FetchMatchDetails extends MatchEvent {}

//incidents

abstract class IncidentEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchIncidentsData extends IncidentEvent {}

//player image
abstract class PlayerImageEvent extends Equatable {
  const PlayerImageEvent();

  @override
  List<Object?> get props => [];
}

class FetchPlayerImageDetails extends PlayerImageEvent {}
