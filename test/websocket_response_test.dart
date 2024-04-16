import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:hommie/services/networking/home_assitant_websocket/types/types.dart';

import 'tests_helpers.dart';

void main() {
  test("Deserialization of event reposne ", () async {
    final testJson =
        await readJsonTestDataFromFile('test/data_samples/event_initial.json');
    final reponse = WebSocketResponse.fromJson(testJson);
    final state =
        reponse.maybeWhen(event: (i, state) => state, orElse: () => null)!;

    expect(
        state.add
            ?.containsKey("binary_sensor.ivano_frankivska_oblast_artillery"),
        isTrue);
  });

  test("Event deserialization 2", () async {
    final testJson = await readJsonTestDataFromFile(
        'test/data_samples/event_with_changes.json');

    final reponse = WebSocketResponse.fromJson(testJson);

    final state = reponse.maybeWhen(
      event: (_, s) => s,
      orElse: () {
        throw AssertionError("Response parsed incorrectly!");
      },
    );

    expect(state.change!["fan.philips_purifier"]?.remove, isNull);
    expect(state.change!["fan.philips_purifier"]?.add, isNotNull);
    expect(state.change!["fan.philips_purifier"]?.add?.state, "5");
    expect(state.change!["fan.philips_purifier"]?.add?.last_updated,
        1712828878.514165);
    expect(state.change!["fan.philips_purifier"]?.add?.context,
        const Context("01HV68X3NJDK579CYJNST1VA72"));
  });

  test("Hass servcies deserialization", () async {
    final testJson = await readJsonTestDataFromFile(
        'test/data_samples/services_list_response.json');

    final response = WebSocketResponse.fromJson(testJson);

    final responseResult = switch (response) {
      WebSocketResultResponseSuccess(:final result) =>
        HassServices.fromJson(result),
      _ => throw AssertionError("Response parsed incorrectly!")
    };

    expect(responseResult.domains.length, 2);
    expect(responseResult.domains.keys,
        ["persistent_notification", "homeassistant"]);
    expect(responseResult.domains["homeassistant"]!.services.keys,
        ["turn_off", "turn_on"]);
  });
}
