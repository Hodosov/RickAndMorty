import 'package:equatable/equatable.dart';

abstract class PersonState extends Equatable {
  const PersonState();

  @override
  List<Object?> get props => [];
}

class PersonEmpty extends PersonState {
  @override
  List<Object?> get props => [];
}

class PersonLoading extends PersonState {
  final List<PersonEmpty> oldPersonList;
  final bool isFirstFetch;

  const PersonLoading(this.oldPersonList, {this.isFirstFetch = false});

  @override
  List<Object?> get props => [oldPersonList];
}

class PersonLoaded extends PersonState {
  final List<PersonEmpty> personList;

  const PersonLoaded(this.personList);

  @override
  List<Object?> get props => [personList];
}

class PersonError extends PersonState {
  final String message;

  const PersonError({required this.message});

  @override
  List<Object?> get props => [message];
}
