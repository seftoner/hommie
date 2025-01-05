import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:hommie/services/networking/home_assitant_websocket/src/types/types.dart';

import 'utils/tests_helpers.dart';

void main() {
  test('Deserialization of event reposne ', () async {
    final testJson =
        await readJsonTestDataFromFile('test/data_samples/event_initial.json');
    final reponse = WebSocketResponse.fromJson(testJson);
    final state =
        reponse.maybeWhen(event: (i, state) => state, orElse: () => null)!;

    expect(
        state.add
            ?.containsKey('binary_sensor.ivano_frankivska_oblast_artillery'),
        isTrue);
  });

  test('Event deserialization 2', () async {
    final testJson = await readJsonTestDataFromFile(
        'test/data_samples/event_with_changes.json');

    final reponse = WebSocketResponse.fromJson(testJson);

    final state = reponse.maybeWhen(
      event: (_, s) => s,
      orElse: () {
        throw AssertionError('Response parsed incorrectly!');
      },
    );

    expect(state.change!['fan.philips_purifier']?.remove, isNull);
    expect(state.change!['fan.philips_purifier']?.add, isNotNull);
    expect(state.change!['fan.philips_purifier']?.add?.state, '5');
    expect(state.change!['fan.philips_purifier']?.add?.last_updated,
        1712828878.514165);
    expect(state.change!['fan.philips_purifier']?.add?.context,
        const Context(id: '01HV68X3NJDK579CYJNST1VA72'));
  });

  test('Hass servcies deserialization - short', () async {
    final testJson = await readJsonTestDataFromFile(
        'test/data_samples/services_response_short.json');

    final response = WebSocketResponse.fromJson(testJson);

    final responseResult = switch (response) {
      WebSocketResultResponseSuccess(:final result) =>
        HassServices.fromJson(result),
      _ => throw AssertionError('Response parsed incorrectly!')
    };

    expect(responseResult.domains, hasLength(2));
    expect(responseResult.domains.keys,
        ['persistent_notification', 'homeassistant']);
    expect(responseResult.domains['homeassistant']!.services.keys,
        ['turn_off', 'turn_on']);
  });

  test(
      'Hass servcies deserialization. Output from my HA. Check if deserialization works correct',
      () async {
    final testJson = await readJsonTestDataFromFile(
        'test/data_samples/get_services_response.json');

    final response = WebSocketResponse.fromJson(testJson);

    final responseResult = switch (response) {
      WebSocketResultResponseSuccess(:final result) =>
        HassServices.fromJson(result),
      _ => throw AssertionError('Response parsed incorrectly!')
    };

    expect(responseResult.domains, hasLength(44));
  });

  test('Error response deserialization', () async {
    final testJson =
        await readJsonTestDataFromFile('test/data_samples/error_response.json');

    final response = WebSocketResponse.fromJson(testJson);

    final responseResult = switch (response) {
      WebSocketResultResponseError(:final error) => error,
      _ => throw AssertionError('Response parsed incorrectly!')
    };

    expect(response.id, equals(12));
    expect(responseResult.code, equals('invalid_format'));
    expect(
        responseResult.message,
        equals(
            "Message incorrectly formatted: expected str for dictionary value @ data['event_type']. Got 100"));
  });

  test('callService response parsing', () async {
    final testJson = await readJsonTestDataFromFile(
        'test/data_samples/call_service_response.json');

    final response = WebSocketResponse.fromJson(testJson);

    final responseResult = switch (response) {
      WebSocketResultResponseSuccess(:final result) =>
        CallServiceResponse.fromJson(result),
      _ => throw AssertionError('Response parsed incorrectly!')
    };

    expect(
        responseResult.context.id, equals('326ef27d19415c60c492fe330945f954'));
    expect(responseResult.context.parent_id, isNull);
    expect(responseResult.context.user_id,
        equals('31ddb597e03147118cf8d2f8fbea5553'));

    expect(responseResult.response, isNull);
  });

  test('pong response parsing', () {
    const testJsonString = '''{ "id": 19,
                          "type": "pong"
                        }''';
    final testJson = jsonDecode(testJsonString);
    final response = WebSocketResponse.fromJson(testJson);

    final responseResult = switch (response) {
      WebSocketPongResponse(:final id) => id,
      _ => throw AssertionError('Response parsed incorrectly!')
    };

    expect(responseResult, equals(19));
  });

  test('unsupported type response parsing', () {
    const testJsonString = '''{ "id": 19,
                          "type": "custom_reponse"
                        }''';
    final testJson = jsonDecode(testJsonString);

    expect(() => WebSocketResponse.fromJson(testJson), throwsUnsupportedError);
  });
}
