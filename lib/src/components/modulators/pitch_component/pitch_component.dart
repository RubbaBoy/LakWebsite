import 'dart:async';
import 'dart:html';

import 'package:LakWebsite/src/components/modulators/modulator.dart';
import 'package:LakWebsite/src/services/cache_service.dart';
import 'package:LakWebsite/src/services/objects/sound.dart';
import 'package:LakWebsite/src/services/request_utils.dart';
import 'package:angular/angular.dart';

@Component(
  selector: 'pitch-modulator',
  templateUrl: 'pitch_component.html',
  styleUrls: ['pitch_component.css'],
  directives: [
    coreDirectives,
  ],
)
class PitchComponent extends Modulator {

  @ViewChild('pitchRange')
  InputElement pitchRange;

  double value = 0;

  PitchComponent(HtmlElement root, RequestService requestService) :
      super(root, requestService, ModulationId.pitch, {'pitch': 1});

  void onChange() => value = pitchRange.valueAsNumber.toDouble();

  @override
  void bind(Map<String, dynamic> modulationData) =>
      value = modulationData['pitch'];

  @override
  Map<String, dynamic> saveData(_) =>
      {'pitch': value};
}
