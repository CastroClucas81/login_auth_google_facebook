import 'package:flutter/material.dart';
import 'package:login_auth_google/src/repository/user_repository.dart';
import 'package:login_auth_google/src/ui/register_screen.dart';

class CreateAccountButton extends StatelessWidget {
  final UserRepository _userRepository;

  const CreateAccountButton({Key? key, required UserRepository userRepository})
      : assert(UserRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: const Text("Create an account"),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return RegisterScreen(userRepository: _userRepository);
            },
          ),
        );
      },
    );
  }
}
