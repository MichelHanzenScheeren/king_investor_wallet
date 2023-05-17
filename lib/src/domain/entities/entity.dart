import 'package:result_dart/result_dart.dart';
import 'package:king_investor_wallet/src/domain/value_objects/id_vo.dart';

class Entity {
  final IdVO id;

  Entity({required this.id});

  bool get isValid => validate() is Success;

  Result<Entity, String> validate() => id.validate().pure(this);

  @override
  bool operator ==(covariant Entity other) {
    if (identical(this, other)) return true;
    return other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => '$runtimeType: $id';
}
