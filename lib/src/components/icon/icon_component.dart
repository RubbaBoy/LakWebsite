import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular/security.dart';

@Component(
  selector: 'icon',
  templateUrl: 'icon_component.html',
  directives: [
    coreDirectives,
  ],
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class IconComponent extends OnInit {

  static final icons = <Icon>[
    Icon('plus', contents: '''
  <path fill-rule="evenodd" d="M8 3.5a.5.5 0 0 1 .5.5v4a.5.5 0 0 1-.5.5H4a.5.5 0 0 1 0-1h3.5V4a.5.5 0 0 1 .5-.5z"/>
  <path fill-rule="evenodd" d="M7.5 8a.5.5 0 0 1 .5-.5h4a.5.5 0 0 1 0 1H8.5V12a.5.5 0 0 1-1 0V8z"/>
  ''', classes: ['bi', 'bi-plus', 'd-block'])
  ];

  final DomSanitizationService serv;
  final HtmlElement ref;

  IconComponent(this.serv, this.ref);

  @Input()
  String icon;

  SafeHtml get html {
    print('htmlllllllllllllllllllllllll');
    return serv.bypassSecurityTrustHtml(icons
      .firstWhere((element) => element.icon == icon, orElse: () => null)
      ?.toHTML(ref.classes) ??
      '');
  }

  @override
  void ngOnInit() {
    print('rel = $ref');
    print(ref.classes);
  }
}

class Icon {
  final String icon;
  final List<String> classes;
  final String width;
  final String height;
  final String viewBox;
  final String fill;
  final String contents;

  const Icon(
    this.icon, {
    this.classes = const [],
    this.width = '1em',
    this.height = '1em',
    this.viewBox = '0 0 16 16',
    this.fill = 'currentColor',
    this.contents = '',
  });

String toHTML([Iterable<String> classes = const []]) =>
    '<svg class="${[...classes, ...this.classes].join(' ')}" width="$width" height="$height" viewBox="$viewBox" fill="$fill" xmlns="http://www.w3.org/2000/svg">$contents</svg>';
}
