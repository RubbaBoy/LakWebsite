import 'package:LakWebsite/src/services/cache_service.dart';
import 'package:LakWebsite/src/services/key/key_enum.dart';
import 'package:LakWebsite/src/services/objects/sound.dart';

class Key {
  final KeyEnum key;
  SoundVariant soundVariant;
  bool loop;

  Key(this.key, this.soundVariant, this.loop);

  Key.fromJson(CacheService cacheService, Map<String, dynamic> json)
      : key = KeyEnum.fromJson(json['key']),
        soundVariant = cacheService.getSoundVariant(json['soundVariant']),
        loop = json['loop'];

  Map<String, dynamic> toJson() => {
    'key': key.toJson(),
    'sound': soundVariant.toJson(),
    'loop': loop,
  };
}
