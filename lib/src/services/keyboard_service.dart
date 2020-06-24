
import 'package:LakWebsite/src/components/key/key_component.dart';
import 'package:LakWebsite/src/services/cache_service.dart';
import 'package:LakWebsite/src/services/key/key_enum.dart';
import 'package:LakWebsite/src/services/request_utils.dart';
import 'package:angular/core.dart';

@Injectable()
class KeyboardService {

  final CacheService cacheService;
  final activeKeys = <KeyEnum, KeyData>{};

  KeyboardService(this.cacheService);

  void clickKey(KeyData keyData, [bool ctrlDown = false]) {
    var key = keyData.key;

    if (key == null) {
      return;
    }

    if (activeKeys.containsKey(key)) {
      activeKeys.remove(key).component.active = false;
    } else {
      keyData.component.active = true;
      activeKeys[key] = keyData;
    }

//    active = activeKeys.values.map((data) => data.component.text).join(', ');
  }

  void clearActive() {
    for (var key in activeKeys.values) {
      key.component.active = false;
    }

//    active = '';
    activeKeys.clear();
  }

}

class KeyData {
  final KeyComponent component;
  final KeyEnum key;
  final String primary;
  final String secondary;

  KeyData(this.component, this.key, this.primary, this.secondary);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is KeyData && runtimeType == other.runtimeType && key == other.key;

  @override
  int get hashCode => key.hashCode;
}
