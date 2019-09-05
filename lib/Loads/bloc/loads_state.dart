import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class LoadsState extends Equatable {
  LoadsState([List props = const []]) : super(props);
}

class FetchingLoads extends LoadsState {
  @override
  String toString() => 'Fetching Loads';
}

class FetchedLoads extends LoadsState {
  @override
  String toString() => 'Fetched Loads';
}

class SelectingLoad extends LoadsState {
  @override
  String toString() => 'Selecting Loads';
}

class SelectedLoad extends LoadsState {
  @override
  String toString() => 'Selected Loads';
}
