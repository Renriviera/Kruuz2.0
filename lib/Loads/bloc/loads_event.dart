import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class LoadsEvent extends Equatable {
  LoadsEvent([List props = const []]) : super(props);
}

class LoadLoads extends LoadsEvent {
  // final List<Load> loads;
  //LoadsLoaded([this.loads == const[]) : super([loads]);

}

class addLoads extends LoadsEvent {}
