import 'dart:async';

import 'package:LakWebsite/src/primary_routes.dart';
import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

@Component(
  selector: 'home',
  styleUrls: ['home_component.css'],
  templateUrl: 'home_component.html',
  directives: [
    NgFor,
    NgIf,
    routerDirectives,
  ],
  providers: [],
  exports: [RoutePaths, Routes],
)
class HomeComponent implements OnInit {

  @override
  void ngOnInit() {
    print('Home Init');
  }

}
