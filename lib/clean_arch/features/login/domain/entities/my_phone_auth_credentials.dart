import 'package:equatable/equatable.dart';

class MyPhoneAuthCredentials extends Equatable {
  final Object phoneAuthCredentials;

  const MyPhoneAuthCredentials({required this.phoneAuthCredentials});

  @override
  List<Object?> get props => [phoneAuthCredentials];
}
