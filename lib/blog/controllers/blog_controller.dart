import 'dart:async';

import '/blog/models/blogs.dart';
import '/blog/repostitories/all_blogs.dart';

abstract class BlogController {
  BlogController();

  Stream<List<Blog>>? get stream;

  void dispose();

  void getAllLists();

  void toggleFavorite(String id);
}

class AllBlogController implements BlogController {
  final BlogRepository blogRepository = AllBlogsRepo();
  final StreamController<List<Blog>> _streamController = StreamController();
  AllBlogController();

  @override
  Stream<List<Blog>> get stream => _streamController.stream;

  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void getAllLists() async {
    _streamController.add(await blogRepository.getBlogs());
  }

  @override
  void toggleFavorite(String id) async {
    await blogRepository.toggleFevorite(id);
    getAllLists();
  }
}
