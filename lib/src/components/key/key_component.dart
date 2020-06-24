import 'dart:async';
import 'dart:html';

import 'package:LakWebsite/src/components/icon/icon_component.dart';
import 'package:LakWebsite/src/services/cache_service.dart';
import 'package:LakWebsite/src/services/key/key_enum.dart';
import 'package:angular/angular.dart';
import 'package:angular/security.dart';

@Component(
  selector: 'key',
  styleUrls: ['key_component.css'],
  templateUrl: 'key_component.html',
  directives: [
    IconComponent,
    NgFor,
    NgIf,
  ],
  providers: [],
)
class KeyComponent extends AfterViewInit {

  static const keyColor = 'FEFDFD';

  /// The text of the key.
  @Input()
  String text;

  /// If not null, [text] will be placed further down than normal and this will
  /// be places above, for things like numbers and special characters.
  @Input()
  String secondaryKey;

  /// The icon of the key, used if [text] is null.
  @Input()
  String icon;

  /// The [KeyEnum] this component represents.
  @Input()
  KeyEnum key;

  /// The [KeyEnum] when shift is pressed this component represents.
  @Input()
  KeyEnum shiftKey;

  /// The size of the key.
  @Input()
  KeySize size = KeySize.Normal;

  /// Centers the text both horizontally and vertically, used for the enter key
  /// and keypad plus.
  @Input()
  bool center = false;

  /// The text size in pixels, by default 16px (1rem).
  @Input()
  @HostBinding('style.font-size.px')
  double textSize = 16; // 16px = 1rem

  @HostBinding('style.width.px')
  int get width => size.width;

  @HostBinding('style.height.px')
  int get height => size.height;

  @HostBinding('class.spacer')
  bool get spacer => size.spacer;

  @HostBinding('class.active')
  bool active = false;

  @HostBinding('style.color')
  String get color => keyColor;

  @HostBinding('style.background-color')
  String variantColor;

  final CacheService cacheService;
  final DomSanitizationService serv;
  final HtmlElement root;
  Function(KeyComponent component, KeyEnum key, String primary, String secondary) onClick;

  KeyComponent(this.cacheService, this.root, this.serv);

  @HostListener('click', [])
  void clickAction() => onClick?.call(this, key, text, secondaryKey);

  @override
  void ngAfterViewInit() {
    if (size.domClass != null) {
      root.classes.add(size.domClass);
    }

    var key = cacheService.getKey(this.key);
    var variant = key?.soundVariant;
    if (variant != null) {
      root.classes.add('has-variant');
      print(variant.color);
      variantColor = '#${variant.color}';
    }
  }
}

class KeySize {
  // Normal width is 35 (changeable) + 11 (shadow)
  static const Normal = KeySize(35, 35, null);
  static const Function = KeySize(35, 28, 'function');
  static const Backspace = KeySize(81, 35, 'backspace'); // USed for backspace (35 * 2.5) - 6
  static const TabSlash = KeySize(58, 35, 'tabSlash'); // Used for tab and / (35 * 1.5) - 6
  static const Caps = KeySize(75, 35, 'caps'); // Used for caps lock (35 /2) + 58
  static const Enter = KeySize(87, 35, 'enter'); // Used for enter (35 /2) + 81 - 11
  static const Shift = KeySize(104, 35, 'shift'); // Used for shift
  static const BottomLeft = KeySize(73, 35, 'bottomLeft'); // Used for ctrl
  static const LargeBottom = KeySize(43, 35, 'largeBottom'); // Used for windows key
  static const Space = KeySize(243, 35, 'space'); // Used for shift
  static const KeypadDouble = KeySize(79, 35, 'kpDouble'); // Used for keypad enter
  static const KeypadTallDouble = KeySize(35, 82, 'kpTallDouble'); // Used for keypad enter

  static const Spacer = KeySize(35 + 11, 35, null, true);
  static const HalfSpacer = KeySize(23, 35, null, true); // (35 + 11) / 2

  final int width;
  final int height;
  final String domClass;
  final bool spacer;

  const KeySize(this.width, this.height, this.domClass, [this.spacer = false]);

  @override
  String toString() {
    return 'KeySize{width: $width, height: $height, spacer: $spacer}';
  }
//      width = width + (spacer ? 11 : 0),
//      height = height + (spacer ? 11 : 0);


}
