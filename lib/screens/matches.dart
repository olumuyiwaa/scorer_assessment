import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:match_detail_screen/screens/match_details.dart';

import '../../components/match_card.dart';

class Matches extends StatefulWidget {
  const Matches({
    super.key,
  });

  @override
  State<Matches> createState() => _MatchesState();
}

class _MatchesState extends State<Matches> with TickerProviderStateMixin {
  late TabController _tabController;
  final List<Map<String, String>> leagues = [
    {'name': 'All', 'icon': 'assets/icons/0.svg'},
    {'name': 'EPL', 'icon': 'assets/icons/1.png'},
    {'name': 'La Liga', 'icon': 'assets/icons/2.png'},
    {'name': 'Serie A', 'icon': 'assets/icons/3.png'},
    {'name': 'Bundesliga', 'icon': 'assets/icons/4.png'},
    {'name': 'Ligue 1', 'icon': 'assets/icons/5.png'},
  ];
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF002929),
          leading: const Icon(
            Icons.menu,
          ),
          title: Image.asset('assets/icons/scorers.png', height: 38),
          actions: [
            SizedBox(
              width: 132,
              height: 34,
              child: TextField(
                style: const TextStyle(color: Colors.white),
                cursorColor: const Color(0xFFFFFFFF),
                decoration: InputDecoration(
                  isDense: true,
                  filled: true,
                  fillColor: Colors.transparent,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      width: 1,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                  prefixIcon: const Icon(
                    Icons.search_rounded,
                    size: 20,
                  ),
                  hintText: 'Search...',
                ),
              ),
            ),
            const SizedBox(
              width: 16,
            )
          ],
        ),
        body: DefaultTabController(
            length: 3, // Number of tabs
            child: Scaffold(
              body: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverAppBar(
                      backgroundColor: const Color(0XFF002929),
                      automaticallyImplyLeading: false,
                      expandedHeight: 259,
                      floating: false,
                      pinned: true,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Container(
                          alignment: Alignment.bottomCenter,
                          decoration: const BoxDecoration(
                            color: Color(0XFF002929),
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/background/background.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 72),
                          child: Column(
                            children: [
                              const Spacer(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: leagues.map((league) {
                                  return Column(
                                    children: [
                                      Container(
                                        width: 52,
                                        height: 52,
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            color: Color(0XFF1D1D1D)),
                                        child: league['icon']!.endsWith('.svg')
                                            ? SvgPicture.asset(league['icon']!,
                                                width: 32.0, height: 32.0)
                                            : Image.asset(league['icon']!,
                                                width: 32.0, height: 32.0),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(league['name']!,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.white))
                                    ],
                                  );
                                }).toList(),
                              )
                            ],
                          ),
                        ),
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
                              Tab(text: 'Live Matches'),
                              Tab(text: 'New Matches'),
                              Tab(text: 'Past Matches'),
                            ],
                          ),
                        ),
                      ))
                ],
                body: TabBarView(
                  controller: _tabController,
                  children: [
                    const Center(
                      child: Text('Live Matches'),
                    ),
                    const Center(child: Text('New Matches')),
                    ListView(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 20),
                      children: [
                        GestureDetector(
                          child: const MatchCard(),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const MatchDetails(
                                          pageIndex: 1,
                                        )));
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )));
  }
}
