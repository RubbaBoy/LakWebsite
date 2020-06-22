import 'dart:async';

import 'package:LakWebsite/src/components/icon/icon_component.dart';
import 'package:LakWebsite/src/components/key/key_component.dart';
import 'package:LakWebsite/src/components/keyboard/keyboard_component.dart';
import 'package:LakWebsite/src/services/key/key_enum.dart';
import 'package:angular/angular.dart';

@Component(
  selector: 'key-manager',
  styleUrls: ['key_manager_component.css'],
  templateUrl: 'key_manager_component.html',
  directives: [
    KeyboardComponent,
    coreDirectives,
  ],
  providers: [],
  exports: [
    KeySize,
  ]
)
class KeyManagerComponent implements AfterViewInit {

  @ViewChild(KeyboardComponent)
  KeyboardComponent keyboard;

  KeyComponent activeKey;

  String active = 'N/A';

  @override
  void ngAfterViewInit() {
    keyboard.onClickKey = (component, key, primary, secondary) {
      print('Clicked');
      activeKey?.active = false;
      component.active = true;

      if (key == null) {
        return;
      }

      active = '[$primary] ${key.code}/${key.linuxCode}';

      activeKey = component;
    };
  }

}
