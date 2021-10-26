import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_auth_google/src/bloc/register_bloc/register_bloc.dart';
import 'package:login_auth_google/src/repository/user_repository.dart';
import 'package:login_auth_google/src/ui/Register_form.dart';

class RegisterScreen extends StatelessWidget {
  final UserRepository _userRepository;

  // ignore: use_key_in_widget_constructors
  const RegisterScreen({Key? key, required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (AppBar(title: const Text('Register'))),
      body: Center(
        child: BlocProvider<RegisterBloc>(
          create: (context) => RegisterBloc(userRepository: _userRepository),
          child: const RegisterForm(),
        ),
      ),
    );
  }
}
