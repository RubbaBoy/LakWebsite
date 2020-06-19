import 'dart:async';

import 'package:LakWebsite/src/icon/icon_component.dart';
import 'package:LakWebsite/src/services/objects/sound.dart';
import 'package:LakWebsite/src/services/request_utils.dart';
import 'package:angular/angular.dart';

@Component(
  selector: 'sound-mixer',
  styleUrls: ['sound_mixer_component.css'],
  templateUrl: 'sound_mixer_component.html',
  directives: [
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

  List<Sound> sounds;

  @override
  void ngOnInit() {
    print('Sound Mixer Init');

    requestService.listSounds().then((value) => sounds = value);
  }

}
