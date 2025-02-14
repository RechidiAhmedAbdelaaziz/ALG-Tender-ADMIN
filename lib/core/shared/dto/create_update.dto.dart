import 'package:equatable/equatable.dart';

abstract class CreateUpdateDto extends Equatable {
  Future<Map<String, dynamic>> toMap();

  void dispose();

  @override
  List<Object?> get props => [];
}
