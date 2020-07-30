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

  @ViewChild('volumeRange')
  InputElement volumeRange;

  double value = 0;

  String get displayValue => (value * 100).toStringAsFixed(1);

  VolumeComponent(HtmlElement root, RequestService requestService) :
      super(root, requestService, ModulationId.volume, {'volume': 1});

  void onChange() => value = volumeRange.valueAsNumber.toDouble();

  @override
  void bind(Map<String, dynamic> modulationData) =>
      value = modulationData['volume'];

  @override
  Map<String, dynamic> saveData(_) =>
      {'volume': value};
}
