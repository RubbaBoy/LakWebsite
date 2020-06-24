import 'dart:async';
import 'dart:html';

import 'package:LakWebsite/src/components/icon/icon_component.dart';
import 'package:LakWebsite/src/components/key/key_component.dart';
import 'package:LakWebsite/src/components/keyboard/keyboard_component.dart';
import 'package:LakWebsite/src/services/key/key_enum.dart';
import 'package:LakWebsite/src/services/keyboard_service.dart';
import 'package:angular/angular.dart';

@Component(
  selector: 'key-manager',
  styleUrls: ['key_manager_component.css'],
  templateUrl: 'key_manager_component.html',
  directives: [
    KeyboardComponent,
    IconComponent,
    coreDirectives,
  ],
  providers: [],
  exports: [
    KeySize,
  ]
)
class KeyManagerComponent implements AfterViewInit {

  final KeyboardService keyboardService;

  final streamSubscriptions = <StreamSubscription>[];
  bool ctrlDown = false;

  KeyManagerComponent(this.keyboardService);

  @ViewChild(KeyboardComponent)
  KeyboardComponent keyboard;

  @override
  void ngAfterViewInit() {
    keyboard.onClickKey = (component, key, primary, secondary) => keyboardService.clickKey(KeyData(component, key, primary, secondary), ctrlDown);

    streamSubscriptions.addAll([
      document.onKeyDown.listen((event) => ctrlDown = event.ctrlKey),
      document.onKeyUp.listen((event) => ctrlDown = event.ctrlKey),
      document.onKeyDown.listen((event) {
        if (event.key == 'Escape') {
          keyboardService.clearActive();
        }
      }),
    ]);
  }

}
