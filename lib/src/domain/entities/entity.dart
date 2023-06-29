import 'package:king_investor_wallet/src/domain/exceptions/validation_exception.dart';
import 'package:result_dart/result_dart.dart';
import 'package:king_investor_wallet/src/domain/value_objects/id_vo.dart';

class Entity {
  final IdVO _id;

  Entity({IdVO? id}) : _id = id ?? IdVO(null);

  String get id => _id.value;

  bool get isValid => validate() is Success;

  String? get errorMessage => validate().exceptionOrNull()?.toString();

  Result<Entity, ValidationException> validate() => _id.validate().pure(this);

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
