// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:flutter_navigation/blog/models/user.dart';

abstract class UserRepo {
  Future<User> loginUser(String name, String password);
  Future<User> addUser(String name, String password);
}

final class LoginFailure implements Exception {
  final String msg;
  const LoginFailure(this.msg);
}

final class AddUserFailure implements Exception {
  final String msg;
  const AddUserFailure(this.msg);
}

///----------------

class AllUsersRepo implements UserRepo {
  static final AllUsersRepo _singleton = AllUsersRepo._internal();
  factory AllUsersRepo() {
    return _singleton;
  }

  AllUsersRepo._internal();

  @override
  Future<User> addUser(String name, String password) {
    User user = User(id: _userId++, email: name, password: password);
    int index = _allUsers.indexWhere((e) => _isUser(e, name));
    if (index < 0) {
      _allUsers.add(user);
      return Future.value(user);
    } else {
      throw AddUserFailure('email $name elready exists');
    }
  }

  @override
  Future<User> loginUser(String name, String password) {
    var user = _allUsers.firstWhereOrNull((e) => _isUser(e, name));
    if (user != null) {
      if (user.password == password) {
        return Future.value(user);
      } else {
        throw const LoginFailure('password does not match');
      }
    } else {
      throw LoginFailure('username $name not found ');
    }
  }

  bool _isUser(User user, String name) {
    return user.email.toLowerCase() == name.toLowerCase();
  }

  static int _userId = 0;

  ///---- List of alle User's
  final List<User> _allUsers = [
    User(id: _userId++, email: "peter@mail.com", password: "P1234"),
    User(id: _userId++, email: "paul@mail.com", password: "P1234"),
    User(id: _userId++, email: "merry@mail.com", password: "M1234"),
    User(id: _userId++, email: "adam@mail.com", password: "A1234"),
    User(id: _userId++, email: "eva@mail.com", password: "E1234"),
  ];
}
