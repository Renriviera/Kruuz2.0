import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:kruuz_flutter/UserRepository.dart';
import 'package:kruuz_flutter/register/register.dart';
import 'package:kruuz_flutter/validators.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository _userRepository;

  RegisterBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  RegisterState get initialState => RegisterState.empty();

  @override
  Stream<RegisterState> transform(
    Stream<RegisterEvent> events,
    Stream<RegisterState> Function(RegisterEvent event) next,
  ) {
    final observableStream = events as Observable<RegisterEvent>;
    final nonDebounceStream = observableStream.where((event) {
      return (event is! TypeChanged &&
          event is! EmailChanged &&
          event is! PasswordChanged &&
          event is! FirstNameChanged &&
          event is! LastNameChanged &&
          event is! CompanyChanged &&
          event is! DotChanged);
    });
    final debounceStream = observableStream.where((event) {
      return (event is TypeChanged ||
          event is EmailChanged ||
          event is PasswordChanged ||
          event is FirstNameChanged ||
          event is LastNameChanged ||
          event is CompanyChanged ||
          event is DotChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(nonDebounceStream.mergeWith([debounceStream]),
        next); //transformState perhaps
  }

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is TypeChanged) {
      yield* _mapTypeChangedToState(event.type);
    } else if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is FirstNameChanged) {
      yield* _mapFirstNameChangedToState(event.firstname);
    } else if (event is LastNameChanged) {
      yield* _mapLastNameChangedToState(event.lastname);
    } else if (event is CompanyChanged) {
      yield* _mapCompanyChangedToState(event.company);
    } else if (event is DotChanged) {
      yield* _mapDOTChangedToState(event.dot);
    } else if (event is Submitted) {
      yield* _mapFormSubmittedToState(
          event.isTrucker,
          event.email,
          event.password,
          event.firstname,
          event.lastname,
          event.company,
          event.dot);
    }
  }

  Stream<RegisterState> _mapTypeChangedToState(bool type) async* {
    yield currentState.update(
      isTypeValid: Validators.isValidType(type),
    );
  }

  Stream<RegisterState> _mapEmailChangedToState(String email) async* {
    yield currentState.update(
      isEmailValid: Validators.isValidEmail(email),
    );
  }

  Stream<RegisterState> _mapPasswordChangedToState(String password) async* {
    yield currentState.update(
      isPasswordValid: Validators.isValidPassword(password),
    );
  }

  Stream<RegisterState> _mapFirstNameChangedToState(String name) async* {
    yield currentState.update(
      isFirstNameValid: Validators.isValidName(name),
    );
  }

  Stream<RegisterState> _mapLastNameChangedToState(String name) async* {
    yield currentState.update(
      isLastNameValid: Validators.isValidName(name),
    );
  }

  Stream<RegisterState> _mapCompanyChangedToState(String name) async* {
    yield currentState.update(
      isCompanyValid: true,
    );
  }

  Stream<RegisterState> _mapDOTChangedToState(String name) async* {
    yield currentState.update(
      isDOTValid: true,
    );
  }

  Stream<RegisterState> _mapFormSubmittedToState(
    bool type,
    String email,
    String password,
    String firstname,
    String lastname,
    String company,
    String dot,
  ) async* {
    yield RegisterState.loading();
    try {
      await _userRepository.signUp(
        isTrucker: type,
        email: email,
        password: password,
        firstname: firstname,
        lastname: lastname,
        company: company,
        dot: dot,
      ); //.then create firebase copy of acc
      yield RegisterState.success();
    } catch (_) {
      yield RegisterState.failure();
    }
  }
}
