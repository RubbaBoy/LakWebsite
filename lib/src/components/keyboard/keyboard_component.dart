import 'dart:async';

import 'package:LakWebsite/src/components/icon/icon_component.dart';
import 'package:LakWebsite/src/components/key/key_component.dart';
import 'package:LakWebsite/src/services/key/key_enum.dart';
import 'package:angular/angular.dart';

@Component(
  selector: 'keyboard',
  styleUrls: ['keyboard_component.css'],
  templateUrl: 'keyboard_component.html',
    directives: [
      IconComponent,
      KeyComponent,
      coreDirectives,
    ],
    providers: [],
    exports: [
      KeySize,
      Key,
    ]
)
class KeyboardComponent implements AfterViewInit {

  @ViewChildren(KeyComponent)
  List<KeyComponent> keys;

  Function(KeyComponent, Key, String, String) onClickKey;

  @override
  void ngAfterViewInit() {
    print('Found ${keys.length} keys');
    void clickHandler(component, key, primary, secondary) => onClickKey?.call(component, key, primary, secondary);
    for (var key in keys) {
      key.onClick = clickHandler;
    }
  }
}
