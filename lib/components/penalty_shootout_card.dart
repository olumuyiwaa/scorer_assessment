import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/assessment_bloc.dart';
import '../bloc/assessment_event.dart';
import '../bloc/assessment_state.dart';

class PenaltyShootoutCard extends StatelessWidget {
  final String homeLogo;
  final String awayLogo;
  final int scoreHome;
  final int scoreAway;

  const PenaltyShootoutCard({
    super.key,
    required this.homeLogo,
    required this.awayLogo,
    required this.scoreHome,
    required this.scoreAway,
  });

  @override
  Widget build(BuildContext context) {
    Uint8List homeIcon = base64Decode(homeLogo);
    Uint8List awayIcon = base64Decode(awayLogo);

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
          // Header
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            color: const Color(0XFF008F8F),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Penalty Shootout',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 20, bottom: 20),
            child: Row(
              children: [
                // Team Logos
                Column(
                  children: [
                    Text(
                      '(${scoreHome.toString()})',
                      style: const TextStyle(color: Colors.green),
                    ),
                    Image.memory(
                      homeIcon,
                      height: 24,
                      width: 24,
                    ),
                    const SizedBox(height: 6),
                    Text('(${scoreAway.toString()})',
                        style: const TextStyle(color: Colors.red)),
                    Image.memory(
                      awayIcon,
                      height: 24,
                      width: 24,
                    ),
                  ],
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0.5, 0.5],
                        colors: [
                          Color(0XFFFFF4CE),
                          Color(0XFFFFBDC7),
                        ],
                      ),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: BlocProvider(
                      create: (_) => IncidentBloc()..add(FetchIncidentsData()),
                      child: BlocBuilder<IncidentBloc, IncidentState>(
                        builder: (context, state) {
                          if (state.loading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (state.errorMessage.isNotEmpty) {
                            return Center(
                              child: Text('Error: ${state.errorMessage}'),
                            );
                          }

                          return ConstrainedBox(
                            constraints: const BoxConstraints(maxHeight: 100),
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              reverse: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: state.incidents.length,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(width: 8),
                              itemBuilder: (context, index) {
                                final incident = state.incidents[index];
                                if (incident['incidentType'] !=
                                    'penaltyShootout') {
                                  return const SizedBox.shrink();
                                }

                                return Column(
                                  mainAxisAlignment:
                                      (incident['isHome'] == true)
                                          ? MainAxisAlignment.start
                                          : MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                      child: Image.asset(
                                        'assets/icons/${incident['incidentClass']}.png',
                                        width: 24,
                                        height: 24,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
