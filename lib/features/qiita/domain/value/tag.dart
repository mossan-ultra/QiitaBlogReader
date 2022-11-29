import 'package:flutter/cupertino.dart';

@immutable
class Tag {
  final String value;

  Tag({required this.value}) {
    if (value.isEmpty) {
      throw Exception('Tag value is not empty');
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(other, this) || (other is Tag && other.value == value);

  @override
  int get hashCode => runtimeType.hashCode ^ value.hashCode;
}
