import 'package:uuid/uuid.dart';

const lengthOfGeneratedId = 20;

String generateId() =>
    const Uuid().v4().replaceAll('-', '').substring(0, lengthOfGeneratedId);
