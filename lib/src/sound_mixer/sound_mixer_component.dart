import 'package:LakWebsite/src/components/icon/icon_component.dart';
import 'package:LakWebsite/src/components/modal/modal_component.dart';
import 'package:LakWebsite/src/services/objects/sound.dart';
import 'package:LakWebsite/src/services/request_utils.dart';
import 'package:angular/angular.dart';

@Component(
  selector: 'sound-mixer',
  styleUrls: ['sound_mixer_component.css'],
  templateUrl: 'sound_mixer_component.html',
  directives: [
    LakModalComponent,
    IconComponent,
    NgFor,
    NgIf,
  ],
  providers: [],
  pipes: [commonPipes],
)
class SoundMixerComponent implements OnInit {
  final RequestService requestService;

  SoundMixerComponent(this.requestService);

  @ViewChild('addSoundModal', read: LakModalComponent)
  LakModalComponent addSoundModal;

  @ViewChild('addVariantModal', read: LakModalComponent)
  LakModalComponent addVariantModal;

  Sound activeSound;
  SoundVariant activeVariant;

  List<Sound> sounds = const [];
  List<SoundVariant> _allVariants = const [];
  List<SoundVariant> displayingVariants = const [];

  @override
  void ngOnInit() {
    print('Sound Mixer Init');

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
      activeVariant = displayingVariants.first;
    }
  }

  void clickVariant(SoundVariant soundVariant) =>
      activeVariant = activeVariant == soundVariant ? null : soundVariant;

  void addSound() {
    print('Adding sound!');

    print('addModal = $addSoundModal');
    addSoundModal.openPrompt(
        onConfirm: (data) {
          print('Confirming in here');
          print('data = $data');
        },
        onCancel: () {
          print('Cancelling in here');
        },
        elementCallback: {
          '#nameInput': LakModalComponent.inputValue,
          '#pathInput': LakModalComponent.inputValue,
        });
  }

  void addVariant() {
    print('Adding sound variant');

    addVariantModal.openPrompt(
        content: {'sound': activeSound},
        onConfirm: (data) {
          print('Confirming in here');
          print('data = $data');
        },
        onCancel: () {
          print('Cancelling in here');
        },
        elementCallback: {
          '#nameInput': LakModalComponent.inputValue,
          '#pathInput': LakModalComponent.inputValue,
        });
  }
}
