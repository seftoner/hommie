import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:hommie/services/networking/home_assitant_websocket/types/types.dart';

const String testJson = r'''
{
            "persistent_notification": {
                "create": {
                    "name": "",
                    "description": "Show a notification in the frontend.",
                    "fields": {
                        "message": {
                            "description": "Message body of the notification. [Templates accepted]",
                            "example": "Please check your configuration.yaml."
                        },
                        "title": {
                            "description": "Optional title for your notification. [Optional, Templates accepted]",
                            "example": "Test notification"
                        },
                        "notification_id": {
                            "description": "Target ID of the notification, will replace a notification with the same ID. [Optional]",
                            "example": 1234
                        }
                    }
                },
                "dismiss": {
                    "name": "",
                    "description": "Remove a notification from the frontend.",
                    "fields": {
                        "notification_id": {
                            "description": "Target ID of the notification, which should be removed. [Required]",
                            "example": 1234
                        }
                    }
                },
                "mark_read": {
                    "name": "",
                    "description": "Mark a notification read.",
                    "fields": {
                        "notification_id": {
                            "description": "Target ID of the notification, which should be mark read. [Required]",
                            "example": 1234
                        }
                    }
                }
            },
            "homeassistant": {
                "turn_off": {
                    "name": "Generic turn off",
                    "description": "Generic service to turn devices off under any domain.",
                    "fields": {}
                },
                "turn_on": {
                    "name": "Generic turn on",
                    "description": "Generic service to turn devices on under any domain.",
                    "fields": {}
                }
            }
        }
''';

void main() {
  test("Deserialization of hass services and not crash", () {
    final json = jsonDecode(testJson);

    final response = HassServices.fromJson(json);

    expect(response.domains.keys, ["persistent_notification", "homeassistant"]);
    expect(response.domains["homeassistant"]!.services.keys,
        ["turn_off", "turn_on"]);
  });
}
