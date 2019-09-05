import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RegisterEvent extends Equatable {
  RegisterEvent([List props = const []]) : super(props);
}

class TypeChanged extends RegisterEvent {
  final bool type;
  TypeChanged({@required this.type}) : super([type]);

  @override
  String toString() => 'TypeChanged {type: $type }';
}

class EmailChanged extends RegisterEvent {
  final String email;

  EmailChanged({@required this.email}) : super([email]);

  @override
  String toString() => 'EmailChanged { email :$email }';
}

class PasswordChanged extends RegisterEvent {
  final String password;

  PasswordChanged({@required this.password}) : super([password]);

  @override
  String toString() => 'PasswordChanged { password: $password }';
}

class FirstNameChanged extends RegisterEvent {
  final String firstname;

  FirstNameChanged({@required this.firstname}) : super([firstname]);

  @override
  String toString() => 'FirstNameChanged { firstname: $firstname}';
}

class LastNameChanged extends RegisterEvent {
  final String lastname;

  LastNameChanged({@required this.lastname}) : super([lastname]);

  @override
  String toString() => 'LastNameChanged { lastname: $lastname}';
}

class CompanyChanged extends RegisterEvent {
  final String company;

  CompanyChanged({@required this.company}) : super([company]);
  @override
  String toString() => 'CompanyChanged { company: $company}';
}

class DotChanged extends RegisterEvent {
  final String dot;
  DotChanged({@required this.dot}) : super([dot]);
  @override
  String toString() => 'DotChanged { dot: $dot}';
}

class Submitted extends RegisterEvent {
  final bool isTrucker;
  final String email;
  final String password;
  final String firstname;
  final String lastname;
  final String company;
  final String dot;

  Submitted(
      {@required this.isTrucker,
      @required this.email,
      @required this.password,
      @required this.firstname,
      @required this.lastname,
      @required this.company,
      @required this.dot})
      : super([isTrucker, email, password, firstname, lastname, company, dot]);

  @override
  String toString() {
    return 'Submitted { isTrucker: $isTrucker, email: $email, password: $password, firstname: $firstname, lastname: $lastname, company: $company, dot: $dot }';
  }
}
