import 'package:equatable/equatable.dart';

class PassResetState extends Equatable {
  const PassResetState();

  @override
  List<Object?> get props => [];
}

class PassResetInitial extends PassResetState {}

class PassResetLoading extends PassResetState {}

class PassResetSent extends PassResetState {}

class PassResetError extends PassResetState {
  final String message;
  const PassResetError(this.message);
}
