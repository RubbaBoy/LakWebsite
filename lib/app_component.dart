import 'package:LakWebsite/src/primary_routes.dart';
import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

@Component(
  selector: 'my-app',
  styleUrls: ['app_component.css'],
  templateUrl: 'app_component.html',
  directives: [routerDirectives],
  exports: [Routes, RoutePaths],
)
class AppComponent extends OnInit {

  @override
  void ngOnInit() {
    print('Init main app');
  }

}
