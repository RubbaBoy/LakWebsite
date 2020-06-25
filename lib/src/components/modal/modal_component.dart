import 'dart:async';
import 'dart:html';

import 'package:LakWebsite/src/utility/utility.dart';
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
  final HtmlElement root;
  final ChangeDetectorRef changeRef;

  @Input()
  String title;

  bool block = false;
  bool _inittedLabels = false;

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

  LakModalComponent(this.root, this.changeRef);

  void cancel() {
    _hideStuff();
    onCancel?.call();
  }

  void confirm() {
    _hideStuff();

    onConfirm?.call(elementCallback.map((selector, callback) =>
        MapEntry(selector, callback(root.querySelector('.$selector'))))
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

  void openPrompt(
      {Map<String, dynamic> content = const {},
      Map<String, Function> elementCallback,
      Function(Map<String, dynamic>) onConfirm,
      Function() onCancel}) {
    this.content = content;
    this.onConfirm = onConfirm;
    this.onCancel = onCancel;
    this.elementCallback = elementCallback;
    _initLabels();
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

  @ViewChildren('.row')
  set rows(List<HtmlElement> rows) {
    print('rows = ${rows.length}');
  }

  void _initLabels() {
    if (_inittedLabels) {
      return;
    }

    _inittedLabels = true;

    for (var row in querySelectorAll('.row')) {
      var input = row.querySelector('input');
      var label = row.querySelector('label');

      print('${input.id} and ${label.id}');

      if ((input == null || label == null) ||
          (input.id != '' || input.id != '')) {
        continue;
      }

      var id = uuid.v4();
      input.id = id;
      label.setAttribute('for', id);
    }
  }
}
