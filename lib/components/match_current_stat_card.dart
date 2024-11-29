import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../bloc/assessment_bloc.dart';
import '../bloc/assessment_event.dart';
import '../bloc/assessment_state.dart';

class MatchCurrentStatCard extends StatelessWidget {
  final String homeLogo;
  final String awayLogo;

  const MatchCurrentStatCard(
      {super.key, required this.homeLogo, required this.awayLogo});

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
            color: const Color(0XFFB5B5B5).withOpacity(0.342),
            blurRadius: 20,
            offset: const Offset(2, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            color: const Color(0XFF008F8F),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.memory(homeIcon, height: 24, width: 24),
                const Text(
                  'Match Current Stat',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                ),
                Image.memory(awayIcon, height: 24, width: 24),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.02),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 4),
                  child: SvgPicture.asset(
                    'assets/icons/time.svg',
                    height: 26,
                  ),
                ),
                BlocProvider(
                    create: (_) => IncidentBloc()..add(FetchIncidentsData()),
                    child: BlocBuilder<IncidentBloc, IncidentState>(
                        builder: (context, state) {
                      if (state.loading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (state.errorMessage.isNotEmpty) {
                        return Center(
                            child: Text('Error: ${state.errorMessage}'));
                      }

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.incidents.length,
                        itemBuilder: (context, index) {
                          final incident = state.incidents[index];

                          return (incident['incidentType'] == 'injuryTime')
                              ? const SizedBox.shrink()
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 20),
                                      child: (incident['text'] != null)
                                          ? Container(
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.02,
                                                  vertical: 4),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color:
                                                      const Color(0xFFE0E0E0)),
                                              child: Text(
                                                '${incident['text']} ( ${incident['homeScore']} - ${incident['awayScore']})',
                                                style: const TextStyle(
                                                    fontSize: 11),
                                              ))
                                          : (incident['incidentType'] ==
                                                  'penaltyShootout')
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 20),
                                                  child:
                                                      (incident['isHome'] !=
                                                              true)
                                                          ? Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                SizedBox(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.34,
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          8),
                                                                  child:
                                                                      Container(
                                                                    padding: const EdgeInsets
                                                                        .symmetric(
                                                                        horizontal:
                                                                            6,
                                                                        vertical:
                                                                            4),
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      color: const Color(
                                                                          0xFF008F8F),
                                                                    ),
                                                                    child: Text(
                                                                      '${incident['sequence']}',
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            11,
                                                                        fontWeight:
                                                                            FontWeight.w700,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Image.asset(
                                                                  'assets/icons/${incident['incidentClass']}.png',
                                                                  width: 20,
                                                                  height: 20,
                                                                ),
                                                                SizedBox(
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.352,
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .end,
                                                                      children: [
                                                                        const SizedBox(
                                                                            width:
                                                                                8),
                                                                        Text(
                                                                          incident[
                                                                              'playerName'],
                                                                          style:
                                                                              const TextStyle(letterSpacing: -0.5),
                                                                        ),
                                                                        const SizedBox(
                                                                            width:
                                                                                4),
                                                                        Container(
                                                                          height:
                                                                              30,
                                                                          width:
                                                                              30,
                                                                          decoration:
                                                                              const BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color:
                                                                                Color(0xFF828282),
                                                                          ),
                                                                          child:
                                                                              const Center(
                                                                            child:
                                                                                Text(
                                                                              'A', // Placeholder for away player
                                                                              style: TextStyle(color: Colors.white),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    )),
                                                              ],
                                                            )
                                                          : Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                SizedBox(
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.342,
                                                                    child: Row(
                                                                      children: [
                                                                        Container(
                                                                          height:
                                                                              30,
                                                                          width:
                                                                              30,
                                                                          decoration:
                                                                              const BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color:
                                                                                Color(0xFF828282),
                                                                          ),
                                                                          child:
                                                                              const Center(
                                                                            child:
                                                                                Text(
                                                                              'H', // Placeholder for away player
                                                                              style: TextStyle(color: Colors.white),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                          width:
                                                                              8,
                                                                        ),
                                                                        Text(
                                                                          incident[
                                                                              'playerName'],
                                                                          style:
                                                                              const TextStyle(letterSpacing: -0.5),
                                                                        ),
                                                                      ],
                                                                    )),
                                                                const SizedBox(
                                                                    width: 8),
                                                                Image.asset(
                                                                  'assets/icons/${incident['incidentClass']}.png',
                                                                  width: 20,
                                                                  height: 20,
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          8),
                                                                  child:
                                                                      Container(
                                                                    padding: const EdgeInsets
                                                                        .symmetric(
                                                                        horizontal:
                                                                            6,
                                                                        vertical:
                                                                            4),
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      color: const Color(
                                                                          0xFF008F8F),
                                                                    ),
                                                                    child: Text(
                                                                      '${incident['sequence']}',
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            11,
                                                                        fontWeight:
                                                                            FontWeight.w700,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.342,
                                                                ),
                                                              ],
                                                            ))
                                              : (incident['isHome'] == true)
                                                  ? Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.342,
                                                            child: Row(
                                                              children: [
                                                                Container(
                                                                  height: 30,
                                                                  width: 30,
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color: Color(
                                                                        0xFF828282),
                                                                  ),
                                                                  child:
                                                                      const Center(
                                                                    child: Text(
                                                                      'H', // Placeholder for away player
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.white),
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  width: 8,
                                                                ),
                                                                (incident['incidentType'] ==
                                                                        'substitution')
                                                                    ? Column(
                                                                        children: [
                                                                          Text(
                                                                            incident['playerIn'],
                                                                            style:
                                                                                const TextStyle(letterSpacing: -0.5, color: Colors.green),
                                                                          ),
                                                                          Text(
                                                                            incident['playerOut'],
                                                                            style:
                                                                                const TextStyle(letterSpacing: -0.5, color: Colors.red),
                                                                          ),
                                                                        ],
                                                                      )
                                                                    : Text(
                                                                        incident[
                                                                            'playerName'],
                                                                        style: const TextStyle(
                                                                            letterSpacing:
                                                                                -0.5),
                                                                      ),
                                                              ],
                                                            )),
                                                        const SizedBox(
                                                            width: 8),
                                                        Image.asset(
                                                          'assets/icons/${(incident['incidentType'] == 'substitution') ? 'substitution' : (incident['incidentType'] != 'goal') ? incident["incidentClass"] : incident["incidentType"]}.png', // Adjust this icon as needed
                                                          width: 20,
                                                          height: 20,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      8),
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        6,
                                                                    vertical:
                                                                        4),
                                                            alignment: Alignment
                                                                .center,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              color: const Color(
                                                                  0xFF008F8F),
                                                            ),
                                                            child: Text(
                                                              '${incident['time']}',
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 11,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.342,
                                                        ),
                                                      ],
                                                    )
                                                  : Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.342,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      8),
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        6,
                                                                    vertical:
                                                                        4),
                                                            alignment: Alignment
                                                                .center,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              color: const Color(
                                                                  0xFF008F8F),
                                                            ),
                                                            child: Text(
                                                              '${incident['time']}',
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 11,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Image.asset(
                                                          'assets/icons/${(incident['incidentType'] == 'substitution') ? 'substitution' : (incident['incidentType'] != 'goal') ? incident["incidentClass"] : incident["incidentType"]}.png',
                                                          width: 20,
                                                          height: 20,
                                                        ),
                                                        SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.342,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                const SizedBox(
                                                                    width: 8),
                                                                (incident['incidentType'] ==
                                                                        'substitution')
                                                                    ? Column(
                                                                        children: [
                                                                          Text(
                                                                            incident['playerIn'],
                                                                            style:
                                                                                const TextStyle(letterSpacing: -0.5, color: Colors.green),
                                                                          ),
                                                                          Text(
                                                                            incident['playerOut'],
                                                                            style:
                                                                                const TextStyle(letterSpacing: -0.5, color: Colors.red),
                                                                          ),
                                                                        ],
                                                                      )
                                                                    : Text(
                                                                        incident[
                                                                            'playerName'],
                                                                        style: const TextStyle(
                                                                            letterSpacing:
                                                                                -0.5),
                                                                      ),
                                                                const SizedBox(
                                                                    width: 4),
                                                                Container(
                                                                  height: 30,
                                                                  width: 30,
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color: Color(
                                                                        0xFF828282),
                                                                  ),
                                                                  child:
                                                                      const Center(
                                                                    child: Text(
                                                                      'A', // Placeholder for away player
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.white),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            )),
                                                      ],
                                                    ),
                                    ),
                                  ],
                                );
                        },
                      );
                    })),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
