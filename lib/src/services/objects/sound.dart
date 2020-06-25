
import 'package:uuid/uuid.dart';

final uuidMaker = Uuid();

class ModulationId {

  static final volume = ModulationId(0);
  static final pitch = ModulationId(1);

  static final values = <ModulationId>[volume, pitch];

  final int id;

  const ModulationId(this.id);

  factory ModulationId.fromId(int id) => values.firstWhere((modulationId) => modulationId.id == id, orElse: () => null);
}

class Sound {
  final String id;
  final Uri uri;

  Sound(this.id, this.uri);

  Sound.fromJson(Map<String, dynamic> json) :
      id = json['id'],
      uri = Uri.parse(json['uri']);

  Map<String, dynamic> toJson() => {
    'id': id,
    'uri': uri,
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Sound && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class SoundModulation {
  final ModulationId id;
  final String variant;
  Map<String, dynamic> value;

  SoundModulation(this.id, this.variant, this.value);

  SoundModulation.fromJson(Map<String, dynamic> json) :
      id = ModulationId.fromId(json['id']),
      variant = json['variant'],
      value = json['value'];

  Map<String, dynamic> toJson() => {
    'id': id.id,
    'variant': variant,
    'value': value,
  };
}

class SoundVariant {
  final String id;
  Sound sound;
  String description;
  String color;
  List<SoundModulation> modulators;

  SoundVariant(
      this.id, this.sound, this.description, this.color, this.modulators);

  SoundVariant.fromJson(Map<String, dynamic> json) :
      id = json['id'],
      sound = Sound.fromJson(json['sound']),
      description = json['description'],
      color = json['color'],
      modulators = List.from(json['modulators']).map((j) => SoundModulation.fromJson(j)).toList();

  Map<String, dynamic> toJson() => {
    'id': id,
    'sound': sound.toJson(),
    'description': description,
    'color': color,
    'modulators': modulators.map((modulator) => modulator.toJson()).toList(),
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SoundVariant &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          sound == other.sound;

  @override
  int get hashCode => id.hashCode ^ sound.hashCode;
}
