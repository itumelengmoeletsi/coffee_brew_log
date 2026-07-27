import '../../models/brew.dart';
import 'package:equatable/equatable.dart';

abstract class BrewState extends Equatable {
  const BrewState();

  @override
  List<Object?> get props => [];
} 

class BrewInitial extends BrewState {
  const BrewInitial();
}

class BrewLoading extends BrewState {
  const BrewLoading();
}

class BrewLoaded extends BrewState {
  final List<Brew> brews;
  const BrewLoaded(this.brews);

  @override
  List<Object?> get props => [brews];
}

class BrewError extends BrewState {
  final String message;
  const BrewError(this.message);

  @override
  List<Object?> get props => [message];
}