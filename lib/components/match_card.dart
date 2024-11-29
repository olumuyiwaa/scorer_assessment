import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/assessment_bloc.dart';
import '../bloc/assessment_event.dart';
import '../bloc/assessment_state.dart';

class MatchCard extends StatelessWidget {
  const MatchCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MatchBloc()..add(FetchMatchDetails()),
      child: BlocBuilder<MatchBloc, MatchState>(
        builder: (context, state) {
          if (state.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.errorMessage != null) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          }

          if (state.matchData != null) {
            final event = state.matchData!;
            Uint8List homeLogo = base64Decode(event['homeTeam']['logo']);
            Uint8List awayLogo = base64Decode(event['awayTeam']['logo']);

            return Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xFFFCFCFC),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0XFFB5B5B5).withOpacity(0.2),
                    blurRadius: 20,
                    offset: const Offset(2, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 16),
                    color: const Color(0XFF008F8F),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${event['tournament']['uniqueTournament']['name']}',
                          style: const TextStyle(color: Colors.white),
                        ),
                        Text('${event['roundInfo']['name']}',
                            style: const TextStyle(color: Colors.white))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color(0XFFE0E0E0),
                            width: 0.5,
                          ),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Image.memory(
                                  homeLogo,
                                  height: 24,
                                  width: 24,
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(event['homeTeam']['name']),
                              ],
                            ),
                            Column(
                              children: [
                                Text('${event['season']['year']}',
                                    style: const TextStyle(
                                        fontSize: 11,
                                        color: Color(0XFF828282))),
                                Text(
                                  '${event['homeScore']['display']} - ${event['awayScore']['display']}',
                                  style: const TextStyle(fontSize: 18),
                                ),
                                const Text('Full-time',
                                    style: TextStyle(
                                        fontSize: 11,
                                        color: Color(0XFF828282))),
                              ],
                            ),
                            Column(
                              children: [
                                Image.memory(
                                  awayLogo,
                                  height: 24,
                                  width: 24,
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(event['awayTeam']['name'])
                              ],
                            )
                          ]),
                    ),
                  )
                ],
              ),
            );
          }

          return const Center(child: Text('No data available.'));
        },
      ),
    );
  }
}
