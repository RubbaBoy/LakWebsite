import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular/security.dart';

@Component(
  selector: 'icon',
  templateUrl: 'icon_component.html',
  styleUrls: ['icon_component.css'],
  directives: [
    coreDirectives,
  ],
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class IconComponent {
  static final icons = <Icon>[
    Icon('plus', contents: '''
    <path fill-rule="evenodd" d="M8 3.5a.5.5 0 0 1 .5.5v4a.5.5 0 0 1-.5.5H4a.5.5 0 0 1 0-1h3.5V4a.5.5 0 0 1 .5-.5z"/>
    <path fill-rule="evenodd" d="M7.5 8a.5.5 0 0 1 .5-.5h4a.5.5 0 0 1 0 1H8.5V12a.5.5 0 0 1-1 0V8z"/>
    ''', classes: ['bi', 'bi-plus', 'd-block']),
    Icon('question_circle', contents: '''
    <path fill-rule="evenodd" d="M8 15A7 7 0 1 0 8 1a7 7 0 0 0 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
    <path d="M5.25 6.033h1.32c0-.781.458-1.384 1.36-1.384.685 0 1.313.343 1.313 1.168 0 .635-.374.927-.965 1.371-.673.489-1.206 1.06-1.168 1.987l.007.463h1.307v-.355c0-.718.273-.927 1.01-1.486.609-.463 1.244-.977 1.244-2.056 0-1.511-1.276-2.241-2.673-2.241-1.326 0-2.786.647-2.754 2.533zm1.562 5.516c0 .533.425.927 1.01.927.609 0 1.028-.394 1.028-.927 0-.552-.42-.94-1.029-.94-.584 0-1.009.388-1.009.94z"/>
    ''', classes: ['bi', 'bi-question-circle']),
    Icon('layout_text_sidebar_reverse', contents: '''
    <path fill-rule="evenodd" d="M2 1h12a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1H2a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1zm12-1a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V2a2 2 0 0 1 2-2h12z"/>
    <path fill-rule="evenodd" d="M5 15V1H4v14h1zm8-11.5a.5.5 0 0 0-.5-.5h-5a.5.5 0 0 0 0 1h5a.5.5 0 0 0 .5-.5zm0 3a.5.5 0 0 0-.5-.5h-5a.5.5 0 0 0 0 1h5a.5.5 0 0 0 .5-.5zm0 3a.5.5 0 0 0-.5-.5h-5a.5.5 0 0 0 0 1h5a.5.5 0 0 0 .5-.5zm0 3a.5.5 0 0 0-.5-.5h-5a.5.5 0 0 0 0 1h5a.5.5 0 0 0 .5-.5z"/>
    ''', classes: ['bi', 'bi-layout-text-sidebar-reverse']),
    Icon('house_fill', contents: '''
    <path fill-rule="evenodd" d="M8 3.293l6 6V13.5a1.5 1.5 0 0 1-1.5 1.5h-9A1.5 1.5 0 0 1 2 13.5V9.293l6-6zm5-.793V6l-2-2V2.5a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5z"/>
    <path fill-rule="evenodd" d="M7.293 1.5a1 1 0 0 1 1.414 0l6.647 6.646a.5.5 0 0 1-.708.708L8 2.207 1.354 8.854a.5.5 0 1 1-.708-.708L7.293 1.5z"/>
    ''', classes: ['bi', 'bi-house-fill']),
    Icon('arrow_right', contents: '''
    <path fill-rule="evenodd" d="M10.146 4.646a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708-.708L12.793 8l-2.647-2.646a.5.5 0 0 1 0-.708z"/>
    <path fill-rule="evenodd" d="M2 8a.5.5 0 0 1 .5-.5H13a.5.5 0 0 1 0 1H2.5A.5.5 0 0 1 2 8z"/>
    ''', classes: ['bi', 'bi-arrow-right']),
    Icon('arrow_left', contents: '''
    <path fill-rule="evenodd" d="M5.854 4.646a.5.5 0 0 1 0 .708L3.207 8l2.647 2.646a.5.5 0 0 1-.708.708l-3-3a.5.5 0 0 1 0-.708l3-3a.5.5 0 0 1 .708 0z"/>
    <path fill-rule="evenodd" d="M2.5 8a.5.5 0 0 1 .5-.5h10.5a.5.5 0 0 1 0 1H3a.5.5 0 0 1-.5-.5z"/>
    ''', classes: ['bi', 'bi-arrow-left']),
    Icon('arrow_up', contents: '''
    <path fill-rule="evenodd" d="M8 3.5a.5.5 0 0 1 .5.5v9a.5.5 0 0 1-1 0V4a.5.5 0 0 1 .5-.5z"/>
    <path fill-rule="evenodd" d="M7.646 2.646a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1-.708.708L8 3.707 5.354 6.354a.5.5 0 1 1-.708-.708l3-3z"/>
    ''', classes: ['bi', 'bi-arrow-up']),
    Icon('arrow_down', contents: '''
    <path fill-rule="evenodd" d="M4.646 9.646a.5.5 0 0 1 .708 0L8 12.293l2.646-2.647a.5.5 0 0 1 .708.708l-3 3a.5.5 0 0 1-.708 0l-3-3a.5.5 0 0 1 0-.708z"/>
    <path fill-rule="evenodd" d="M8 2.5a.5.5 0 0 1 .5.5v9a.5.5 0 0 1-1 0V3a.5.5 0 0 1 .5-.5z"/>
    ''', classes: ['bi', 'bi-arrow-down']),
    Icon('microphone', contents: '''
    <path d="M0 0h24v24H0z" fill="none"/>
    <path d="M12 14c1.66 0 2.99-1.34 2.99-3L15 5c0-1.66-1.34-3-3-3S9 3.34 9 5v6c0 1.66 1.34 3 3 3zm5.3-3c0 3-2.54 5.1-5.3 5.1S6.7 14 6.7 11H5c0 3.41 2.72 6.23 6 6.72V21h2v-3.28c3.28-.48 6-3.3 6-6.72h-1.7z"/>
    ''', classes: ['bi', 'bi-arrow-down'], viewBox: '0 0 24 24'),
    Icon('file', contents: '''
    <path d="M0 0h24v24H0z" fill="none"/>
    <path d="M6 2c-1.1 0-1.99.9-1.99 2L4 20c0 1.1.89 2 1.99 2H18c1.1 0 2-.9 2-2V8l-6-6H6zm7 7V3.5L18.5 9H13z"/>
    ''', classes: ['bi'], viewBox: '0 0 24 24'),
  ];

  final DomSanitizationService serv;
  final HtmlElement ref;

  IconComponent(this.serv, this.ref);

  @Input()
  String icon;

  /// The color of the icon. May be provided in a straight hex code, minus the #
  @Input()
  String color = 'black';

  /// If the SVG should be displayed in the DOM. [false] indicates it will be
  /// displayed with CSS in the host <icon> element.
  @Input()
  bool dom = false;

  @HostBinding('class.nondom-icon')
  bool get nonDom => !dom;

  @HostBinding('style.background-image')
  String get back => dom ? null : 'url("data:image/svg+xml,${clean(html.toString())}")';

  SafeHtml get html => serv.bypassSecurityTrustHtml(icons
          .firstWhere((element) => element.icon == icon, orElse: () => null)
          ?.toHTML(classes: ref.classes, fill: '%23$color') ??
      '');

  String clean(String html) => html.replaceAll('"', "\'").replaceAll('\n', '').replaceAll('    ', '');
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

  String toHTML({Iterable<String> classes = const [], String fill}) => '<svg class="${[
        ...classes,
        ...this.classes
      ].join(' ')}" width="$width" height="$height" viewBox="$viewBox" fill="${fill ?? this.fill}" xmlns="http://www.w3.org/2000/svg">$contents</svg>';
}
