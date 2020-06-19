import 'dart:async';

import 'package:angular/angular.dart';

@Component(
  selector: 'sound-mixer',
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
