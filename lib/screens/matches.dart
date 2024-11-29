import 'package:flutter/material.dart';
import 'package:match_detail_screen/screens/match_details.dart';

import '../../components/match_card.dart';

class Matches extends StatefulWidget {
  const Matches({
    super.key,
  });

  @override
  State<Matches> createState() => _MatchesState();
}

//added  TickerProviderStateMixin for navigating the tabs
class _MatchesState extends State<Matches> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
          actions: [
            SizedBox(
              width: 132,
              height: 34,
              child: TextField(
                style: const TextStyle(color: Colors.white),
                cursorColor: const Color(0xFF008F8F),
                decoration: InputDecoration(
                  isDense: true,
                  filled: true,
                  fillColor: Colors.transparent,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Color(0xFF828282),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      width: 1,
                      color: Color(0xFF828282),
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
                          decoration: const BoxDecoration(
                            color: Color(0XFF002929),
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/background/background.png'),
                              fit: BoxFit
                                  .cover, // Adjust this based on how you want the image to fit
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          child: const Column(
                            children: [],
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
