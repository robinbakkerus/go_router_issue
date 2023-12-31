import 'package:flutter/material.dart';
import '/blog/controllers/blog_controller.dart';

import '../../../widgets/blog_list.dart';

class AllBlogs extends StatefulWidget {
  const AllBlogs({super.key});

  @override
  State<AllBlogs> createState() => _AllBlogsState();
}

class _AllBlogsState extends State<AllBlogs>
    with AutomaticKeepAliveClientMixin {
  final BlogController _blogController = AllBlogController()..getAllLists();

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
