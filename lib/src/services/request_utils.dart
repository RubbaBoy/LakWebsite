import 'dart:async';
import 'dart:convert';
import 'dart:html';

import 'package:LakWebsite/src/services/cache_service.dart';
import 'package:LakWebsite/src/services/objects/keys.dart';
import 'package:angular/angular.dart';

import '../utility/constants.dart';
import 'objects/sound.dart';

@Injectable()
class RequestService {
  /// Makes a GET request with given headers. Returns JSON.
  Future<RequestResponse> makeRequest(String url,
          {String method = 'GET',
          String baseUrl = BASE_URL,
          Map<String, String> query,
          dynamic body,
          Map<String, String> requestHeaders,
          void onProgress(ProgressEvent e)}) => HttpRequest.request('$baseUrl$url${joinQuery(query)}',
          method: method,
          requestHeaders: requestHeaders,
          sendData: body == null ? null : jsonEncode(body),
          onProgress: onProgress)
      .catchError((error) {
        print(error);
      })
          .then((HttpRequest xhr) {
        return RequestResponse(xhr.status, jsonDecode(xhr.responseText));
          });

  Future<RequestResponse> makeAuthedRequest(String url,
          {String method = 'GET',
          String baseUrl = BASE_URL,
          Map<String, dynamic> query = const {},
          Map<String, String> requestHeaders = const {}}) async =>
      makeRequest(url,
          method: method,
          baseUrl: baseUrl,
          query: query
              .map((k, v) => MapEntry(k, Uri.encodeComponent('${v ?? ''}'))),
          requestHeaders: {
            ...requestHeaders,
//            ...{'Authorization': authService.accessToken}
          });

  Future<RequestResponse> makeAuthedPostRequest(String url,
          {String baseUrl = BASE_URL,
          Map<String, dynamic> body = const {},
          Map<String, String> requestHeaders = const {}}) async =>
      makeRequest(url,
          method: 'POST',
          baseUrl: baseUrl,
          body: body,
          requestHeaders: {
            ...{'Content-Type': 'application/json'},
            ...requestHeaders,
//            ...{'Authorization': authService.accessToken}
          });

  String joinQuery(Map<String, dynamic> query) {
    if (query == null) {
      return '';
    }

    return (query.isNotEmpty ? '?' : '') +
      query.entries.map((entry) => '${entry.key}=${entry.value}').join('&');
  }

  Future<List<Sound>> listSounds() => makeAuthedRequest('/sounds/list').then(
      (response) => List.of(response.json)
          .map<Sound>((sound) => Sound.fromJson(sound))
          .toList());

  Future<List<SoundVariant>> listSoundVariants() =>
      makeAuthedRequest('/sounds/listVariants').then((response) =>
          List.of(response.validate().json)
              .map<SoundVariant>((variant) => SoundVariant.fromJson(variant))
              .toList());

  Future<void> addSound(String path) =>
      makeAuthedPostRequest('/sounds/addSound', body: {'relPath': path});

  Future<void> recordSound(String name) =>
      makeAuthedPostRequest('/sounds/recordSound', body: {'name': name});

  Future<SoundVariant> addVariant(String name, String soundId) =>
      makeAuthedPostRequest('/sounds/addVariant',
          body: {'name': name, 'soundId': soundId})
          .then((response) => SoundVariant.fromJson(response.validate().json));

  // TODO: See if I can just do {"id": id, "soundId": soundId...}
  Future<void> updateVariant(String id,
          {String soundId, String description, String color}) =>
      makeAuthedPostRequest('/sounds/updateVariant', body: {
        'id': id,
        if (soundId != null) ...{'soundId': soundId},
        if (description != null) ...{'description': description},
        if (color != null) ...{'color': color},
      });

  Future<void> addModulator(String variantId, ModulationId modulationId) =>
      makeAuthedPostRequest('/sounds/addModulator',
          body: {'variantId': variantId, 'id': modulationId.id});

  Future<void> removeModulator(String variantId, ModulationId modulationId) =>
      makeAuthedPostRequest('/sounds/removeModulator',
          body: {'variantId': variantId, 'id': modulationId.id});

  Future<SoundModulation> updateModulator(String variantId,
          ModulationId modulationId, Map<String, dynamic> modulatorData) =>
      makeAuthedPostRequest('/sounds/updateModulator', body: {
        'variantId': variantId,
        'id': modulationId.id,
        'modulatorData': modulatorData
      }).then((response) => SoundModulation.fromJson(response.validate().json));

  /// Returns a list of Json objects reporesenting [Key]s. Requires a dependency
  /// on [CacheService] so it is of the responsibility of the using class to
  /// construct them via [Key.fromJson].
  Future<List<dynamic>> listKeys() => makeAuthedRequest('/keys/list')
      .then((response) => List.of(response.json));

  Future<void> updateKey(Key key) =>
      makeAuthedPostRequest('/keys/update', body: {
        'key': {
          'linuxCode': key.key.linuxCode,
          'shift': key.key.shift,
        },
        'variantId': key.soundVariant.id,
        'loop': key.loop,
      });
}

class RequestResponse {
  int status;
  dynamic json;

  bool get success => status == 200;

  RequestResponse validate() {
    if (!success) {
      throw 'Request was not successful. Code $status\n$json';
    }
    return this;
  }

  RequestResponse(this.status, this.json);
}
