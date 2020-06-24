import 'package:LakWebsite/src/primary_routes.dart';
import 'package:LakWebsite/src/services/cache_service.dart';
import 'package:LakWebsite/src/services/keyboard_service.dart';
import 'package:LakWebsite/src/services/request_utils.dart';
import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

@Component(
  selector: 'my-app',
  styleUrls: ['app_component.css'],
  templateUrl: 'app_component.html',
  directives: [
    coreDirectives,
    routerDirectives,
  ],
  providers: [
    ClassProvider(RequestService),
    ClassProvider(CacheService),
    ClassProvider(KeyboardService),
  ],
  exports: [Routes, RoutePaths],
)
class AppComponent implements OnInit {

  final CacheService cacheService;

  @Output()
  bool loaded = false;

  AppComponent(this.cacheService);

  @override
  void ngOnInit() async {
    print('here init lol');
    await cacheService.init();
    print('done hmmm');
    loaded = true;
  }

}
