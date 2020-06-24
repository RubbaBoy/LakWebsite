import 'dart:async';
import 'dart:html';

import 'package:LakWebsite/src/components/icon/icon_component.dart';
import 'package:LakWebsite/src/components/key/key_component.dart';
import 'package:LakWebsite/src/services/cache_service.dart';
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
    providers: [
    ],
    exports: [
      KeySize,
      KeyEnum,
    ]
)
class KeyboardComponent implements AfterViewInit {

  final CacheService cacheService;

  @ViewChildren(KeyComponent)
  List<KeyComponent> keys;

  Function(KeyComponent, KeyEnum, String, String) onClickKey;

  KeyboardComponent(this.cacheService);

  @override
  void ngAfterViewInit() {
    print('Found ${keys.length} keys');
    void clickHandler(component, key, primary, secondary) =>
        onClickKey?.call(component, key, primary, secondary);
    for (var key in keys) {
      key.onClick = clickHandler;
    }
  }
}
