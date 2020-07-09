import 'package:collection/collection.dart';
import 'package:uuid/uuid.dart';

final uuid = Uuid();
final mapEquality = const MapEquality();

double mapRange(double value, double valueMin, double valueMax, double targetMin, double targetMax) =>
    (value - valueMin) / (valueMax - valueMin) * (targetMax - targetMin) + targetMin;
