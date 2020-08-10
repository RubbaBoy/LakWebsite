import 'dart:async';
import 'dart:html';

import 'package:LakWebsite/src/components/icon/icon_component.dart';
import 'package:LakWebsite/src/components/key/key_component.dart';
import 'package:LakWebsite/src/components/keyboard/keyboard_component.dart';
import 'package:LakWebsite/src/services/cache_service.dart';
import 'package:LakWebsite/src/services/key/key_enum.dart';
import 'package:LakWebsite/src/services/keyboard_service.dart';
import 'package:LakWebsite/src/services/objects/sound.dart';
import 'package:LakWebsite/src/services/request_utils.dart';
import 'package:angular/angular.dart';

@Component(
  selector: 'key-manager',
  styleUrls: ['key_manager_component.css'],
  templateUrl: 'key_manager_component.html',
  directives: [
    KeyboardComponent,
    IconComponent,
    coreDirectives,
  ],
  providers: [],
  exports: [
    KeySize,
    VariantStatus,
    SoundVariant,
  ]
)
class KeyManagerComponent implements AfterViewInit {

  final KeyboardService keyboardService;
  final CacheService cacheService;
  final RequestService requestService;

  final streamSubscriptions = <StreamSubscription>[];
  bool ctrlDown = false;

  KeyManagerComponent(this.keyboardService, this.cacheService, this.requestService);

  @ViewChild(KeyboardComponent)
  KeyboardComponent keyboard;

  @ViewChild('selectShit')
  SelectElement selector;

  VariantStatus variantStatus = VariantStatus.Unset;
  SoundVariant _currVariant;
  SoundVariant get currVariant => _currVariant;
  set currVariant(SoundVariant soundVariant) {
    _currVariant = soundVariant;
    for (var key in keyboardService.activeKeys.keys.map(cacheService.getKey)) {
      key.soundVariant = soundVariant;
      requestService.updateKey(key);
    }
  }

  List<SoundVariant> allVariants = [];
  List<SoundVariant> get displayingVariants => [
    if (variantStatus == VariantStatus.Unset) SoundVariant.NULL,
    if (variantStatus == VariantStatus.Mixed) SoundVariant.MIXED,
    ...allVariants,
  ];

  @override
  void ngAfterViewInit() {
    keyboard.onClickKey = (component, key, primary, secondary) {
      keyboardService.clickKey(KeyData(component, key, primary, secondary), ctrlDown);

      var keys = keyboardService.activeKeys;

      if (keys.isEmpty) {
        _currVariant = null;
        variantStatus = VariantStatus.Unset;
        return null;
      }

      cacheService.updateVariants().then((value) => allVariants = value);

      variantStatus = VariantStatus.Single;
      var soundVariant = cacheService.getKey(keys.keys.first).soundVariant;
      for (var keyEnum in keys.keys.skip(1)) {
        var key = cacheService.getKey(keyEnum);
        var variant = key.soundVariant;

        if (soundVariant != variant) {
          variantStatus = VariantStatus.Mixed;
          break;
        } else if (soundVariant == null) {
          variantStatus = VariantStatus.Unset;
        }
      }

      if (variantStatus == VariantStatus.Single) {
        _currVariant = soundVariant;
      } else {
        _currVariant = null;
      }
    };

    streamSubscriptions.addAll([
      document.onKeyDown.listen((event) => ctrlDown = event.ctrlKey),
      document.onKeyUp.listen((event) => ctrlDown = event.ctrlKey),
      document.onKeyDown.listen((event) {
        if (event.key == 'Escape') {
          keyboardService.clearActive();
          _currVariant = null;
          variantStatus = VariantStatus.Unset;
        }
      }),
    ]);
  }

  void onChange() => currVariant = displayingVariants[selector.selectedIndex];
}

enum VariantStatus {
  Single,
  Mixed,
  Unset
}
