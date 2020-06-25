import 'dart:async';
import 'dart:html';

import 'package:LakWebsite/src/services/objects/sound.dart';
import 'package:LakWebsite/src/services/request_utils.dart';
import 'package:LakWebsite/src/utility/utility.dart';
import 'package:angular/core.dart';
import 'package:meta/meta.dart';

abstract class Modulator implements OnInit {
  final HtmlElement root;
  final RequestService requestService;
  final ModulationId modulationId;
  final Map<String, dynamic> defaultValue;

  Modulator(
      this.root, this.requestService, this.modulationId, this.defaultValue);

  @Input()
  bool enabled;

  bool creating = false;
  SoundVariant soundVariant;
  SoundModulation soundModulation;
  Map<String, dynamic> originalValue;

  @override
  void ngOnInit() => root.classes.addAll(['d-block', 'my-2']);

  /// Sets the modulator to modulate the given [soundVariant].
  void bindToVariant(SoundVariant soundVariant) {
    this.soundVariant = soundVariant;
    creating = false;
    soundModulation = soundVariant.modulators
        .firstWhere((element) => element.id == modulationId, orElse: () {
      creating = true;
      var modulation =
          SoundModulation(modulationId, soundVariant.id, defaultValue);
      soundVariant.modulators.add(modulation);
      return modulation;
    });

    originalValue = {...soundModulation.value};
    bind(soundModulation.value);
  }

  /// Sends a request if the data has changed.
  void save() {
    var newData = saveData(originalValue);
    if (!mapEquality.equals(newData, originalValue)) {
      (creating
              ? requestService.addModulator(soundVariant.id, modulationId)
              : Future.value())
          .then((value) => requestService.updateModulator(
              soundVariant.id, modulationId, newData));
      soundModulation.value = newData;
    }
  }

  @protected
  void bind(Map<String, dynamic> modulationData);

  /// Creates a new data map of the values. The original map is given as
  /// [modulationData].
  @protected
  Map<String, dynamic> saveData(Map<String, dynamic> originalData);
}
