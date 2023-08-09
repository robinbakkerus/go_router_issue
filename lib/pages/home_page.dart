import 'package:flutter/material.dart';
import 'package:flutter_navigation/config/routes/routes.dart';
import 'package:flutter_navigation/widgets/header.widget.dart';
import 'package:go_router/go_router.dart';
import '/blog/presentation/screens/favorite_blogs.dart';
import '/blog/presentation/screens/list_all_blogs.dart';

class HomePage extends StatelessWidget {
  final CurrentTab currentTab;
  const HomePage({
    super.key,
    required this.currentTab,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        initialIndex: currentTab.index,
        child: SafeArea(
            child: Column(
          children: [
            const AppHeader(),
            TabBar(
                onTap: (index) {
                  GoRouter.of(context)
                      .go(AppRouter.homeRoute(CurrentTab.values[index]));
                },
                tabs: const [Tab(text: "All"), Tab(text: "Favorite")]),
            const Expanded(
              child: TabBarView(
                children: [
                  AllBlogs(),
                  FavoriteBlogs(),
                ],
              ),
            )
          ],
        )),
      ),
    );
  }
}

enum CurrentTab { blogs, favorites }
