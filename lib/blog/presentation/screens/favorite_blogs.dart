import 'package:flutter/material.dart';
import '/blog/controllers/blog_controller.dart';
import '/blog/controllers/favorite_controller.dart';

import '../../../widgets/blog_list.dart';

class FavoriteBlogs extends StatefulWidget {
  const FavoriteBlogs({super.key});

  @override
  State<FavoriteBlogs> createState() => _FavoriteBlogsState();
}

class _FavoriteBlogsState extends State<FavoriteBlogs>
    with AutomaticKeepAliveClientMixin {
  final BlogController _blogController = FavoriteBlogController()
    ..getAllLists();

  @override
  void dispose() {
    _blogController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(body: BlogLists(blogController: _blogController));
  }

  @override
  bool get wantKeepAlive => true;
}
