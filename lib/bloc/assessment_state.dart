import 'package:equatable/equatable.dart';

class MomentumState extends Equatable {
  final bool loading;
  final List<Map<String, dynamic>> graphPoints;
  final String errorMessage;

  const MomentumState({
    this.loading = false,
    this.graphPoints = const [],
    this.errorMessage = '',
  });

  MomentumState copyWith({
    bool? loading,
    List<Map<String, dynamic>>? graphPoints,
    String? errorMessage,
  }) {
    return MomentumState(
      loading: loading ?? this.loading,
      graphPoints: graphPoints ?? this.graphPoints,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [loading, graphPoints, errorMessage];
}

class BestPlayerState extends Equatable {
  final bool loading;
  final String? errorMessage;
  final Map<String, dynamic>? bestPlayer;
  final String? bestPlayerRating;

  const BestPlayerState({
    this.loading = false,
    this.errorMessage,
    this.bestPlayer,
    this.bestPlayerRating,
  });

  BestPlayerState copyWith({
    bool? loading,
    String? errorMessage,
    Map<String, dynamic>? bestPlayer,
    String? bestPlayerRating,
  }) {
    return BestPlayerState(
      loading: loading ?? this.loading,
      errorMessage: errorMessage,
      bestPlayer: bestPlayer ?? this.bestPlayer,
      bestPlayerRating: bestPlayerRating ?? this.bestPlayerRating,
    );
  }

  @override
  List<Object?> get props =>
      [loading, errorMessage, bestPlayer, bestPlayerRating];
}

//match details
class MatchState extends Equatable {
  final bool loading;
  final Map<String, dynamic>? matchData;
  final String? errorMessage;

  const MatchState({
    this.loading = false,
    this.matchData,
    this.errorMessage,
  });

  MatchState copyWith({
    bool? loading,
    Map<String, dynamic>? matchData,
    String? errorMessage,
  }) {
    return MatchState(
      loading: loading ?? this.loading,
      matchData: matchData ?? this.matchData,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [loading, matchData, errorMessage];
}

//match incidents

class IncidentState extends Equatable {
  final bool loading;
  final List<Map<String, dynamic>> incidents;
  final String errorMessage;

  const IncidentState({
    this.loading = false,
    this.incidents = const [],
    this.errorMessage = '',
  });

  IncidentState copyWith({
    bool? loading,
    List<Map<String, dynamic>>? incidents,
    String? errorMessage,
  }) {
    return IncidentState(
      loading: loading ?? this.loading,
      incidents: incidents ?? this.incidents,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [loading, incidents, errorMessage];
}

//player image
class PlayerImageState extends Equatable {
  final bool loading;
  final Map<String, dynamic>? playerImageData;
  final String? errorMessage;

  const PlayerImageState({
    this.loading = false,
    this.playerImageData,
    this.errorMessage,
  });

  PlayerImageState copyWith({
    bool? loading,
    Map<String, dynamic>? playerImageData,
    String? errorMessage,
  }) {
    return PlayerImageState(
      loading: loading ?? this.loading,
      playerImageData: playerImageData ?? this.playerImageData,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [loading, playerImageData, errorMessage];
}
