import 'package:flutter/material.dart';
import 'package:flutter_navigation/config/routes/routes.dart';
import 'package:go_router/go_router.dart';
import '/blog/controllers/blog_controller.dart';
import '/blog/models/blogs.dart';

class BlogLists extends StatelessWidget {
  final BlogController blogController;

  const BlogLists({super.key, required this.blogController});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Blog>>(
      stream: blogController.stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final allBlogs = snapshot.data!;

        return ListView.separated(
          itemCount: allBlogs.length,
          separatorBuilder: (_, __) => const Divider(),
          itemBuilder: ((context, index) {
            return ListTile(
              title: Text(allBlogs[index].title),
              subtitle: Text(
                allBlogs[index].content,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: IconButton(
                onPressed: () {
                  blogController.toggleFavorite(allBlogs[index].id);
                },
                icon: Icon(allBlogs[index].isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border_outlined),
              ),
              onTap: () {
                context.push(AppRouter.detailBlogRoute(allBlogs[index].id));
              },
            );
          }),
        );
      },
    );
  }
}
