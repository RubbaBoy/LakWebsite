import 'dart:async';
import 'dart:html';

import 'package:LakWebsite/src/components/icon/icon_component.dart';
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
class KeyComponent {

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

  final DomSanitizationService serv;
  final HtmlElement root;

  KeyComponent(this.root, this.serv);
}

class KeySize {
  // Normal width is 35 (changeable) + 11 (shadow)
  static const Normal = KeySize(35, 35);
  static const Function = KeySize(35, 28);
  static const Normal25 = KeySize(81, 35); // USed for backspace (35 * 2.5) - 6
  static const Normal15 = KeySize(58, 35); // Used for tab (35 * 1.5) - 6
  static const Normal175 = KeySize(75, 35); // Used for caps lock (35 /2) + 58
  static const Enter = KeySize(87, 35); // Used for enter (35 /2) + 81 - 11
  static const Shift = KeySize(104, 35); // Used for shift
  static const BottomLeft = KeySize(73, 35); // Used for ctrl
  static const LargeBottom = KeySize(43, 35); // Used for ctrl
  static const Space = KeySize(243, 35); // Used for shift
  static const KeypadDouble = KeySize(79, 35); // Used for keypad enter
  static const KeypadTallDouble = KeySize(35, 82); // Used for keypad enter

  static const Spacer = KeySize(35 + 11, 35, true);
  static const HalfSpacer = KeySize(23, 35, true); // (35 + 11) / 2

  final int width;
  final int height;
  final bool spacer;

  const KeySize(this.width, this.height, [this.spacer = false]);

  @override
  String toString() {
    return 'KeySize{width: $width, height: $height, spacer: $spacer}';
  }
//      width = width + (spacer ? 11 : 0),
//      height = height + (spacer ? 11 : 0);


}
