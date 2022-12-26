import 'package:flutter/cupertino.dart';

@immutable
class CreatedAt {
  final DateTime value;

  const CreatedAt({required this.value});

  @override
  bool operator ==(Object other) =>
      identical(other, this) || (other is CreatedAt && other.value == value);

  @override
  int get hashCode => runtimeType.hashCode ^ value.hashCode;
}
