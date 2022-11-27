import 'package:flutter/cupertino.dart';

@immutable
class UpdateAt {
  final DateTime value;

  const UpdateAt({required this.value});

  @override
  bool operator ==(Object other) =>
      identical(other, this) || (other is UpdateAt && other.value == value);

  @override
  int get hashCode => runtimeType.hashCode ^ value.hashCode;
}
