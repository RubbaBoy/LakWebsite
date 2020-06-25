import 'dart:async';

import 'package:LakWebsite/src/components/icon/icon_component.dart';
import 'package:LakWebsite/src/components/modal/modal_component.dart';
import 'package:LakWebsite/src/components/modulators/modulator.dart';
import 'package:LakWebsite/src/components/modulators/pitch_component/pitch_component.dart';
import 'package:LakWebsite/src/components/modulators/volume_component/volume_component.dart';
import 'package:LakWebsite/src/services/cache_service.dart';
import 'package:LakWebsite/src/services/objects/sound.dart';
import 'package:LakWebsite/src/services/request_utils.dart';
import 'package:angular/angular.dart';

@Component(
  selector: 'sound-mixer',
  styleUrls: ['sound_mixer_component.css'],
  templateUrl: 'sound_mixer_component.html',
  directives: [
    VolumeComponent,
    PitchComponent,
    LakModalComponent,
    IconComponent,
    NgFor,
    NgIf,
  ],
  providers: [],
  pipes: [commonPipes],
)
class SoundMixerComponent implements OnInit, AfterChanges {
  final ChangeDetectorRef ref;
  final CacheService cacheService;
  final RequestService requestService;

  SoundMixerComponent(this.ref, this.cacheService, this.requestService);

  @Output()
  bool get active => activeVariant != null;

  @ViewChild('addSoundModal', read: LakModalComponent)
  LakModalComponent addSoundModal;

  @ViewChild('addVariantModal', read: LakModalComponent)
  LakModalComponent addVariantModal;

  @ViewChild(VolumeComponent)
  VolumeComponent volumeComponent;

  @ViewChild(PitchComponent)
  PitchComponent pitchComponent;

  List<Modulator> get modulators => [volumeComponent, pitchComponent];

  Sound activeSound;
  SoundVariant activeVariant;

  List<Sound> sounds = const [];
  List<SoundVariant> _allVariants = const [];
  List<SoundVariant> displayingVariants = const [];

  @override
  void ngOnInit() {
    reloadSounds();
  }

  void reloadSounds() {
    requestService.listSounds().then((value) => sounds = value);
    requestService.listSoundVariants().then((value) => _allVariants = value);
  }

  void clickSound(Sound sound) {
    if (activeSound == sound) {
      activeSound = null;
      activeVariant = null;
    } else {
      activeSound = sound;

      displayingVariants = _allVariants
          .where((element) => element.sound == sound)
          .toList(growable: false);

      clickVariant(displayingVariants.first);
    }
  }

  void clickVariant(SoundVariant soundVariant) {
    if (soundVariant == null) {
      return;
    }

    if (activeVariant == soundVariant) {
      activeVariant = null;
    } else {
      activeVariant = soundVariant;
      bindToVariant(soundVariant);
    }
  }

  void bindToVariant(SoundVariant variant) {
    for (var modulator in modulators) {
      modulator.bindToVariant(variant);
    }
  }

  void save() {
    print('Saving modulation data!');
    for (var modulator in modulators) {
      modulator.save();
    }
  }

  void addSound() {
    print('Adding sound!');

    print('addModal = $addSoundModal');
    addSoundModal.openPrompt(
        onConfirm: (data) {
          print('Confirming in here');
          print('data = $data');
          requestService.addSound(data['path']).then((_) => reloadSounds());
        },
        onCancel: () {
          print('Cancelling in here');
        },
        elementCallback: {
          'path': LakModalComponent.inputValue,
        });
  }

  void addVariant() {
    print('Adding sound variant');

    addVariantModal.openPrompt(
        content: {'sound': activeSound},
        onConfirm: (data) {
          print('Confirming in here');
          print('data = $data');
          requestService
              .addVariant(data['name'], activeSound.id)
              .then((_) => reloadSounds());
        },
        onCancel: () {
          print('Cancelling in here');
        },
        elementCallback: {
          'name': LakModalComponent.inputValue,
        });
  }

  @override
  void ngAfterChanges() {
    print('Changed $modulators');
  }
}
