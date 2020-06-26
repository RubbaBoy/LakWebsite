import 'dart:async';
import 'dart:html';

import 'package:LakWebsite/src/components/modulators/modulator.dart';
import 'package:LakWebsite/src/services/cache_service.dart';
import 'package:LakWebsite/src/services/objects/sound.dart';
import 'package:LakWebsite/src/services/request_utils.dart';
import 'package:angular/angular.dart';

@Component(
  selector: 'color-picker',
  templateUrl: 'color_component.html',
  styleUrls: ['color_component.css'],
  directives: [
    coreDirectives,
  ],
)
class ColorComponent {

  @Input()
  bool enabled = false;

  @ViewChild('colorInput')
  InputElement colorInput;

  var value = '';

  void onChange() => value = colorInput.value;
}
