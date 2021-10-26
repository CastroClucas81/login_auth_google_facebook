import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

//tres estados

//inicializando -> splashscreen
class Unintialized extends AuthenticationState {
  @override
  String toString() => 'Não foi inicializado';
}

//autenticado -> home
class Authenticated extends AuthenticationState {
  final String displayName;

  const Authenticated(this.displayName);

  @override
  List<Object> get props => [displayName];

  @override
  String toString() => 'Autenticado - displayName: $displayName';
}

//nao autenticado -> Login
class Unauthenticated extends AuthenticationState {
  @override
  String toString() => 'Não foi autenticado';
}
