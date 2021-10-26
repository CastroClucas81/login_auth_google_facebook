import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_auth_google/src/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:login_auth_google/src/bloc/authentication_bloc/authentication_event.dart';
import 'package:login_auth_google/src/bloc/authentication_bloc/authentication_state.dart';
import 'package:login_auth_google/src/bloc/simple_bloc_delegate.dart';
import 'package:login_auth_google/src/repository/user_repository.dart';
import 'package:login_auth_google/src/ui/home_screen.dart';
import 'package:login_auth_google/src/ui/login_screen.dart';
import 'package:login_auth_google/src/ui/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  Bloc.observer = SimpleBlocObserver();

  final UserRepository userRepository = UserRepository();

  runApp(BlocProvider(
    create: (context) =>
        AuthenticationBloc(userRepository: userRepository)..add(AppStarted()),
    child: App(userRepository: userRepository),
  ));
}

class App extends StatelessWidget {
  final UserRepository _userRepository;

  const App({ Key? key, required UserRepository userRepository })
    : _userRepository = userRepository,
    super (key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is Unintialized) {
            return const SplashScreen();
          }
          if (state is Authenticated) {
            return HomeScreen(name: state.displayName);
          }
          if (state is Unauthenticated) {
            //aqui é onde fica o login
            return LoginScreen(userRepository: _userRepository);
          }

          return Container();
        },
      ),
    );
  }
}