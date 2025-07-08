import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

class ServerFailure extends Failure {
  ServerFailure({required this.exception});
  final Object exception;
}

class UnknownFailure extends Failure {}
