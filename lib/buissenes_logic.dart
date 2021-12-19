import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Logic extends ChangeNotifier {

  String? userName;
  User? _currentUser;
  Stream<User>? _currentUserStream;
  String? _lowLevelState;


  Logic() {
    _currentUserStream = User.asyncGet('moshes')!;
    _currentUserStream?.listen((newUser) {
      _currentUser = newUser;
      notifyListeners();
    });
  }

  setLowLevelState(){
    _lowLevelState = Random().nextInt(7).toString();
    notifyListeners();
  }

  get currentUser => _currentUser;
  get lowLevelState => _lowLevelState;
}

class User {
  String? name;
  User({required this.name});

  static Stream<User>? asyncGet(String uid) async* {
    var params = await Future.delayed(const Duration(milliseconds: 2000))
        .then((value) => {"name": uid});
    yield User(name: params["name"]);
  }
}
