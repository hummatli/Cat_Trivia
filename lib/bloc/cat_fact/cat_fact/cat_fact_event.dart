import 'package:equatable/equatable.dart';

abstract class CatFactEvent extends Equatable {
  const CatFactEvent();

  @override
  List<Object> get props => [];
}

class CatFactRequested extends CatFactEvent {}
