import 'dart:html';

import 'package:LakWebsite/src/components/icon/icon_component.dart';
import 'package:LakWebsite/src/components/input/color_component/color_component.dart';
import 'package:LakWebsite/src/components/modal/modal_component.dart';
import 'package:LakWebsite/src/components/modulators/modulator.dart';
import 'package:LakWebsite/src/components/modulators/pitch_component/pitch_component.dart';
import 'package:LakWebsite/src/components/modulators/volume_component/volume_component.dart';
import 'package:LakWebsite/src/services/cache_service.dart';
import 'package:LakWebsite/src/services/objects/sound.dart';
import 'package:LakWebsite/src/services/request_utils.dart';
import 'package:LakWebsite/src/utility/constants.dart';
import 'package:LakWebsite/src/utility/utility.dart';
import 'package:angular/angular.dart';

@Component(
  selector: 'sound-mixer',
  styleUrls: ['sound_mixer_component.css'],
  templateUrl: 'sound_mixer_component.html',
  directives: [
    ColorComponent,
    VolumeComponent,
    PitchComponent,
    LakModalComponent,
    IconComponent,
    NgFor,
    NgIf,
  ],
  exports: [BASE_URL],
  providers: [],
  pipes: [commonPipes],
)
class SoundMixerComponent implements OnInit {
  final ChangeDetectorRef ref;
  final CacheService cacheService;
  final RequestService requestService;

  SoundMixerComponent(this.ref, this.cacheService, this.requestService);

  @Output()
  bool get active => activeVariant != null;

  @ViewChild('addSoundModal', read: LakModalComponent)
  LakModalComponent addSoundModal;

  @ViewChild('recordSoundModal', read: LakModalComponent)
  LakModalComponent recordSoundModal;

  @ViewChild('uploadSoundModal', read: LakModalComponent)
  LakModalComponent uploadSoundModal;

  @ViewChild('addVariantModal', read: LakModalComponent)
  LakModalComponent addVariantModal;

  @ViewChild('nameInput')
  InputElement nameInput;

  @ViewChild('form')
  FormElement formElem;

  @ViewChild(ColorComponent)
  ColorComponent colorComponent;

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

      clickVariant(displayingVariants.safeFirst);
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
      bindToActive();
    }
  }

  void bindToActive() {
    colorComponent.value = activeVariant.color;

    for (var modulator in modulators) {
      modulator.bindToVariant(activeVariant);
    }
  }

  void save() {
    activeVariant
      ..description = nameInput.value
      ..color = colorComponent.value;

    requestService.updateVariant(activeVariant.id,
        color: activeVariant.alphaColor,
        description: activeVariant.description);

    for (var modulator in modulators) {
      modulator.save();
    }
  }

  void addSound() {
    addSoundModal.openPrompt(
        onConfirm: (data) {
          requestService.addSound(data['path']).then((_) => reloadSounds());
        },
        onCancel: () {
          print('Cancelling in here');
        },
        elementCallback: {
          'path': LakModalComponent.inputValue,
        });
  }

  void recordSound() {
    recordSoundModal.openPrompt(
        onConfirm: (data) {
          requestService.recordSound(data['name']).then((_) => reloadSounds());
        },
        onCancel: () {
          print('Cancelling in here');
        },
        elementCallback: {
          'name': LakModalComponent.inputValue,
        });
  }

  void uploadSound() => uploadSoundModal.openPrompt();

  void addVariant() {
    addVariantModal.openPrompt(
        content: {'sound': activeSound},
        onConfirm: (data) {
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
}
