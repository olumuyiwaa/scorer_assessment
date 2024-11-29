import 'dart:convert';
import 'dart:typed_data';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/assessment_bloc.dart';
import '../bloc/assessment_event.dart';
import '../bloc/assessment_state.dart';

class LiveMatchMomentumCard extends StatelessWidget {
  final String homeLogo;
  final String awayLogo;

  const LiveMatchMomentumCard(
      {super.key, required this.homeLogo, required this.awayLogo});

  @override
  Widget build(BuildContext context) {
    Uint8List homeIcon = base64Decode(homeLogo);
    Uint8List awayIcon = base64Decode(awayLogo);
    int possessionHome = 60;
    int possessionAway = 40;
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFFFCFCFC),
        boxShadow: [
          BoxShadow(
            color: const Color(0XFFB5B5B5).withOpacity(0.32),
            blurRadius: 20,
            offset: const Offset(2, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            color: const Color(0XFF008F8F),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Live Match Momentum',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('$possessionHome%',
                    style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w700)),
                const Text('Ball Possession',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.normal)),
                Text('$possessionAway%',
                    style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w700)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: possessionHome,
                  child: Container(color: const Color(0XFFE1B726), height: 4),
                ),
                Expanded(
                  flex: possessionAway,
                  child: Container(color: const Color(0XFFCF0C2A), height: 4),
                ),
              ],
            ),
          ),
          BlocProvider(
              create: (_) => MomentumBloc()..add(FetchMomentumData()),
              child: SizedBox(
                  height: 120,
                  child: BlocBuilder<MomentumBloc, MomentumState>(
                      builder: (context, state) {
                    if (state.loading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state.errorMessage.isNotEmpty) {
                      return Center(
                          child: Text('Error: ${state.errorMessage}'));
                    }

                    final graphPoints = state.graphPoints;

                    return Container(
                      padding:
                          const EdgeInsets.only(left: 16, top: 20, bottom: 20),
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Image.memory(
                                homeIcon,
                                height: 20,
                                width: 20,
                              ),
                              Image.memory(
                                awayIcon,
                                height: 20,
                                width: 20,
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
                                      Color(0XFFFFF4CE), // Top half
                                      Color(0XFFFFBDC7), // Bottom half
                                    ],
                                  ),
                                ),
                                child: BarChart(
                                  BarChartData(
                                    gridData: const FlGridData(show: false),
                                    titlesData: const FlTitlesData(
                                      bottomTitles: AxisTitles(
                                        sideTitles:
                                            SideTitles(showTitles: false),
                                      ),
                                      leftTitles: AxisTitles(
                                        sideTitles:
                                            SideTitles(showTitles: false),
                                      ),
                                      rightTitles: AxisTitles(
                                        sideTitles:
                                            SideTitles(showTitles: false),
                                      ),
                                      topTitles: AxisTitles(
                                        sideTitles:
                                            SideTitles(showTitles: false),
                                      ),
                                    ),
                                    borderData: FlBorderData(show: false),
                                    alignment: BarChartAlignment.spaceAround,
                                    maxY: 100,
                                    minY: -100,
                                    barGroups: graphPoints.map((point) {
                                      return BarChartGroupData(
                                        x: point['minute'].toInt(),
                                        barRods: [
                                          BarChartRodData(
                                            borderSide: const BorderSide(
                                                width: 0.3,
                                                color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(0),
                                            toY: point['value'].toDouble(),
                                            color: point['value'] > 0
                                                ? const Color(0XFFE1B726)
                                                : const Color(0XFFCF0C2A),
                                            width: 3,
                                          ),
                                        ],
                                      );
                                    }).toList(),
                                  ),
                                )),
                          ),
                        ],
                      ),
                    );
                  })))
        ],
      ),
    );
  }
}
