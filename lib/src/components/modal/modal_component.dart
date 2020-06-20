import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';

@Component(
  selector: 'lak-modal',
  styleUrls: ['modal_component.css'],
  templateUrl: 'modal_component.html',
  directives: [
    NgFor,
    NgIf,
  ],
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class LakModalComponent {
  final ChangeDetectorRef changeRef;

  @Input()
  String title;

  bool block = false;

  Map<String, dynamic> content = {};
  Function(Map<String, dynamic>) onConfirm;
  Function() onCancel;
  Map<String, Function> elementCallback;

  bool _show = false;

  set show(value) {
    _show = value;
    changeRef.markForCheck();
  }

  bool get show => _show;

  LakModalComponent(this.changeRef);

  void cancel() {
    _hideStuff();
    onCancel?.call();
  }

  void confirm() {
    _hideStuff();

    onConfirm?.call(elementCallback.map((selector, callback) => MapEntry(selector, callback(querySelector(selector))))
      ..removeWhere((key, value) => value == null));
  }

  void _hideStuff() {
    show = false;
    changeRef.markForCheck();
    animationDelay(() => block = false, 150);
  }

  void _showStuff() {
    block = true;
    changeRef.markForCheck();

    animationDelay(() => show = true, 10);
  }

  void openPrompt({Map<String, dynamic> content = const {}, Map<String, Function> elementCallback, Function(Map<String, dynamic>) onConfirm, Function() onCancel}) {
    this.content = content;
    this.onConfirm = onConfirm;
    this.onCancel = onCancel;
    this.elementCallback = elementCallback;
    _showStuff();
  }

  void animationDelay(Function() function, int mills) {
    Timer(Duration(milliseconds: mills), () {
      function();
      changeRef.markForCheck();
    });
  }

  static final inputValue = (InputElement input) => input.value;

  @override
  operator [](key) => content[key];
}
