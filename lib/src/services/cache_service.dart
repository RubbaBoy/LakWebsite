import 'dart:async';

import 'package:LakWebsite/src/services/key/key_enum.dart';
import 'package:LakWebsite/src/services/objects/keys.dart';
import 'package:LakWebsite/src/services/objects/sound.dart';
import 'package:LakWebsite/src/services/request_utils.dart';
import 'package:angular/angular.dart';

@Injectable()
class CacheService {
  final RequestService requestService;

  List<SoundVariant> _soundVariants = [];
  List<Sound> _sounds = [];
  List<Key> _keys = [];

  CacheService(this.requestService);

  Future<void> init() async {
    await updateSounds();
    await updateVariants();
    await updateKeys();
  }

  Future<void> sleep(Duration duration) async {
    final completer = Completer();
    await Timer(Duration(seconds: 5), () => completer.complete());
    return completer.future;
  }

  Future<List<SoundVariant>> updateVariants() async =>
      await requestService
          .listSoundVariants()
          .then((variants) => _soundVariants = variants);

  Future<List<Sound>> updateSounds() async =>
      await requestService.listSounds().then((sounds) => _sounds = sounds);

  Future<List<Key>> updateKeys() async =>
      await requestService.listKeys().then((keys) =>
          _keys = keys.map<Key>((key) => Key.fromJson(this, key)).toList());

  /// Gets a [Sound] from a given sound UUID [soundId].
  Sound getSound(String soundId) =>
      _sounds?.firstWhere((sound) => sound.id == soundId, orElse: () => null);

  /// Gets a [SoundVariant] from a given sound variant UUID [variantId].
  SoundVariant getSoundVariant(String variantId) => _soundVariants
      ?.firstWhere((variant) => variant.id == variantId, orElse: () => null);

  Key getKey(KeyEnum keyEnum) =>
      _keys.firstWhere((element) => element.key == keyEnum, orElse: () => null);
}
