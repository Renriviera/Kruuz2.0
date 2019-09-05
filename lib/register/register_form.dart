import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kruuz_flutter/authentication_bloc/bloc.dart';
import 'package:kruuz_flutter/register/register.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class RegisterForm extends StatefulWidget {
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm>
    with TickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _dotController = TextEditingController();

  RegisterBloc _registerBloc;

  bool get isPopulated =>
      _emailController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty &&
      _firstNameController.text.isNotEmpty &&
      _lastNameController.text.isNotEmpty &&
      _companyController.text.isNotEmpty;

  bool isRegisterButtonEnabled(RegisterState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  AnimationController controller1;
  AnimationController controller2;
  Animation<double> animation1;
  Animation<double> animation2;
  bool isTrucker = true;

  @override
  void initState() {
    super.initState();
    controller1 = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    controller2 = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation1 = CurvedAnimation(parent: controller1, curve: Curves.easeIn);
    animation2 = CurvedAnimation(parent: controller2, curve: Curves.easeOut);
    controller1.forward();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
    _firstNameController.addListener(_onFirstNameChanged);
    _lastNameController.addListener(_onLastNameChanged);
    _companyController.addListener(_onCompanyChanged);
    _dotController.addListener(_onDotChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Registering...'),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).dispatch(LoggedIn());
          Navigator.of(context).pop();
        }
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Registration Failure'),
                    Icon(Icons.error),
                  ],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(20),
            child: Form(
              child: ListView(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Switch(
                        value: isTrucker,
                        onChanged: (value) {
                          setState(
                            () {
                              if (value == true) {
                                controller1.forward();
                                controller2.reverse();
                              } else {
                                controller1.reverse();
                                controller2.forward();
                              }
                              isTrucker = value;
                            },
                          );
                        },
                        activeColor: Colors.white,
                        activeTrackColor: Colors.lightBlueAccent,
                      ),
                      FadeTransition(
                        opacity: animation2,
                        child: Text(
                          'Shipper',
                          style: TextStyle(
                              color: Color.fromRGBO(242, 152, 54, 1),
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      FadeTransition(
                        opacity: animation2,
                        child: Icon(
                          MdiIcons.mailboxOpenUp,
                          size: 50.0,
                          color: Color.fromRGBO(242, 152, 54, 1),
                        ),
                      ),
                      FadeTransition(
                        opacity: animation1,
                        child: Text(
                          'Trucker',
                          style: TextStyle(
                              color: Colors.lightBlueAccent,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      FadeTransition(
                        opacity: animation1,
                        child: Icon(
                          MdiIcons.truckDelivery,
                          size: 50.0,
                          color: Colors.lightBlueAccent,
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.email),
                      labelText: 'Email',
                    ),
                    autocorrect: false,
                    autovalidate: true,
                    validator: (_) {
                      return !state.isEmailValid ? 'Invalid Email' : null;
                    },
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.lock),
                      labelText: 'Password',
                    ),
                    obscureText: true,
                    autocorrect: false,
                    autovalidate: true,
                    validator: (_) {
                      return !state.isPasswordValid ? 'Invalid Password' : null;
                    },
                  ),
                  TextFormField(
                    controller: _firstNameController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.account_box),
                      labelText: 'First Name',
                    ),
                    autocorrect: false,
                    autovalidate:
                        true, // will be updated later to include names
                    validator: (_) {
                      return !state.isFirstNameValid
                          ? 'Invalid First Name'
                          : null;
                    },
                  ),
                  TextFormField(
                    controller: _lastNameController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.blur_on),
                      labelText: 'Last Name',
                    ),
                    autocorrect: false,
                    autovalidate:
                        true, // will be updated later to include names
                    validator: (_) {
                      return !state.isLastNameValid
                          ? 'Invalid Last Name'
                          : null;
                    },
                  ),
                  TextFormField(
                    controller: _companyController,
                    decoration: InputDecoration(
                      icon: Icon(MdiIcons.officeBuilding),
                      labelText: 'Company',
                    ),
                    autocorrect: false,
                    autovalidate:
                        false, // will be updated later to include real companies from database
                  ),
                  Visibility(
                    visible: isTrucker,
                    child: TextFormField(
                      controller: _dotController,
                      decoration: InputDecoration(
                        icon: Icon(MdiIcons.truck),
                        labelText: 'D.O.T #', //
                      ),
                      autocorrect: false,
                      autovalidate:
                          false, // will update later regex validator once specs are confirmed.
                    ),
                  ),
                  RegisterButton(
                    onPressed: isRegisterButtonEnabled(state)
                        ? _onFormSubmitted
                        : null,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _companyController.dispose();
    _dotController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    _registerBloc.dispatch(
      EmailChanged(email: _emailController.text),
    );
  }

  void _onPasswordChanged() {
    _registerBloc.dispatch(
      PasswordChanged(password: _passwordController.text),
    );
  }

  void _onFirstNameChanged() {
    _registerBloc.dispatch(
      FirstNameChanged(firstname: _firstNameController.text),
    );
  }

  void _onLastNameChanged() {
    _registerBloc.dispatch(
      LastNameChanged(lastname: _lastNameController.text),
    );
  }

  void _onCompanyChanged() {
    _registerBloc.dispatch(
      CompanyChanged(company: _companyController.text),
    );
  }

  void _onDotChanged() {
    _registerBloc.dispatch(
      DotChanged(dot: _dotController.text),
    );
  }

  void _onFormSubmitted() {
    _registerBloc.dispatch(
      Submitted(
        isTrucker: isTrucker,
        email: _emailController.text,
        password: _passwordController.text,
        firstname: _firstNameController.text,
        lastname: _lastNameController.text,
        company: _companyController.text,
        dot: _dotController.text,
      ),
    );
  }
}
