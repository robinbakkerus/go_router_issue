import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_navigation/widgets/appbar.widget.dart';
import 'package:flutter_navigation/events/app_events.dart';
import '/blog/controllers/single_blog_controller.dart';
import '/blog/models/blogs.dart';
// import 'package:flutter_navigation/events/app_events.dart';

class SingleArticleWithParams extends StatefulWidget {
  final String id;
  const SingleArticleWithParams({super.key, required this.id});

  @override
  State<SingleArticleWithParams> createState() =>
      _SingleArticleWithParamsState();
}

///------------------------- _SingleArticleWithParamsState ------------------------------------
class _SingleArticleWithParamsState extends State<SingleArticleWithParams> {
  late final SingleBlogController blogController;
  final _appbar = const MyAppBar(title: '..', color: Colors.limeAccent);

  @override
  void initState() {
    blogController = SingleBlogController()..get(widget.id);
    super.initState();
  }

  @override
  void dispose() {
    blogController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar,
      body: SafeArea(
        child: StreamBuilder<Blog?>(
            stream: blogController.stream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              final blog = snapshot.data!;
              log('blog = $blog');
              AppEvents.fireBlogEvent(blog);

              return ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Text(blog.title, style: const TextStyle(fontSize: 30)),
                  const SizedBox(height: 10),
                  Image.network(
                    blog.coverImage,
                    height: 300,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                          backgroundImage: NetworkImage(blog.authorImage)),
                      const SizedBox(width: 10),
                      Text(blog.author),
                    ],
                  ),
                  Text(blog.content),
                ],
              );
            }),
      ),
    );
  }
}
