import 'package:cat_trivia/models/cat_fact.dart';
import 'package:equatable/equatable.dart';

abstract class CatFactState extends Equatable {
  const CatFactState();

  @override
  List<Object> get props => [];
}

class CatFactInitial extends CatFactState {}

class CatFactLoadInProgress extends CatFactState {}

class CatFactLoadSuccess extends CatFactState {
  final CatFact catFact;
  final String catImageUrl;

  const CatFactLoadSuccess({required this.catFact, required this.catImageUrl});

  @override
  List<Object> get props => [catFact, catImageUrl];
}

class CatFactLoadFailure extends CatFactState {}
