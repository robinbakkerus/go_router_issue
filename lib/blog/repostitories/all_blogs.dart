import 'dart:math';

import '/blog/models/blogs.dart';
import 'package:word_generator/word_generator.dart';

abstract class BlogRepository {
  Future<List<Blog>> getBlogs();
  Future<void> toggleFevorite(String id);
  Future<Blog?> getSingleArticle(String id);

  Future<List<Blog>> getFavoriteBlogs();
}

class AllBlogsRepo implements BlogRepository {
  static final AllBlogsRepo _singleton = AllBlogsRepo._internal();
  factory AllBlogsRepo() {
    return _singleton;
  }
  AllBlogsRepo._internal();

  @override
  Future<List<Blog>> getBlogs() {
    return Future.value(allBlogs);
  }

  @override
  Future<void> toggleFevorite(String id) {
    final index = allBlogs.indexWhere((element) => id == element.id);
    if (index != -1) {
      allBlogs[index] =
          allBlogs[index].copyWith(isFavorite: !allBlogs[index].isFavorite);
    }
    return Future.value();
  }

  @override
  Future<List<Blog>> getFavoriteBlogs() {
    return Future.value(
        allBlogs.where((element) => element.isFavorite).toList());
  }

  @override
  Future<Blog?> getSingleArticle(String id) {
    // final blogs = allBlogs.where((element) => element.isFavorite).toList();
    final blogs = allBlogs.where((element) => element.id == id).toList();
    return Future.value(blogs.isEmpty ? null : blogs.first);
  }

  /// List with all the blogs
  ///
  final List<Blog> allBlogs =
      List.generate(10, (index) => _generateBlog(index));

  static Blog _generateBlog(int index) {
    bool isFav = index % 3 == 0;
    String authImage = index.isEven
        ? "https://loremflickr.com/320/240/boy?random=$index"
        : "https://loremflickr.com/320/240/girl$index";
    return Blog(
        id: index.toString(),
        title: _generateTitle(),
        content: _generateContent(),
        author: WordGenerator().randomName(),
        createdAt: DateTime.now(),
        authorImage: authImage,
        coverImage: "https://loremflickr.com/320/240/?random$index",
        isFavorite: isFav);
  }

  static String _generateTitle() {
    int min = 2;
    int max = min + Random().nextInt(3);
    return WordGenerator().randomNouns(max).join(' ');
  }

  static String _generateContent() {
    int min = 25;
    int max = min + Random().nextInt(100);
    return WordGenerator().randomSentence(max);
  }
}
