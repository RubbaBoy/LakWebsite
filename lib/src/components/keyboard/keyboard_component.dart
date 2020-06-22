import 'dart:async';

import 'package:angular/angular.dart';

@Component(
  selector: 'keyboard',
  styleUrls: ['keyboard_component.css'],
  templateUrl: 'keyboard_component.html',
  directives: [
    NgFor,
    NgIf,
  ],
  providers: [],
)
class KeyboardComponent implements OnInit {

  @override
  void ngOnInit() {
    print('Keyboard Init');
  }

}
