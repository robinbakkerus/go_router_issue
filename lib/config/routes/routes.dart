import 'package:flutter/material.dart';
import 'package:flutter_navigation/pages/login_page.dart';
import 'package:go_router/go_router.dart';
import '/blog/presentation/screens/single_article_with_params.dart';
import '../../pages/not_found_page.dart';
import '../../pages/home_page.dart';

class AppRouter {
  // all the route paths. So that we can access them easily  across the app

  static rootRoute() => '/';
  static homeRoute([CurrentTab? type]) => '/${type?.name ?? ':type'}';
  static loginRoute() => '/login';

  // static const singleArticleWithParams = '/article/:id';
  /// get route name with parameters, here [id] is optional because we need [:id] to define path on [_singleArticleWithParams]
  static detailBlogRoute([String? id]) => '/article/${id ?? ':id'}';

  /// -----private static methods that are accessible only in this class and not from outside

  static Widget _homePageRouteBuilder(
          BuildContext context, GoRouterState state) =>
      HomePage(
          key: state.pageKey,
          currentTab: state.pathParameters.isEmpty ||
                  state.pathParameters['type']! == CurrentTab.blogs.name
              ? CurrentTab.blogs
              : CurrentTab.favorites);

  // static Widget _singleBlog(BuildContext context, GoRouterState state) =>
  //     SingleArticle(blog: state.extra as Blog, key: state.pageKey);

  static Widget _detailBlogWithParams(
          BuildContext context, GoRouterState state) =>
      SingleArticleWithParams(
          id: state.pathParameters["id"]!, key: state.pageKey);

  static Widget _errorWidget(BuildContext context, GoRouterState state) =>
      const NotFoundPage();

  static Widget _loginPage(BuildContext context, GoRouterState state) =>
      LoginPage(key: state.pageKey);

  static final GoRouter _router = GoRouter(
    debugLogDiagnostics: true,
    routes: <RouteBase>[
      GoRoute(path: rootRoute(), builder: _homePageRouteBuilder),
      GoRoute(path: homeRoute(), builder: _homePageRouteBuilder),
      GoRoute(path: loginRoute(), builder: _loginPage),
      GoRoute(path: detailBlogRoute(), builder: _detailBlogWithParams),
    ],
    errorBuilder: _errorWidget,
  );

  static GoRouter get router => _router;
}
