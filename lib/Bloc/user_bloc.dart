import 'package:app/Model/GetSuccess_Model.dart';
import 'package:app/Model/UserLogin_Success_Model.dart';
import 'package:app/Resources/Repository.dart';
import 'package:app/UI/Home.dart';
import 'package:rxdart/rxdart.dart';

class user_bloc{

  final _repository = Repository();

  // ignore: close_sinks
  final email = BehaviorSubject<String>();
  // ignore: close_sinks
  final password = BehaviorSubject<String>();
  // ignore: close_sinks
  final loginsuccess = BehaviorSubject<String>();


  final _LoginSuccessFetcher = PublishSubject<UserLogin_Success_Model>();



  Function(String) get getemail => email.sink.add;
  Function(String) get getpass => password.sink.add;
  Function(String) get getsuccess => loginsuccess.sink.add;


  Stream<UserLogin_Success_Model> get LoginSuccessData => _LoginSuccessFetcher.stream;


  userlogin() async{
    //print("data:: " + email.value + " " + password.value);


    UserLogin_Success_Model success = await _repository.userLogin(email.value, password.value);
    //_repository.createPost(_name.value, _posts.value);
    _LoginSuccessFetcher.sink.add(success);


  }

  void dispose() async{
    email.drain();
    email.value = null;
    password.drain();
    password.value = null;
    loginsuccess.drain();
    loginsuccess.value = null;


    await _LoginSuccessFetcher.drain();
    _LoginSuccessFetcher.close();


  }




}


final userbloc = user_bloc();