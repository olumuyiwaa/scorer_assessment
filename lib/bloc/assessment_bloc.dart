import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;

import 'assessment_event.dart';
import 'assessment_state.dart';

const String baseUrl =
    'https://raw.githubusercontent.com/RexStev/3scorers-assessment/main/dataSamples';

//Momentum
class MomentumBloc extends Bloc<MomentumEvent, MomentumState> {
  MomentumBloc() : super(const MomentumState()) {
    on<FetchMomentumData>(_onFetchMomentumData);
  }

  Future<void> _onFetchMomentumData(
      FetchMomentumData event, Emitter<MomentumState> emit) async {
    emit(state.copyWith(loading: true));
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/momentum.json'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['success'] == true) {
          final List<dynamic> graphPointsRaw = data['data']['graphPoints'];
          final graphPoints = graphPointsRaw
              .map((point) => {
                    'minute': point['minute'],
                    'value': point['value'],
                  })
              .toList();
          emit(state.copyWith(loading: false, graphPoints: graphPoints));
        } else {
          throw Exception("Data fetch failed: Success field is false");
        }
      } else {
        throw Exception("Failed to load JSON: ${response.statusCode}");
      }
    } catch (e) {
      emit(state.copyWith(
        loading: false,
        errorMessage: e.toString(),
      ));
    }
  }
}

//Match Details
class MatchBloc extends Bloc<MatchEvent, MatchState> {
  MatchBloc() : super(const MatchState()) {
    on<FetchMatchDetails>(_onFetchMatchDetails);
  }

  Future<void> _onFetchMatchDetails(
      FetchMatchDetails event, Emitter<MatchState> emit) async {
    emit(state.copyWith(loading: true));

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/match.json'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['success'] == true) {
          emit(state.copyWith(
            loading: false,
            matchData: data['data']['event'],
          ));
        } else {
          throw Exception("Data fetch failed: success field is false");
        }
      } else {
        throw Exception("Failed to fetch data: ${response.statusCode}");
      }
    } catch (e) {
      emit(state.copyWith(
        loading: false,
        errorMessage: e.toString(),
      ));
    }
  }
}

//match incidents

class IncidentBloc extends Bloc<IncidentEvent, IncidentState> {
  IncidentBloc() : super(const IncidentState()) {
    on<FetchIncidentsData>(_onFetchIncidentsData);
  }

  Future<void> _onFetchIncidentsData(
      FetchIncidentsData event, Emitter<IncidentState> emit) async {
    emit(state.copyWith(loading: true));
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/incidents.json'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['success'] == true) {
          final List<dynamic> incidentsRaw = data['data']['incidents'];

          final incidents = incidentsRaw.map((incident) {
            return {
              'text': incident['text'],
              'homeScore': incident['homeScore'],
              'awayScore': incident['awayScore'],
              'incidentType': incident['incidentType'],
              'isHome': incident['isHome'],
              'incidentClass': incident['incidentClass'],
              'length': incident['length'],
              'time': incident['time'],
              'description': incident['description'],
              'sequence': incident['sequence'],
              'playerName': incident['player']?['name'] ?? 'Unknown',
              'playerOut': incident['playerOut']?['name'] ?? 'Unknown',
              'playerIn': incident['playerIn']?['name'] ?? 'Unknown',
              'reason': incident['reason'],
            };
          }).toList();

          emit(state.copyWith(loading: false, incidents: incidents));
        } else {
          throw Exception("Data fetch failed: Success field is false");
        }
      } else {
        throw Exception("Failed to load JSON: ${response.statusCode}");
      }
    } catch (e) {
      emit(state.copyWith(
        loading: false,
        errorMessage: e.toString(),
      ));
    }
  }
}

//player image
class PlayerImageBloc extends Bloc<PlayerImageEvent, PlayerImageState> {
  PlayerImageBloc() : super(const PlayerImageState()) {
    on<FetchPlayerImageDetails>(_onFetchPlayerImageDetails);
  }

  Future<void> _onFetchPlayerImageDetails(
      FetchPlayerImageDetails event, Emitter<PlayerImageState> emit) async {
    emit(state.copyWith(loading: true, errorMessage: null));

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/samplePlayerImage.json'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;

        if (data['success'] == true && data.containsKey('data')) {
          emit(state.copyWith(
            loading: false,
            playerImageData: data['data'] as Map<String, dynamic>,
          ));
        } else {
          throw Exception(
              "Unexpected response: ${data['message'] ?? 'No message'}");
        }
      } else {
        throw Exception("HTTP error: ${response.statusCode}");
      }
    } catch (e) {
      emit(state.copyWith(
        loading: false,
        errorMessage: "Failed to fetch player image: ${e.toString()}",
      ));
    }
  }
}
