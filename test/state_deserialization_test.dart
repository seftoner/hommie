import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:hommie/services/networking/home_assitant_websocket/types.dart';

const String jsonRaw = '''
{"a": {
                "person.seftoner": {
                    "s": "not_home",
                    "a": {
                        "editable": true,
                        "id": "seftoner",
                        "latitude": 47.0,
                        "longitude": 25.0,
                        "gps_accuracy": 18.350165176516935,
                        "source": "device_tracker.slnt",
                        "user_id": "cc4e3e7bd8304aa48c316a47f9a8bb66",
                        "device_trackers": [
                            "device_tracker.slnt",
                            "device_tracker.test_iphone_flutter",
                            "device_tracker.iphone"
                        ],
                        "friendly_name": "seftoner"
                    },
                    "c": "01HV3B31R2AG06DS90AHK5XJZY",
                    "lc": 1712730458.850153,
                    "lu": 1712730507.010612
                },
                "update.home_assistant_supervisor_update": {
                    "s": "off",
                    "a": {
                        "auto_update": true,
                        "installed_version": "2024.04.0",
                        "in_progress": false,
                        "latest_version": "2024.04.0",
                        "release_summary": null,
                        "release_url": "https://github.com/home-assistant/supervisor/releases/tag/2024.04.0",
                        "skipped_version": null,
                        "title": "Home Assistant Supervisor",
                        "entity_picture": "https://brands.home-assistant.io/hassio/icon.png",
                        "friendly_name": "Home Assistant Supervisor Update",
                        "supported_features": 1
                    },
                    "c": "01HV3B1NCDNC5Z7R2M7P9YWJEE",
                    "lc": 1712730461.581472
                },
                "update.home_assistant_core_update": {
                    "s": "on",
                    "a": {
                        "auto_update": false,
                        "installed_version": "2024.1.5",
                        "in_progress": false,
                        "latest_version": "2024.4.2",
                        "release_summary": null,
                        "release_url": "https://www.home-assistant.io/latest-release-notes/",
                        "skipped_version": null,
                        "title": "Home Assistant Core",
                        "entity_picture": "https://brands.home-assistant.io/homeassistant/icon.png",
                        "friendly_name": "Home Assistant Core Update",
                        "supported_features": 11
                    },
                    "c": "01HV3B1NCGB6TK0R09M147ZBQS",
                    "lc": 1712730461.58434
                },
                "update.terminal_ssh_update": {
                    "s": "on",
                    "a": {
                        "auto_update": false,
                        "installed_version": "9.8.1",
                        "in_progress": false,
                        "latest_version": "9.10.0",
                        "release_summary": "new",
                        "release_url": null,
                        "skipped_version": null,
                        "title": "Terminal & SSH",
                        "entity_picture": "/api/hassio/addons/core_ssh/icon",
                        "friendly_name": "Terminal & SSH Update",
                        "supported_features": 25
                    },
                    "c": "01HV3B1NCGCNP2ZN72BHG8YR33",
                    "lc": 1712730461.584823
                },
                "update.aircast_update": {
                    "s": "on",
                    "a": {
                        "auto_update": true,
                        "installed_version": "4.2.0",
                        "in_progress": false,
                        "latest_version": "4.2.1",
                        "release_summary": "## What’s ",
                        "release_url": null,
                        "skipped_version": null,
                        "title": "AirCast",
                        "entity_picture": "/api/hassio/addons/a0d7b954_aircast/icon",
                        "friendly_name": "AirCast Update",
                        "supported_features": 25
                    },
                    "c": "01HV3B1NCHQ4WKRF2PNYJ0PHA7",
                    "lc": 1712730461.585226
                },
                "update.tailscale_update": {
                    "s": "on",
                    "a": {
                        "auto_update": true,
                        "installed_version": "0.15.0",
                        "in_progress": false,
                        "latest_version": "0.17.0",
                        "release_summary": "## What",
                        "release_url": null,
                        "skipped_version": null,
                        "title": "Tailscale",
                        "entity_picture": "/api/hassio/addons/a0d7b954_tailscale/icon",
                        "friendly_name": "Tailscale Update",
                        "supported_features": 25
                    },
                    "c": "01HV3B1NCHMW0VRESRX89DDJC4",
                    "lc": 1712730461.585565
                },
                "update.home_assistant_operating_system_update": {
                    "s": "on",
                    "a": {
                        "auto_update": false,
                        "installed_version": "11.4",
                        "in_progress": false,
                        "latest_version": "11.5",
                        "release_summary": null,
                        "release_url": "https://github.com/home-assistant/operating-system/releases/tag/11.5",
                        "skipped_version": null,
                        "title": "Home Assistant Operating System",
                        "entity_picture": "https://brands.home-assistant.io/homeassistant/icon.png",
                        "friendly_name": "Home Assistant Operating System Update",
                        "supported_features": 3
                    },
                    "c": "01HV3B1NCJYV3JD3JEQK2MG0J4",
                    "lc": 1712730461.586115
                },
                "sun.sun": {
                    "s": "above_horizon",
                    "a": {
                        "next_dawn": "2024-04-11T03:05:28.848106+00:00",
                        "next_dusk": "2024-04-10T17:39:43.083114+00:00",
                        "next_midnight": "2024-04-10T22:22:51+00:00",
                        "next_noon": "2024-04-11T10:22:56+00:00",
                        "next_rising": "2024-04-11T03:38:50.906944+00:00",
                        "next_setting": "2024-04-10T17:06:17.754005+00:00",
                        "elevation": 26.38,
                        "azimuth": 251.26,
                        "rising": false,
                        "friendly_name": "Sun"
                    },
                    "c": "01HV4610TAXVY93054DB9PM1GS",
                    "lc": 1712730462.522215,
                    "lu": 1712758752.074662
                },
                "zone.home": {
                    "s": "0",
                    "a": {
                        "latitude": 47.0,
                        "longitude": 25.0,
                        "radius": 100,
                        "passive": false,
                        "persons": [],
                        "editable": true,
                        "icon": "mdi:home",
                        "friendly_name": "Home"
                    },
                    "c": "01HV3B1P9TMMADKGWE4A5BMH51",
                    "lc": 1712730462.52271
                },
                "sensor.sun_next_dawn": {
                    "s": "2024-04-11T03:05:28+00:00",
                    "a": {
                        "device_class": "timestamp",
                        "icon": "mdi:sun-clock",
                        "friendly_name": "Sun Next dawn"
                    },
                    "c": "01HV3B1Q0F76D0PA0G28CXS7G5",
                    "lc": 1712730463.247623
                },
                "sensor.sun_next_dusk": {
                    "s": "2024-04-10T17:39:43+00:00",
                    "a": {
                        "device_class": "timestamp",
                        "icon": "mdi:sun-clock",
                        "friendly_name": "Sun Next dusk"
                    },
                    "c": "01HV3B1Q0FR3H3Y6D9BC60JEJX",
                    "lc": 1712730463.247843
                },
                "sensor.sun_next_midnight": {
                    "s": "2024-04-10T22:22:51+00:00",
                    "a": {
                        "device_class": "timestamp",
                        "icon": "mdi:sun-clock",
                        "friendly_name": "Sun Next midnight"
                    },
                    "c": "01HV3B1Q0GKJXG1JETDP9QA7P4",
                    "lc": 1712730463.248068
                },
                "sensor.sun_next_noon": {
                    "s": "2024-04-11T10:22:56+00:00",
                    "a": {
                        "device_class": "timestamp",
                        "icon": "mdi:sun-clock",
                        "friendly_name": "Sun Next noon"
                    },
                    "c": "01HV3RGWM2A1XQAAV5F58PJZ23",
                    "lc": 1712744592.002582
                },
                "sensor.sun_next_rising": {
                    "s": "2024-04-11T03:38:50+00:00",
                    "a": {
                        "device_class": "timestamp",
                        "icon": "mdi:sun-clock",
                        "friendly_name": "Sun Next rising"
                    },
                    "c": "01HV3B1Q0GJZM5CRG3H07AVBY6",
                    "lc": 1712730463.248433
                },
                "sensor.sun_next_setting": {
                    "s": "2024-04-10T17:06:17+00:00",
                    "a": {
                        "device_class": "timestamp",
                        "icon": "mdi:sun-clock",
                        "friendly_name": "Sun Next setting"
                    },
                    "c": "01HV3B1Q0G7A7P9PYTX9CNQZ5P",
                    "lc": 1712730463.248606
                },
                "todo.shopping_list": {
                    "s": "0",
                    "a": {
                        "icon": "mdi:cart",
                        "friendly_name": "Shopping List",
                        "supported_features": 15
                    },
                    "c": "01HV3B1QGWJNEQBV0F7AQJH3HE",
                    "lc": 1712730463.772854
                },
                "weather.forecast_home": {
                    "s": "partlycloudy",
                    "a": {
                        "temperature": 25.8,
                        "dew_point": 12.4,
                        "temperature_unit": "°C",
                        "humidity": 43,
                        "cloud_coverage": 63.3,
                        "pressure": 1018.5,
                        "pressure_unit": "hPa",
                        "wind_bearing": 58.9,
                        "wind_speed": 9.0,
                        "wind_speed_unit": "km/h",
                        "visibility_unit": "km",
                        "precipitation_unit": "mm",
                        "forecast": [
                            {
                                "condition": "partlycloudy",
                                "datetime": "2024-04-10T09:00:00+00:00",
                                "wind_bearing": 58.9,
                                "temperature": 25.8,
                                "templow": 16.8,
                                "wind_speed": 21.2,
                                "precipitation": 0.0,
                                "humidity": 43
                            },
                            {
                                "condition": "cloudy",
                                "datetime": "2024-04-11T09:00:00+00:00",
                                "wind_bearing": 346.3,
                                "temperature": 19.6,
                                "templow": 14.0,
                                "wind_speed": 18.0,
                                "precipitation": 0.0,
                                "humidity": 65
                            },
                            {
                                "condition": "cloudy",
                                "datetime": "2024-04-12T09:00:00+00:00",
                                "wind_bearing": 332.3,
                                "temperature": 20.2,
                                "templow": 13.4,
                                "wind_speed": 15.8,
                                "precipitation": 0.2,
                                "humidity": 75
                            },
                            {
                                "condition": "partlycloudy",
                                "datetime": "2024-04-13T09:00:00+00:00",
                                "wind_bearing": 321.0,
                                "temperature": 20.9,
                                "templow": 12.2,
                                "wind_speed": 20.9,
                                "precipitation": 0.2,
                                "humidity": 48
                            },
                            {
                                "condition": "cloudy",
                                "datetime": "2024-04-14T09:00:00+00:00",
                                "wind_bearing": 233.8,
                                "temperature": 24.4,
                                "templow": 14.2,
                                "wind_speed": 31.0,
                                "precipitation": 0.0,
                                "humidity": 45
                            },
                            {
                                "condition": "sunny",
                                "datetime": "2024-04-15T09:00:00+00:00",
                                "wind_bearing": 223.5,
                                "temperature": 27.5,
                                "templow": 17.1,
                                "wind_speed": 19.1,
                                "precipitation": 0.0,
                                "humidity": 36
                            }
                        ],
                        "attribution": "Weather forecast from met.no, delivered by the Norwegian Meteorological Institute.",
                        "friendly_name": "Forecast Home",
                        "supported_features": 3
                    },
                    "c": "01HV447D40HCCYBSXVTNHKJP0S",
                    "lc": 1712730463.78295,
                    "lu": 1712756864.128183
                },
                "media_player.lg_webos_tv_lh590v": {
                    "s": "off",
                    "a": {
                        "source_list": [
                            "Live TV"
                        ],
                        "assumed_state": true,
                        "device_class": "tv",
                        "friendly_name": "[LG] webOS TV LH590V",
                        "supported_features": 24381
                    },
                    "c": "01HV3B1QHB5PENMMM349A9WYZ9",
                    "lc": 1712730463.787257
                },
                "automation.new_automation": {
                    "s": "off",
                    "a": {
                        "id": "0127025623633",
                        "last_triggered": "2024-01-23T15:04:29.387293+00:00",
                        "mode": "single",
                        "current": 0,
                        "friendly_name": "New Automation"
                    },
                    "c": "01HV3B1QHJA28PW4QPJZGF2M41",
                    "lc": 1712730463.794248
                },
                "automation.new_automation_2": {
                    "s": "off",
                    "a": {
                        "id": "5680425163025",
                        "last_triggered": "2024-02-27T14:04:25.278400+00:00",
                        "mode": "single",
                        "current": 0,
                        "friendly_name": "New Automation"
                    },
                    "c": "01HV3B1QHJQVZDN3AAABNS15GG",
                    "lc": 1712730463.794425
                },
                "tts.google_en_com": {
                    "s": "unknown",
                    "a": {
                        "friendly_name": "Google en com"
                    },
                    "c": "01HV3B1QJ2V0TMCB9WV066RRKZ",
                    "lc": 1712730463.810321
                },
                "button.casaos_plex_scan_clients": {
                    "s": "unknown",
                    "a": {
                        "friendly_name": "casaos plex Scan clients"
                    },
                    "c": "01HV3B1QJ34ZZ5PYYGTX3YVF5A",
                    "lc": 1712730463.811188
                },
                "sensor.slnt_connection_type": {
                    "s": "Wi-Fi",
                    "a": {
                        "icon": "mdi:wifi",
                        "friendly_name": "SLNT👁 Connection Type"
                    },
                    "c": "01HV3B1QJ6ESB8KXA0TR5NJ841",
                    "lc": 1712730463.814405
                },
                "sensor.slnt_bssid": {
                    "s": "unavailable",
                    "a": {
                        "icon": "mdi:dots-square",
                        "friendly_name": "SLNT👁 BSSID"
                    },
                    "c": "01HV3B1QJ6MFCV619NT5B66ZT4",
                    "lc": 1712730463.81459
                },
                "sensor.slnt_battery_level": {
                    "s": "75",
                    "a": {
                        "unit_of_measurement": "%",
                        "device_class": "battery",
                        "icon": "mdi:battery-charging-60",
                        "friendly_name": "SLNT👁 Battery Level"
                    },
                    "c": "01HV3B1QJ6FCSZW6GPKD4WXC54",
                    "lc": 1712730463.814912
                },
                "sensor.slnt_storage": {
                    "s": "unavailable",
                    "a": {
                        "unit_of_measurement": "% available",
                        "icon": "mdi:dots-square",
                        "friendly_name": "SLNT👁 Storage"
                    },
                    "c": "01HV3B1QJ7MPFCV28ACMK0KQNF",
                    "lc": 1712730463.815104
                },
                "sensor.slnt_ssid": {
                    "s": "EleksProject",
                    "a": {
                        "icon": "mdi:wifi",
                        "friendly_name": "SLNT👁 SSID"
                    },
                    "c": "01HV3B1QJ74C9NEVYA2EBTZS8M",
                    "lc": 1712730463.815277
                },
                "sensor.slnt_battery_state": {
                    "s": "Charging",
                    "a": {
                        "Low Power Mode": false,
                        "icon": "mdi:battery-charging-60",
                        "friendly_name": "SLNT👁 Battery State"
                    },
                    "c": "01HV3B1QJ7QER4T7FWTF554GJP",
                    "lc": 1712730463.815452
                },
                "sensor.slnt_geocoded_location": {
                    "s": "unavailable",
                    "a": {
                        "icon": "mdi:dots-square",
                        "friendly_name": "SLNT👁 Geocoded Location"
                    },
                    "c": "01HV3B1QJ77NBDMXWA3W6GGY10",
                    "lc": 1712730463.815602
                },
                "sensor.slnt_sim_1": {
                    "s": "unavailable",
                    "a": {
                        "icon": "mdi:dots-square",
                        "friendly_name": "SLNT👁 SIM 1"
                    },
                    "c": "01HV3B1QJ7S9MYQ8PYP11RTHX9",
                    "lc": 1712730463.815751
                },
                "sensor.slnt_sim_2": {
                    "s": "unavailable",
                    "a": {
                        "icon": "mdi:dots-square",
                        "friendly_name": "SLNT👁 SIM 2"
                    },
                    "c": "01HV3B1QJ7XRYGYPDCE6TPNWR9",
                    "lc": 1712730463.815893
                },
                "sensor.slnt_last_update_trigger": {
                    "s": "Launch",
                    "a": {
                        "icon": "mdi:cellphone-wireless",
                        "friendly_name": "SLNT👁 Last Update Trigger"
                    },
                    "c": "01HV3B1QJ8K6MVEQ4T9TJG8GW0",
                    "lc": 1712730463.81607
                },
                "device_tracker.test_iphone_flutter": {
                    "s": "unknown",
                    "a": {
                        "source_type": "gps",
                        "friendly_name": "Test iPhone Flutter"
                    },
                    "c": "01HV3B1QJEPEH6JW9XZCCBZ8TV",
                    "lc": 1712730463.822013
                },
                "device_tracker.slnt": {
                    "s": "not_home",
                    "a": {
                        "source_type": "gps",
                        "battery_level": 80,
                        "latitude": 47.0,
                        "longitude": 25.0,
                        "gps_accuracy": 18.350165176516935,
                        "altitude": 244.6654510498047,
                        "vertical_accuracy": 6.166649341583252,
                        "friendly_name": "SLNT👁"
                    },
                    "c": "01HV3B1QJE4C2G829X00M6XV4C",
                    "lc": 1712730463.822428
                },
                "device_tracker.iphone": {
                    "s": "unknown",
                    "a": {
                        "source_type": "gps",
                        "friendly_name": "iPhone"
                    },
                    "c": "01HV3B1QJEC9DD7PYHPBPJZ43S",
                    "lc": 1712730463.822875
                },
                "remote.deep_dungeon": {
                    "s": "off",
                    "a": {
                        "activity_list": null,
                        "current_activity": "com.google.android.apps.tv.dreamx",
                        "friendly_name": "Deep Dungeon TV",
                        "supported_features": 4
                    },
                    "c": "01HV3B1QJG9TR72MGYSTRKXH8M",
                    "lc": 1712730463.824256
                },
                "binary_sensor.ivano_frankivska_oblast_unknown": {
                    "s": "off",
                    "a": {
                        "attribution": "Data provided by Ukraine Alarm",
                        "device_class": "safety",
                        "friendly_name": "Івано-Франківська область Unknown"
                    },
                    "c": "01HV3B1QKRRSBT79PSPYN88A2C",
                    "lc": 1712730463.864169
                },
                "binary_sensor.ivano_frankivska_oblast_air": {
                    "s": "off",
                    "a": {
                        "attribution": "Data provided by Ukraine Alarm",
                        "device_class": "safety",
                        "icon": "mdi:cloud",
                        "friendly_name": "Івано-Франківська область Air"
                    },
                    "c": "01HV3B1QKR501GT6AT54NW3M2H",
                    "lc": 1712730463.864416
                },
                "binary_sensor.ivano_frankivska_oblast_urban_fights": {
                    "s": "off",
                    "a": {
                        "attribution": "Data provided by Ukraine Alarm",
                        "device_class": "safety",
                        "icon": "mdi:pistol",
                        "friendly_name": "Івано-Франківська область Urban fights"
                    },
                    "c": "01HV3B1QKR84PZH7YC5M56RE45",
                    "lc": 1712730463.864577
                },
                "binary_sensor.ivano_frankivska_oblast_artillery": {
                    "s": "off",
                    "a": {
                        "attribution": "Data provided by Ukraine Alarm",
                        "device_class": "safety",
                        "icon": "mdi:tank",
                        "friendly_name": "Івано-Франківська область Artillery"
                    },
                    "c": "01HV3B1QKRKZEKRWBH00EMYR2F",
                    "lc": 1712730463.864731
                },
                "binary_sensor.ivano_frankivska_oblast_chemical": {
                    "s": "off",
                    "a": {
                        "attribution": "Data provided by Ukraine Alarm",
                        "device_class": "safety",
                        "icon": "mdi:chemical-weapon",
                        "friendly_name": "Івано-Франківська область Chemical"
                    },
                    "c": "01HV3B1QKRFQ7M888Q4C9YAR31",
                    "lc": 1712730463.864889
                },
                "binary_sensor.ivano_frankivska_oblast_nuclear": {
                    "s": "off",
                    "a": {
                        "attribution": "Data provided by Ukraine Alarm",
                        "device_class": "safety",
                        "icon": "mdi:nuke",
                        "friendly_name": "Івано-Франківська область Nuclear"
                    },
                    "c": "01HV3B1QKSF959RQ7TNECYZ705",
                    "lc": 1712730463.865061
                },
                "sensor.casaos_plex": {
                    "s": "0",
                    "a": {
                        "unit_of_measurement": "watching",
                        "icon": "mdi:plex",
                        "friendly_name": "casaos plex"
                    },
                    "c": "01HV3B1VWZT4YV8AVDTQXA66VD",
                    "lc": 1712730468.25586
                },
                "sensor.archer_c80_ac1900_mu_mimo_wi_fi_router_external_ip": {
                    "s": "100.101.47.154",
                    "a": {
                        "icon": "mdi:server-network",
                        "friendly_name": "Archer C80 AC1900 MU-MIMO Wi-Fi Router External IP"
                    },
                    "c": "01HV3B1QRRJKG1JDR5PN18C143",
                    "lc": 1712730464.024799
                },
                "sensor.archer_c80_ac1900_mu_mimo_wi_fi_router_download_speed": {
                    "s": "18.5929297626725",
                    "a": {
                        "state_class": "measurement",
                        "unit_of_measurement": "KiB/s",
                        "device_class": "data_rate",
                        "icon": "mdi:server-network",
                        "friendly_name": "Archer C80 AC1900 MU-MIMO Wi-Fi Router Download speed"
                    },
                    "c": "01HV466JMWPDHJGFNQXFBWCWZK",
                    "lc": 1712758934.172967
                },
                "sensor.archer_c80_ac1900_mu_mimo_wi_fi_router_upload_speed": {
                    "s": "69.8292799181361",
                    "a": {
                        "state_class": "measurement",
                        "unit_of_measurement": "KiB/s",
                        "device_class": "data_rate",
                        "icon": "mdi:server-network",
                        "friendly_name": "Archer C80 AC1900 MU-MIMO Wi-Fi Router Upload speed"
                    },
                    "c": "01HV466JMX2X47XM5EXGFBA3RY",
                    "lc": 1712758934.173039
                },
                "sensor.hacs": {
                    "s": "5",
                    "a": {
                        "repositories": [
                            {
                                "name": "custom-cards/button-card",
                                "display_name": "button-card",
                                "installed_version": "v4.1.1",
                                "available_version": "v4.1.2"
                            },
                            {
                                "name": "kongo09/philips-airpurifier-coap",
                                "display_name": "Philips AirPurifier (with CoAP)",
                                "installed_version": "v0.17.6",
                                "available_version": "v0.18.7"
                            },
                            {
                                "name": "basnijholt/lovelace-ios-themes",
                                "display_name": "iOS Themes - Dark Mode and Light Mode",
                                "installed_version": "v2.11.0",
                                "available_version": "v2.13.0"
                            },
                            {
                                "name": "hacs/integration",
                                "display_name": "HACS",
                                "installed_version": "1.33.0",
                                "available_version": "1.34.0"
                            },
                            {
                                "name": "piitaya/lovelace-mushroom",
                                "display_name": "Mushroom",
                                "installed_version": "v3.2.4",
                                "available_version": "v3.5.4"
                            }
                        ],
                        "unit_of_measurement": "pending update(s)",
                        "icon": "hacs:hacs",
                        "friendly_name": "hacs"
                    },
                    "c": "01HV3B33ZBJE39P2ZT8BMMMX3Y",
                    "lc": 1712730509.291405
                },
                "update.plex_media_server_casaos_plex": {
                    "s": "on",
                    "a": {
                        "auto_update": false,
                        "installed_version": "1.32.8.7639-fb6452ebf",
                        "in_progress": false,
                        "latest_version": "1.40.1.8227-c0dd5a73e",
                        "release_summary": null,
                        "release_url": null,
                        "skipped_version": null,
                        "title": null,
                        "entity_picture": "https://brands.home-assistant.io/_/plex/icon.png",
                        "friendly_name": "Plex Media Server (casaos plex)",
                        "supported_features": 16
                    },
                    "c": "01HV3B1QSGGG46EC80FM5GVAZJ",
                    "lc": 1712730464.048089
                },
                "media_player.deep_dungeon": {
                    "s": "off",
                    "a": {
                        "friendly_name": "Deep Dungeon TV",
                        "supported_features": 152449
                    },
                    "c": "01HV3B1R1DXSFT49GPDZMHJRM5",
                    "lc": 1712730464.301416
                },
                "sensor.philips_purifier_air_quality_index": {
                    "s": "4",
                    "a": {
                        "state_class": "measurement",
                        "device_class": "aqi",
                        "icon": "mdi:blur",
                        "friendly_name": "philips purifier Air Quality Index"
                    },
                    "c": "01HV3B31QJG561S9JSTFDSH9NJ",
                    "lc": 1712730506.994219
                },
                "sensor.philips_purifier_indoor_allergen_index": {
                    "s": "2",
                    "a": {
                        "state_class": "measurement",
                        "icon": "pap:iai",
                        "friendly_name": "philips purifier Indoor Allergen Index"
                    },
                    "c": "01HV465FVFCDW7E1C9Q1WJD0XJ",
                    "lc": 1712758898.543738
                },
                "sensor.philips_purifier_pm2_5": {
                    "s": "7",
                    "a": {
                        "state_class": "measurement",
                        "unit_of_measurement": "µg/m³",
                        "device_class": "pm25",
                        "icon": "pap:pm25",
                        "friendly_name": "philips purifier Pm2.5"
                    },
                    "c": "01HV466FDZX6R3MVXB7915HVBJ",
                    "lc": 1712758930.879509
                },
                "sensor.philips_purifier_humidity": {
                    "s": "74",
                    "a": {
                        "state_class": "measurement",
                        "unit_of_measurement": "%",
                        "device_class": "humidity",
                        "icon": "mdi:water-percent",
                        "friendly_name": "philips purifier Humidity"
                    },
                    "c": "01HV465ARQ9JTT0VYMAEXVNY06",
                    "lc": 1712758893.335512
                },
                "sensor.philips_purifier_temperature": {
                    "s": "23",
                    "a": {
                        "state_class": "measurement",
                        "unit_of_measurement": "°C",
                        "device_class": "temperature",
                        "icon": "mdi:thermometer-high",
                        "friendly_name": "philips purifier Temperature"
                    },
                    "c": "01HV44W7JVXWZF0GKW9G8SJ7S6",
                    "lc": 1712757546.587159
                },
                "sensor.philips_purifier_water_level": {
                    "s": "0",
                    "a": {
                        "state_class": "measurement",
                        "unit_of_measurement": "%",
                        "icon": "pap:water_refill",
                        "friendly_name": "philips purifier Water Level"
                    },
                    "c": "01HV3B31QJ241WEADN0CSAVAXN",
                    "lc": 1712730506.994976
                },
                "sensor.philips_purifier_rssi": {
                    "s": "-33",
                    "a": {
                        "state_class": "measurement",
                        "unit_of_measurement": "dBm",
                        "device_class": "signal_strength",
                        "icon": "mdi:wifi-strength-3",
                        "friendly_name": "philips purifier Rssi"
                    },
                    "c": "01HV466FDZ6305N703N2GTZ96G",
                    "lc": 1712758930.879613
                },
                "sensor.philips_purifier_pre_filter": {
                    "s": "192",
                    "a": {
                        "unit_of_measurement": "h",
                        "icon": "mdi:dots-grid",
                        "friendly_name": "philips purifier Pre Filter"
                    },
                    "c": "01HV464W0YQDHMEA1XPX4TD5VW",
                    "lc": 1712758878.238814
                },
                "sensor.philips_purifier_hepa_filter": {
                    "s": "2094",
                    "a": {
                        "type": "A3",
                        "unit_of_measurement": "h",
                        "icon": "mdi:dots-grid",
                        "friendly_name": "philips purifier Hepa Filter"
                    },
                    "c": "01HV464W0Y0BR15A0RCEH6KGMY",
                    "lc": 1712758878.238909
                },
                "sensor.philips_purifier_active_carbon_filter": {
                    "s": "2094",
                    "a": {
                        "type": "C7",
                        "unit_of_measurement": "h",
                        "icon": "mdi:dots-grid",
                        "friendly_name": "philips purifier Active Carbon Filter"
                    },
                    "c": "01HV464W0Y7FKM48DZXPAX103V",
                    "lc": 1712758878.238947
                },
                "sensor.philips_purifier_wick": {
                    "s": "2094",
                    "a": {
                        "unit_of_measurement": "h",
                        "icon": "mdi:dots-grid",
                        "friendly_name": "philips purifier Wick"
                    },
                    "c": "01HV464W0Y7NJSFDS63YXSE8AK",
                    "lc": 1712758878.238979
                },
                "fan.philips_purifier": {
                    "s": "on",
                    "a": {
                        "preset_modes": [
                            "auto",
                            "allergen",
                            "night",
                            "speed 1",
                            "speed 2",
                            "speed 3",
                            "turbo"
                        ],
                        "percentage": null,
                        "percentage_step": 20.0,
                        "preset_mode": "auto",
                        "name": "Living Room",
                        "type": "AC2729",
                        "model_id": "AC2729/10",
                        "product_id": "85bc26fae62611e8a1e3061302926720",
                        "device_id": "5481a560d49e11ed8cf93fd097c4fc9b",
                        "software_version": "0.3.4",
                        "wifi_version": "AWS_Philips_AIR@77",
                        "error_code": 49408,
                        "error": "no water",
                        "preferred_index": "PM2.5",
                        "runtime": "1 day, 23:56:34",
                        "icon": "pap:auto_mode",
                        "friendly_name": "philips purifier",
                        "supported_features": 9
                    },
                    "c": "01HV466FDZAWJ9WSJMPY4MR3QS",
                    "lc": 1712733450.664517,
                    "lu": 1712758930.879802
                },
                "select.philips_purifier_function": {
                    "s": "Purification",
                    "a": {
                        "options": [
                            "Purification",
                            "Purification and Humidification"
                        ],
                        "icon": "pap:purification_only_mode",
                        "friendly_name": "philips purifier Function"
                    },
                    "c": "01HV3B31R04XWHKP2AJZQRR817",
                    "lc": 1712730507.008703
                },
                "select.philips_purifier_humidity_target": {
                    "s": "50%",
                    "a": {
                        "options": [
                            "40%",
                            "50%",
                            "60%",
                            "max"
                        ],
                        "icon": "pap:humidity_button",
                        "friendly_name": "philips purifier Humidity Target"
                    },
                    "c": "01HV3B31R0RSX0G8XY1EQPRR00",
                    "lc": 1712730507.00882
                },
                "select.philips_purifier_preferred_index": {
                    "s": "PM2.5",
                    "a": {
                        "options": [
                            "Indoor Allergen Index",
                            "PM2.5"
                        ],
                        "icon": "pap:pm25",
                        "friendly_name": "philips purifier Preferred Index"
                    },
                    "c": "01HV3B31R090P81WF6C9PW0T34",
                    "lc": 1712730507.00893
                },
                "light.philips_purifier_display_backlight": {
                    "s": "on",
                    "a": {
                        "supported_color_modes": [
                            "onoff"
                        ],
                        "color_mode": "onoff",
                        "icon": "pap:light_dimming_button",
                        "friendly_name": "philips purifier Display Backlight",
                        "supported_features": 0
                    },
                    "c": "01HV3B31R19HQPH8YP18XSJCAZ",
                    "lc": 1712730507.009241
                },
                "light.philips_purifier_light_brightness": {
                    "s": "on",
                    "a": {
                        "supported_color_modes": [
                            "brightness"
                        ],
                        "color_mode": "brightness",
                        "brightness": 255,
                        "icon": "mdi:circle-outline",
                        "friendly_name": "philips purifier Light Brightness",
                        "supported_features": 0
                    },
                    "c": "01HV3B31R1PJ8WJV11G7AE45CG",
                    "lc": 1712730507.009381
                },
                "switch.philips_purifier_child_lock": {
                    "s": "off",
                    "a": {
                        "icon": "pap:child_lock_button",
                        "friendly_name": "philips purifier Child Lock"
                    },
                    "c": "01HV3B31R18QQJTA70KTW4JG39",
                    "lc": 1712730507.009649
                },
                "media_player.plex_plex_for_ios_iphone": {
                    "s": "unavailable",
                    "a": {
                        "restored": true,
                        "friendly_name": "Plex (Plex for iOS - iPhone)",
                        "supported_features": 131584
                    },
                    "c": "01HV3B31R2CXV8P961E8W3JCZC",
                    "lc": 1712730507.010314
                },
                "media_player.plex_plex_for_android_tv_chromecast_google_tv": {
                    "s": "unavailable",
                    "a": {
                        "restored": true,
                        "friendly_name": "Plex (Plex for Android (TV) - Chromecast Google TV)",
                        "supported_features": 131584
                    },
                    "c": "01HV3B31R2EZHK5A35KB65XTE1",
                    "lc": 1712730507.010339
                },
                "media_player.plex_plex_web_safari_osx_2": {
                    "s": "unavailable",
                    "a": {
                        "restored": true,
                        "friendly_name": "Plex (Plex Web - Safari - OSX)",
                        "supported_features": 131584
                    },
                    "c": "01HV3B31R21D75FFMD9PGMNER0",
                    "lc": 1712730507.010355
                },
                "media_player.plex_infuse_mac": {
                    "s": "unavailable",
                    "a": {
                        "restored": true,
                        "friendly_name": "Plex (Infuse - Mac)",
                        "supported_features": 131584
                    },
                    "c": "01HV3B31R25XAYKQ41ED4QT84F",
                    "lc": 1712730507.010369
                },
                "media_player.plex_plex_for_ios_ipad": {
                    "s": "unavailable",
                    "a": {
                        "restored": true,
                        "friendly_name": "Plex (Plex for iOS - iPad)",
                        "supported_features": 131584
                    },
                    "c": "01HV3B31R2VS7V3YCNBA86H3AJ",
                    "lc": 1712730507.010383
                }
            }
}
''';

const String jsonRaw2 = '''
{
        "c": {
            "sensor.philips_purifier_pm2_5": {
                "+": {
                    "s": "5",
                    "lc": 1712824673.228867,
                    "c": "01HV64WRYCV0V1QQT55KXT9QF7"
                }
            }
        }
    }
''';

void main() {
  test("Desrialize big amout of data and not crash", () {
    final json = jsonDecode(jsonRaw);
    final state = StatesUpdates.fromJson(json);
  });

  test("Deserialize updates - added", () {
    final json = jsonDecode(jsonRaw2);
    final state = StatesUpdates.fromJson(json);

    expect(state.change?.containsKey("sensor.philips_purifier_pm2_5"), isTrue);
    expect(state.change!["sensor.philips_purifier_pm2_5"]?.remove, isNull);
    expect(state.change!["sensor.philips_purifier_pm2_5"]?.add, isNotNull);
  });
}
