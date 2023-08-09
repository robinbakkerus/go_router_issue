import 'package:event_bus/event_bus.dart';
import 'package:flutter_navigation/blog/models/blogs.dart';
import 'package:flutter_navigation/blog/models/user.dart';

/*
 * All Events are maintainded here.
 */
class BlogEvent {
  final Blog blog;

  BlogEvent(this.blog);
}

class LoginEvent {
  final User user;

  LoginEvent(this.user);
}

class LogoutEvent {}

/*
	Static class that contains all onXxx and fireXxx methods.
*/
class AppEvents {
  static final EventBus _sEventBus = EventBus();

  // Only needed if clients want all EventBus functionality.
  static EventBus ebus() => _sEventBus;

  /*
  * The methods below are just convenience shortcuts to make it easier for the client to use.
  */
  static void fireBlogEvent(Blog blog) => _sEventBus.fire(BlogEvent(blog));
  static void fireLoginEvent(User user) => _sEventBus.fire(LoginEvent(user));
  static void fireLogoutEvent() => _sEventBus.fire(LogoutEvent());

  ///----- static onXxx methods --------
  static void onBlogEvent(OnBlogEventFunc func) =>
      _sEventBus.on<BlogEvent>().listen((event) => func(event));
  static void onLoginEvent(OnLoginEventFunc func) =>
      _sEventBus.on<LoginEvent>().listen((event) => func(event));
  static void onLogoutEvent(OnLogoutEventFunc func) =>
      _sEventBus.on<LogoutEvent>().listen((event) => func(event));
}

/// ----- typedef's -----------
typedef OnBlogEventFunc = void Function(BlogEvent event);
typedef OnLoginEventFunc = void Function(LoginEvent event);
typedef OnLogoutEventFunc = void Function(LogoutEvent event);
