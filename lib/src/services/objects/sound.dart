import 'package:uuid/uuid.dart';

final uuidMaker = Uuid();

class ModulationId {
  static final volume = ModulationId(0);
  static final pitch = ModulationId(1);

  static final values = <ModulationId>[volume, pitch];

  final int id;

  const ModulationId(this.id);

  factory ModulationId.fromId(int id) => values
      .firstWhere((modulationId) => modulationId.id == id, orElse: () => null);
}

class Sound {
  final String id;
  final String relPath;

  Sound(this.id, this.relPath);

  Sound.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        relPath = json['relativePath'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'relativePath': relPath,
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

  SoundModulation.fromJson(Map<String, dynamic> json)
      : id = ModulationId.fromId(json['id']),
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

  static SoundVariant NULL = SoundVariant('null', null, 'Null', null, null);
  static SoundVariant MIXED = SoundVariant('mixed', null, 'Mixed', null, null);

  /// Turns `#AABBCC` into `00AABBCC`, which is what the API requires.
  String get alphaColor => color == null ? null : '00${color.substring(1)}';

  SoundVariant(
      this.id, this.sound, this.description, this.color, this.modulators);

  SoundVariant.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        sound = Sound.fromJson(json['sound']),
        description = json['description'],
        color = '#${json['color'].substring(2)}',
        // Turn `00AABBCC` into `#AABBCC`
        modulators = List.from(json['modulators'])
            .map((j) => SoundModulation.fromJson(j))
            .toList();

  Map<String, dynamic> toJson() => {
        'id': id,
        'sound': sound.toJson(),
        'description': description,
        'color': alphaColor,
        'modulators':
            modulators.map((modulator) => modulator.toJson()).toList(),
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
