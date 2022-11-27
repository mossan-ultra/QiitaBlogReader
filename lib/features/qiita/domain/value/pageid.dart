import 'package:flutter/cupertino.dart';

@immutable
class PageId {
  final String value;

  PageId({required this.value}) {
    if (value.isEmpty) {
      throw Exception('PageId value is not empty');
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(other, this) || (other is PageId && other.value == value);

  @override
  int get hashCode => runtimeType.hashCode ^ value.hashCode;
}
