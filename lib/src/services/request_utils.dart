import 'dart:async';
import 'dart:convert';
import 'dart:html';

import 'package:angular/angular.dart';

import '../constants.dart';
import 'objects/sound.dart';

@Injectable()
class RequestService {
  /// Makes a GET request with given headers. Returns JSON.
  Future<RequestResponse> makeRequest(String url,
          {String baseUrl = BASE_URL,
          Map<String, String> query,
          Map<String, String> requestHeaders,
          void onProgress(ProgressEvent e)}) =>
      HttpRequest.request('$baseUrl$url${joinQuery(query)}',
              method: 'GET',
              requestHeaders: requestHeaders,
              onProgress: onProgress)
          .then((HttpRequest xhr) =>
              RequestResponse(xhr.status, jsonDecode(xhr.responseText)));

  Future<RequestResponse> makeAuthedRequest(String url,
          {String baseUrl = BASE_URL,
          Map<String, dynamic> query = const {},
          Map<String, String> requestHeaders = const {}}) async =>
      makeRequest(url,
          baseUrl: baseUrl,
          query: query
              .map((k, v) => MapEntry(k, Uri.encodeComponent('${v ?? ''}'))),
          requestHeaders: {
            ...requestHeaders,
//            ...{'Authorization': authService.accessToken}
          });

  String joinQuery(Map<String, dynamic> query) =>
      (query.isNotEmpty ? '?' : '') +
      query.entries.map((entry) => '${entry.key}=${entry.value}').join('&');

  Future<List<Sound>> listSounds() => makeAuthedRequest('/sounds/list').then(
      (response) => List.of(response.json)
          .map<Sound>((sound) => Sound.fromJson(sound))
          .toList());

  Future<List<SoundVariant>> listSoundVariants() =>
      makeAuthedRequest('/sounds/listVariants').then((response) =>
          List.of(response.validate().json)
              .map<SoundVariant>((variant) => SoundVariant.fromJson(variant))
              .toList());

  Future<void> addSound(String uri) =>
      makeAuthedRequest('/sounds/addSound', query: {'uri': uri});

  Future<SoundVariant> addVariant(String name, String soundId) =>
      makeAuthedRequest('/sounds/addVariant',
              query: {'name': name, 'soundId': soundId})
          .then((response) => response.validate().json);

  // TODO: See if I can just do {"id": id, "soundId": soundId...}
  Future<void> updateVariant(String id,
          {String soundId, String description, String color}) =>
      makeAuthedRequest('/sounds/updateVariant', query: {
        'id': id,
        if (soundId != null) ...{'soundId': soundId},
        if (description != null) ...{'description': description},
        if (color != null) ...{'color': color},
      });

  Future<void> addModulator(String variantId, ModulationId modulationId) =>
      makeAuthedRequest('/sounds/addModulator',
          query: {'variantId': variantId, 'id': modulationId.id});

  Future<void> removeModulator(String variantId, ModulationId modulationId) =>
      makeAuthedRequest('/sounds/removeModulator',
          query: {'variantId': variantId, 'id': modulationId.id});

  Future<SoundModulation> updateModulator(String variantId,
          ModulationId modulationId, Map<String, dynamic> modulatorData) =>
      makeAuthedRequest('/sounds/updateModulator', query: {
        'variantId': variantId,
        'id': modulationId.id,
        'modulatorData': modulatorData
      }).then((response) => SoundModulation.fromJson(response.validate().json));
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
