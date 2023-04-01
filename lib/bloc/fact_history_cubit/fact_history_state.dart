import 'package:cat_trivia/models/cat_fact.dart';
import 'package:equatable/equatable.dart';

abstract class FactHistoryState extends Equatable {
  const FactHistoryState();

  @override
  List<Object> get props => [];
}

class FactHistoryInitial extends FactHistoryState {}

class FactHistoryLoadInProgress extends FactHistoryState {}

class FactHistoryLoadSuccess extends FactHistoryState {
  final List<CatFact> factHistory;

  const FactHistoryLoadSuccess(this.factHistory);

  @override
  List<Object> get props => [factHistory];
}

class FactHistoryLoadFailure extends FactHistoryState {}
