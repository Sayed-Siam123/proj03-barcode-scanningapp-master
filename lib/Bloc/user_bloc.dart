import 'package:rxdart/rxdart.dart';

class user_bloc{

  // ignore: close_sinks
  final email = BehaviorSubject<String>();
  // ignore: close_sinks
  final password = BehaviorSubject<String>();
  // ignore: close_sinks
  final loginsuccess = BehaviorSubject<String>();



  Function(String) get getemail => email.sink.add;
  Function(String) get getpass => password.sink.add;
  Function(String) get getsuccess => loginsuccess.sink.add;



}