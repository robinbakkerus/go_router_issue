import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_navigation/events/app_events.dart';
import 'package:go_router/go_router.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final Color color;

  const MyAppBar({
    super.key,
    required this.title,
    required this.color,
  });

  @override
  Size get preferredSize => const Size.fromHeight(50.0);

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

///-----------------------------------------------------------

class _MyAppBarState extends State<MyAppBar> {
  _MyAppBarState() {
    AppEvents.onBlogEvent((event) => _onBlogEvent(event));
  }

  String _title = '...';
  Color _color = Colors.lightBlue;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: GestureDetector(
        onTap: () {
          context.pop();
        },
        child: const BackButtonIcon(),
      ),
      title: Text(_title),
      backgroundColor: _color,
    );
  }

  void _onBlogEvent(BlogEvent blogEvent) {
    if (mounted) {
      log('id = ${blogEvent.blog.id}');
      setState(() {
        _title = '${blogEvent.blog.title} by: ${blogEvent.blog.author}';
        _color = blogEvent.blog.isFavorite ? Colors.pink : Colors.lightBlue;
      });
    }
  }
}
