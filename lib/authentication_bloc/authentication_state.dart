import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthenticationState extends Equatable {
  AuthenticationState([List props = const []]) : super(props);
}

class Uninitialized extends AuthenticationState {
  @override
  String toString() => 'Uninitialized';
}

class Authenticated extends AuthenticationState {
  final bool displayType;
  final String displayName;
  final String displayUserID;
  final String displayUserEmail;
  Authenticated(this.displayType, this.displayName, this.displayUserEmail,
      this.displayUserID)
      : super([displayType, displayName, displayUserEmail, displayUserID]);

  @override
  String toString() =>
      'Authenticated { displayType: $displayType, displayName: $displayName, displayUserEmail: $displayUserEmail, displayUserID: $displayUserID }';
}

class Unauthenticated extends AuthenticationState {
  @override
  String toString() => 'Unauthenticated';
}
