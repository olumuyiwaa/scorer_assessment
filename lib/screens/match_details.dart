import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../bloc/assessment_bloc.dart';
import '../bloc/assessment_event.dart';
import '../bloc/assessment_state.dart';
import '../components/custom_bottom_nav_bar.dart';
import '../components/live_match_momentum_card.dart';
import '../components/match_current_stat_card.dart';
import '../components/penalty_shootout_card.dart';

class MatchDetails extends StatefulWidget {
  final int pageIndex;
  const MatchDetails({
    super.key,
    required this.pageIndex,
  });

  @override
  State<MatchDetails> createState() => _MatchDetailsState();
}

//added  TickerProviderStateMixin for navigating the tabs
class _MatchDetailsState extends State<MatchDetails>
    with TickerProviderStateMixin {
  late TabController _tabController;

  late int _currentPageIndex;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _currentPageIndex = widget.pageIndex;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _bottomNavTapped(int index) {
    setState(() {
      _currentPageIndex = index; // Update the page index
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MatchBloc>(
          create: (context) => MatchBloc()..add(FetchMatchDetails()),
        ),
        BlocProvider<IncidentBloc>(
          create: (context) => IncidentBloc()..add(FetchIncidentsData()),
        ),
      ],
      child: Scaffold(
        bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: _currentPageIndex,
          onTap: _bottomNavTapped,
        ),
        appBar: AppBar(
          backgroundColor: const Color(0xFF002929),
          title: const Text(
            'Match Details',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
          ),
          actions: const [
            Icon(Icons.notifications_none),
            SizedBox(
              width: 16,
            )
          ],
        ),
        body: BlocBuilder<MatchBloc, MatchState>(
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

              return DefaultTabController(
                  length: 3, // Number of tabs
                  child: Scaffold(
                    body: NestedScrollView(
                      headerSliverBuilder: (context, innerBoxIsScrolled) => [
                        SliverAppBar(
                            backgroundColor: const Color(0XFF002929),
                            automaticallyImplyLeading: false,
                            expandedHeight: 352,
                            floating: false,
                            pinned: true,
                            flexibleSpace: FlexibleSpaceBar(
                              background: Container(
                                  decoration: const BoxDecoration(
                                    color: Color(0XFF002929),
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/background/match_details_background.png'),
                                      fit: BoxFit
                                          .cover, // Adjust this based on how you want the image to fit
                                    ),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 32),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12),
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
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    width: 98,
                                                    child: Column(children: [
                                                      Image.memory(
                                                        homeLogo,
                                                        height: 50,
                                                        width: 50,
                                                      ),
                                                      const SizedBox(
                                                        height: 4,
                                                      ),
                                                      Text(
                                                        textAlign:
                                                            TextAlign.center,
                                                        '${event['homeTeam']['name']}',
                                                        style: const TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ]),
                                                  ),
                                                  SizedBox(
                                                      width: 98,
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            textAlign: TextAlign
                                                                .center,
                                                            '${event['homeScore']['display']} - ${event['awayScore']['display']}',
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        32,
                                                                    color: Colors
                                                                        .white),
                                                          ),
                                                          Text(
                                                              '(${event['homeScore']['penalties']} - ${event['awayScore']['penalties']})\nPenalty',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: const TextStyle(
                                                                  fontSize: 14,
                                                                  color: Color(
                                                                      0XFF828282))),
                                                        ],
                                                      )),
                                                  Column(
                                                    children: [
                                                      Image.memory(
                                                        awayLogo,
                                                        height: 50,
                                                        width: 50,
                                                      ),
                                                      const SizedBox(
                                                        height: 4,
                                                      ),
                                                      Text(
                                                          '${event['awayTeam']['name']}',
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 16,
                                                                  color: Colors
                                                                      .white))
                                                    ],
                                                  )
                                                ]),
                                            SvgPicture.asset(
                                              'assets/icons/ball.svg',
                                              width: 24.0,
                                            ),
                                            BlocBuilder<IncidentBloc,
                                                IncidentState>(
                                              builder: (context, state) {
                                                if (state.loading) {
                                                  return const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                                }

                                                if (state
                                                    .errorMessage.isNotEmpty) {
                                                  return Center(
                                                    child: Text(
                                                        'Error: ${state.errorMessage}'),
                                                  );
                                                }

                                                return ConstrainedBox(
                                                  constraints:
                                                      const BoxConstraints(
                                                          maxHeight: 100),
                                                  child: ListView.separated(
                                                    reverse: true,
                                                    shrinkWrap: true,
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    itemCount:
                                                        state.incidents.length,
                                                    separatorBuilder:
                                                        (context, index) =>
                                                            const SizedBox(
                                                                width: 4),
                                                    itemBuilder:
                                                        (context, index) {
                                                      final incident = state
                                                          .incidents[index];
                                                      if (incident[
                                                              'incidentType'] !=
                                                          'goal') {
                                                        return const SizedBox
                                                            .shrink();
                                                      }

                                                      return Row(
                                                        mainAxisAlignment: (incident[
                                                                    'isHome'] ==
                                                                true)
                                                            ? MainAxisAlignment
                                                                .start
                                                            : MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                        4),
                                                            child: Text(
                                                              "${incident['playerName']} ${incident['time']}'",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  ),
                                                );
                                              },
                                            ),
                                          ]),
                                    ),
                                  )),
                            ),
                            bottom: PreferredSize(
                              preferredSize: const Size.fromHeight(0),
                              child: Container(
                                color: const Color(0xFF002929),
                                child: TabBar(
                                  labelStyle: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.1,
                                  ),
                                  unselectedLabelStyle:
                                      const TextStyle(letterSpacing: 0.1),
                                  labelPadding:
                                      const EdgeInsets.symmetric(horizontal: 0),
                                  labelColor: const Color(0xFFFFFFFF),
                                  unselectedLabelColor: const Color(0xFF828282),
                                  indicatorColor: const Color(0xFF008F8F),
                                  controller: _tabController,
                                  tabs: const [
                                    Tab(text: 'Overview'),
                                    Tab(text: 'Line-up'),
                                    Tab(text: 'Statistics'),
                                    Tab(text: 'Matches'),
                                  ],
                                ),
                              ),
                            ))
                      ],
                      body: TabBarView(
                        controller: _tabController,
                        children: [
                          ListView(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 20),
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              PenaltyShootoutCard(
                                homeLogo: event['homeTeam']['logo'],
                                awayLogo: event['awayTeam']['logo'],
                                scoreHome: event['homeScore']['penalties'],
                                scoreAway: event['awayScore']['penalties'],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              LiveMatchMomentumCard(
                                homeLogo: event['homeTeam']['logo'],
                                awayLogo: event['awayTeam']['logo'],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              MatchCurrentStatCard(
                                homeLogo: event['homeTeam']['logo'],
                                awayLogo: event['awayTeam']['logo'],
                              ),
                            ],
                          ),
                          const Center(child: Text('Line-up')),
                          const Center(
                            child: Text('Statistics'),
                          ),
                          const Center(
                            child: Text('Matches'),
                          ),
                        ],
                      ),
                    ),
                  ));
            }

            return const Center(child: Text('No data available.'));
          },
        ),
      ),
    );
  }
}
