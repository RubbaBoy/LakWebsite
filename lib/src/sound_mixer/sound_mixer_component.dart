import 'dart:html';

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
  providers: [
    ClassProvider(RequestService),
  ],
)
class SoundMixerComponent implements OnInit {
  final RequestService requestService;

  SoundMixerComponent(this.requestService);

  @ViewChild('addModal', read: LakModalComponent)
  LakModalComponent addModal;

  Sound active;
  List<Sound> sounds;

  @override
  void ngOnInit() {
    print('Sound Mixer Init');

    requestService.listSounds().then((value) => sounds = value);
  }

  void showPanel(Sound sound) {
    active = sound;
    print('Showing panel for ${sound.id} | ${sound.uri}');
  }

  void addSound() {
    print('Adding sound!');

    print('addModal = $addModal');
    addModal.openPrompt(
        onConfirm: (data) {
          print('Confirming in here');
          print('data = $data');
        },
        onCancel: () {
          print('Cancelling in here');
        },
        elementCallback: {
          'nameInput': LakModalComponent.inputValue,
          'pathInput': LakModalComponent.inputValue,
        });
  }
}
