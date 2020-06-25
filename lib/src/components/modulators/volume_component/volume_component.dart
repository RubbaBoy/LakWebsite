import 'dart:async';
import 'dart:html';

import 'package:LakWebsite/src/components/modulators/modulator.dart';
import 'package:LakWebsite/src/services/cache_service.dart';
import 'package:LakWebsite/src/services/objects/sound.dart';
import 'package:LakWebsite/src/services/request_utils.dart';
import 'package:angular/angular.dart';

@Component(
  selector: 'volume-modulator',
  templateUrl: 'volume_component.html',
  styleUrls: ['volume_component.css'],
  directives: [
    coreDirectives,
  ],
)
class VolumeComponent extends Modulator {

  final CacheService cacheService;

  @Input()
  bool enabled;

  @ViewChild('volumeRange')
  InputElement volumeRange;

  VolumeComponent(RequestService requestService, this.cacheService) :
      super(requestService, ModulationId.VOLUME, {'volume': 100});

  // Changes among instances of SoundVariant
  bool creatingModulation = false;
  SoundModulation modulation;

  double value = 0;

  void onChange() => value = volumeRange.valueAsNumber.toDouble();

  @override
  void bind(Map<String, dynamic> modulationData) {
    print('binding to stuff, $modulationData');
    return value = modulationData['volume'];
  }

  @override
  Map<String, dynamic> saveData(_) =>
      {'volume': value};

  @override
  void ngOnInit() {
    print('======== volume init');
  }
}
