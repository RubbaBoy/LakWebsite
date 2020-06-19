import 'dart:async';

import 'package:LakWebsite/src/icon/icon_component.dart';
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
  providers: [],
)
class SoundMixerComponent implements OnInit {

  @override
  void ngOnInit() {
    print('Sound Mixer Init');
  }

}
