import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_auth_google/src/bloc/register_bloc/register_event.dart';
import 'package:login_auth_google/src/bloc/register_bloc/register_state.dart';
import 'package:login_auth_google/src/repository/user_repository.dart';
import 'package:login_auth_google/src/util/validators.dart';
import 'package:rxdart/src/streams/merge.dart';
import 'package:rxdart/src/transformers/backpressure/debounce.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository _userRepository;

  RegisterBloc({required UserRepository userRepository})
      // ignore: unnecessary_null_comparison
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(RegisterState.empty());

  @override
  Stream<Transition<RegisterEvent, RegisterState>> transformEvents(
    Stream<RegisterEvent> events,
    // ignore: deprecated_member_use
    TransitionFunction<RegisterEvent, RegisterState> transitionFn,
  ) {
    final nonDebounceStream = events.where((event) {
      return (event is! EmailChanged && event is! PasswordChanged);
    });

    final debounceStream = events.where((event) {
      return (event is EmailChanged || event is PasswordChanged);
    }).debounceTime(const Duration(milliseconds: 300));

    // ignore: deprecated_member_use
    return super.transformEvents(
      nonDebounceStream.mergeWith([debounceStream]),
      transitionFn,
    );
  }

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    //email mudou
    if (event is EmailChanged) {
      yield* _mapEmailChangeToState(event.email);
    }
    //senha mudou
    if (event is PasswordChanged) {
      yield* _mapPasswordChangeToState(event.password);
    }
    //se foi enviado
    if (event is Submitted) {
      yield* _mapFormSubmittedToState(event.email, event.password);
    }
  }

  Stream<RegisterState> _mapEmailChangeToState(String email) async* {
    yield state.update(
      isEmailValid: Validators.isValidEmail(email),
    );
  }

  Stream<RegisterState> _mapPasswordChangeToState(String password) async* {
    yield state.update(
      isEmailValid: Validators.isValidPassword(password),
    );
  }

  Stream<RegisterState> _mapFormSubmittedToState(
      String email, String password) async* {
    try {
      await _userRepository.signUp(email, password);
      yield RegisterState.success();
    } catch (_) {
      yield RegisterState.failure();
    }
  }
}
