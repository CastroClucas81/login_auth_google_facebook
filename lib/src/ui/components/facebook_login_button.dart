import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_auth_google/src/bloc/login_bloc/login_bloc.dart';
import 'package:login_auth_google/src/bloc/login_bloc/login_event.dart';

class FacebookLoginButton extends StatefulWidget {
  const FacebookLoginButton({Key? key}) : super(key: key);

  @override
  State<FacebookLoginButton> createState() => _FacebookLoginButtonState();
}

class _FacebookLoginButtonState extends State<FacebookLoginButton> {
  Map? _userData;

  @override
  Widget build(BuildContext context) {
    return FacebookAuthButton(
      onPressed: () {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Loggin in...'),
                  CircularProgressIndicator()
                ],
              ),
            ),
          );
        BlocProvider.of<LoginBloc>(context).add(
          LoginWithFacebookPressed(),
        );
      },
    );
  }
}
