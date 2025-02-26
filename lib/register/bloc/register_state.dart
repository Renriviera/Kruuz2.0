import 'package:meta/meta.dart';

@immutable
class RegisterState {
  final bool isTypeValid;
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isFirstNameValid;
  final bool isLastNameValid;
  final bool isCompanyValid;
  final bool isDOTValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid =>
      isTypeValid &&
      isEmailValid &&
      isPasswordValid &&
      isFirstNameValid &&
      isLastNameValid &&
      isCompanyValid &&
      isDOTValid;

  RegisterState({
    @required this.isTypeValid,
    @required this.isEmailValid,
    @required this.isPasswordValid,
    @required this.isFirstNameValid,
    @required this.isLastNameValid,
    @required this.isCompanyValid,
    @required this.isDOTValid,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure,
  });

  factory RegisterState.empty() {
    return RegisterState(
      isTypeValid: true,
      isEmailValid: true,
      isPasswordValid: true,
      isFirstNameValid: true,
      isLastNameValid: true,
      isCompanyValid: true,
      isDOTValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory RegisterState.loading() {
    return RegisterState(
      isTypeValid: true,
      isEmailValid: true,
      isPasswordValid: true,
      isFirstNameValid: true,
      isLastNameValid: true,
      isCompanyValid: true,
      isDOTValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory RegisterState.failure() {
    return RegisterState(
      isTypeValid: true,
      isEmailValid: true,
      isPasswordValid: true,
      isFirstNameValid: true,
      isLastNameValid: true,
      isCompanyValid: true,
      isDOTValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  factory RegisterState.success() {
    return RegisterState(
      isTypeValid: true,
      isEmailValid: true,
      isPasswordValid: true,
      isFirstNameValid: true,
      isLastNameValid: true,
      isCompanyValid: true,
      isDOTValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  RegisterState update({
    bool isTypeValid,
    bool isEmailValid,
    bool isPasswordValid,
    bool isFirstNameValid,
    bool isLastNameValid,
    bool isCompanyValid,
    bool isDOTValid,
  }) {
    return copyWith(
      isTypeValid: isTypeValid,
      isEmailValid: isEmailValid,
      isPasswordValid: isPasswordValid,
      isFirstNameValid: isFirstNameValid,
      isLastNameValid: isLastNameValid,
      isCompanyValid: isCompanyValid,
      isDOTValid: isDOTValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  RegisterState copyWith({
    bool isTypeValid,
    bool isEmailValid,
    bool isPasswordValid,
    bool isFirstNameValid,
    bool isLastNameValid,
    bool isCompanyValid,
    bool isDOTValid,
    bool isSubmitEnabled,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
  }) {
    return RegisterState(
      isTypeValid: isTypeValid ?? this.isTypeValid,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isFirstNameValid: isFirstNameValid ?? this.isFirstNameValid,
      isLastNameValid: isLastNameValid ?? this.isLastNameValid,
      isCompanyValid: isCompanyValid ?? this.isCompanyValid,
      isDOTValid: isDOTValid ?? this.isDOTValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  @override
  String toString() {
    return '''RegisterState {
      isTypeValid: $isTypeValid,
      isEmailValid: $isEmailValid,
      isPasswordValid: $isPasswordValid, 
      isFirstNameValid: $isFirstNameValid,
      isLastNameValid: $isLastNameValid,
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
    }''';
  }
}
