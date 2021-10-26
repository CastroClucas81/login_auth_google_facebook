import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  List<Object> get props => [];
}

// tres eventos

//app started
class AppStarted extends AuthenticationEvent {

}

//logged in
class LoggedIn extends AuthenticationEvent {

}

//logget out
class LoggedOut extends AuthenticationEvent {

}
