import 'package:angular_router/angular_router.dart';

import 'sound_mixer/sound_mixer_component.template.dart' as sound_mixer_component;
import 'home/home_component.template.dart' as home_component;
import 'key_manager/key_manager_component.template.dart' as key_manager_component;
import 'error/error_component.template.dart' as error_component;

class Routes {
  static final home = RouteDefinition(
      routePath: RoutePaths.home,
      component: home_component.HomeComponentNgFactory);

  static final keyboard = RouteDefinition(
      routePath: RoutePaths.keyboard,
      component: key_manager_component.KeyManagerComponentNgFactory);

  static final soundMixer = RouteDefinition(
      routePath: RoutePaths.soundMixer,
      component: sound_mixer_component.SoundMixerComponentNgFactory);

  static final error404 = RouteDefinition(
    path: '.+',
    additionalData: {},
    component: error_component.ErrorComponentNgFactory,
  );

  static final all = <RouteDefinition>[
    home,
    keyboard,
    soundMixer,
    error404
  ];
}

class RoutePaths {
  static final home = RoutePath(path: '/', useAsDefault: true);
  static final keyboard = RoutePath(path: 'keyboard');
  static final soundMixer = RoutePath(path: 'soundMixer');
}
