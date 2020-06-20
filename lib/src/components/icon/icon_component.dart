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
    ''', classes: ['bi', 'bi-plus', 'd-block']),
    Icon('question_circle', contents: '''
    <path fill-rule="evenodd" d="M8 15A7 7 0 1 0 8 1a7 7 0 0 0 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
    <path d="M5.25 6.033h1.32c0-.781.458-1.384 1.36-1.384.685 0 1.313.343 1.313 1.168 0 .635-.374.927-.965 1.371-.673.489-1.206 1.06-1.168 1.987l.007.463h1.307v-.355c0-.718.273-.927 1.01-1.486.609-.463 1.244-.977 1.244-2.056 0-1.511-1.276-2.241-2.673-2.241-1.326 0-2.786.647-2.754 2.533zm1.562 5.516c0 .533.425.927 1.01.927.609 0 1.028-.394 1.028-.927 0-.552-.42-.94-1.029-.94-.584 0-1.009.388-1.009.94z"/>
    ''', classes: ['bi', 'bi-question-circle']),
  ];

  final DomSanitizationService serv;
  final HtmlElement ref;

  IconComponent(this.serv, this.ref);

  @Input()
  String icon;

  SafeHtml get html => serv.bypassSecurityTrustHtml(icons
          .firstWhere((element) => element.icon == icon, orElse: () => null)
          ?.toHTML(ref.classes) ??
      '');

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

  String toHTML([Iterable<String> classes = const []]) => '<svg class="${[
        ...classes,
        ...this.classes
      ].join(' ')}" width="$width" height="$height" viewBox="$viewBox" fill="$fill" xmlns="http://www.w3.org/2000/svg">$contents</svg>';
}
