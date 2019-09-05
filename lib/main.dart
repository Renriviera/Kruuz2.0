import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kruuz_flutter/authentication_bloc/bloc.dart';
import 'package:kruuz_flutter/Shippr/ShipprHomePage.dart';
import 'package:kruuz_flutter/UserRepository.dart';
import 'package:kruuz_flutter/HomePage.dart';
import 'package:kruuz_flutter/login/login.dart';
import 'package:kruuz_flutter/SplashScreen.dart';
import 'package:kruuz_flutter/SimpleBlocDelegate.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final UserRepository userRepository = UserRepository();
  runApp(
    BlocProvider(
      builder: (context) => AuthenticationBloc(userRepository: userRepository)
        ..dispatch(AppStarted()),
      child: KruuzApp(userRepository: userRepository),
    ),
  );
}

class KruuzApp extends StatelessWidget {
  final UserRepository _userRepository;

  KruuzApp({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is Unauthenticated) {
            return LoginScreen(userRepository: _userRepository);
          }
          if (state is Authenticated) {
            if (state.displayType) {
              return HomePage(
                id: state.displayUserID,
                name: state.displayName,
                email: state.displayUserEmail,
                type: state.displayType,
              );
            } else
              return ShipprHomePage(
                id: state.displayUserID,
                name: state.displayName,
                email: state.displayUserEmail,
                type: state.displayType,
              );
          }
          return SplashScreen();
        },
      ),
    );
  }
}
