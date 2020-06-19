import 'dart:async';

import 'package:angular/angular.dart';

@Component(
  selector: 'error',
  styleUrls: ['error_component.css'],
  templateUrl: 'error_component.html',
  directives: [
    NgFor,
    NgIf,
  ],
  providers: [],
)
class ErrorComponent implements OnInit {

  @override
  void ngOnInit() {
    print('Error Init');
  }

}
