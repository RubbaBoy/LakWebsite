import 'dart:async';

import 'package:LakWebsite/src/components/icon/icon_component.dart';
import 'package:LakWebsite/src/components/key/key_component.dart';
import 'package:angular/angular.dart';

@Component(
  selector: 'key-manager',
  styleUrls: ['key_manager_component.css'],
  templateUrl: 'key_manager_component.html',
  directives: [
    IconComponent,
    KeyComponent,
    NgFor,
    NgIf,
  ],
  providers: [],
  exports: [
    KeySize,
  ]
)
class KeyManagerComponent implements OnInit {

  @override
  void ngOnInit() {
    print('Key Manager Init');
  }

}
