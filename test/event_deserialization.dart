import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:hommie/services/networking/home_assitant_websocket/web_socket_response.dart';

//Unhandled Exception: type '_Map<String, dynamic>' is not a subtype of type 'String' in type cast
const String jsonRaw = '''
 {
        "id": 3,
        "type": "event",
        "event": {
            "a": {
                "person.seftoner": {
                    "s": "not_home",
                    "a": {
                        "editable": true,
                        "id": "seftoner",
                        "latitude": 48.9295654296875,
                        "longitude": 24.708282754938345,
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
                        "release_summary": "# Changelog  ## 9.10.0  - Upgrade Home Assistant CLI to 4.31.0  ## 9.9.0  - Upgrade to Alpine Linux 3.19 - Upgrade Home Assistant CLI to 4.29.0 - Upgrade libwebsockets to 4.3.3 - Upgrade ttyd to 1.7.4  #",
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
                        "release_summary": "## What’s changed  ## ⬆️ Dependency updates  - ⬆️ Update philippe44/AirConnect to v1.8.3 @renovate ([#204](https://github.com/hassio-addons/addon-aircast/pull/204)) - ⬆️ Update ghcr.io/hassio-addons/debian-base Docker tag to v7.3.3 @renovate ([#202](https",
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
                        "release_summary": "## What’s changed  ## ⬆️ Dependency updates  - ⬆️ Update alpine_3_19/networkmanager-common to v1.44.4-r0 @renovate ([#339](https://github.com/hassio-addons/addon-tailscale/pull/339)) - ⬆️ Update tailscale/tailscale to v1.62.1 @renovate ([#340](https://git",
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
                        "next_dawn": "2024-04-12T03:03:22.664102+00:00",
                        "next_dusk": "2024-04-11T17:41:18.498972+00:00",
                        "next_midnight": "2024-04-11T22:22:35+00:00",
                        "next_noon": "2024-04-11T10:22:56+00:00",
                        "next_rising": "2024-04-12T03:36:51.016074+00:00",
                        "next_setting": "2024-04-11T17:07:46.945928+00:00",
                        "elevation": 49.03,
                        "azimuth": 165.42,
                        "rising": true,
                        "friendly_name": "Sun"
                    },
                    "c": "01HV68PJBRFV26AMAJE3N0E951",
                    "lc": 1712806648.858579,
                    "lu": 1712828664.184506
                },
                "zone.home": {
                    "s": "0",
                    "a": {
                        "latitude": 48.7481718,
                        "longitude": 24.5207477,
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
                    "s": "2024-04-12T03:03:22+00:00",
                    "a": {
                        "device_class": "timestamp",
                        "icon": "mdi:sun-clock",
                        "friendly_name": "Sun Next dawn"
                    },
                    "c": "01HV5HW40HQS14WY7KC6V1FTB1",
                    "lc": 1712804728.849679
                },
                "sensor.sun_next_dusk": {
                    "s": "2024-04-11T17:41:18+00:00",
                    "a": {
                        "device_class": "timestamp",
                        "icon": "mdi:sun-clock",
                        "friendly_name": "Sun Next dusk"
                    },
                    "c": "01HV4HG5VC545TN8VG11299BV2",
                    "lc": 1712770783.084603
                },
                "sensor.sun_next_midnight": {
                    "s": "2024-04-11T22:22:35+00:00",
                    "a": {
                        "device_class": "timestamp",
                        "icon": "mdi:sun-clock",
                        "friendly_name": "Sun Next midnight"
                    },
                    "c": "01HV51PKKS4JFW2GEVY4N4QH74",
                    "lc": 1712787771.001922
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
                    "s": "2024-04-12T03:36:51+00:00",
                    "a": {
                        "device_class": "timestamp",
                        "icon": "mdi:sun-clock",
                        "friendly_name": "Sun Next rising"
                    },
                    "c": "01HV5KS74WQV90MBHKQEV7JZDN",
                    "lc": 1712806730.908706
                },
                "sensor.sun_next_setting": {
                    "s": "2024-04-11T17:07:46+00:00",
                    "a": {
                        "device_class": "timestamp",
                        "icon": "mdi:sun-clock",
                        "friendly_name": "Sun Next setting"
                    },
                    "c": "01HV4FJZGWKCKTB3JAK5YNN440",
                    "lc": 1712768777.756116
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
                    "s": "cloudy",
                    "a": {
                        "temperature": 16.0,
                        "dew_point": 10.5,
                        "temperature_unit": "°C",
                        "humidity": 70,
                        "cloud_coverage": 89.1,
                        "pressure": 1031.0,
                        "pressure_unit": "hPa",
                        "wind_bearing": 307.5,
                        "wind_speed": 9.4,
                        "wind_speed_unit": "km/h",
                        "visibility_unit": "km",
                        "precipitation_unit": "mm",
                        "forecast": [
                            {
                                "condition": "partlycloudy",
                                "datetime": "2024-04-11T09:00:00+00:00",
                                "wind_bearing": 337.5,
                                "temperature": 19.4,
                                "templow": 16.0,
                                "wind_speed": 10.1,
                                "precipitation": 0.0,
                                "humidity": 67
                            },
                            {
                                "condition": "cloudy",
                                "datetime": "2024-04-12T09:00:00+00:00",
                                "wind_bearing": 340.5,
                                "temperature": 20.3,
                                "templow": 14.1,
                                "wind_speed": 13.0,
                                "precipitation": 0.2,
                                "humidity": 62
                            },
                            {
                                "condition": "cloudy",
                                "datetime": "2024-04-13T09:00:00+00:00",
                                "wind_bearing": 305.7,
                                "temperature": 21.4,
                                "templow": 10.9,
                                "wind_speed": 24.8,
                                "precipitation": 0.0,
                                "humidity": 56
                            },
                            {
                                "condition": "cloudy",
                                "datetime": "2024-04-14T09:00:00+00:00",
                                "wind_bearing": 245.9,
                                "temperature": 24.8,
                                "templow": 15.0,
                                "wind_speed": 27.0,
                                "precipitation": 0.0,
                                "humidity": 44
                            },
                            {
                                "condition": "rainy",
                                "datetime": "2024-04-15T09:00:00+00:00",
                                "wind_bearing": 127.1,
                                "temperature": 17.4,
                                "templow": 14.7,
                                "wind_speed": 11.9,
                                "precipitation": 6.0,
                                "humidity": 72
                            },
                            {
                                "condition": "rainy",
                                "datetime": "2024-04-16T09:00:00+00:00",
                                "wind_bearing": 313.8,
                                "temperature": 18.2,
                                "templow": 13.0,
                                "wind_speed": 14.0,
                                "precipitation": 3.3,
                                "humidity": 57
                            }
                        ],
                        "attribution": "Weather forecast from met.no, delivered by the Norwegian Meteorological Institute.",
                        "friendly_name": "Forecast Home",
                        "supported_features": 3
                    },
                    "c": "01HV66A8XHK8ES2MGNJ1S0PJR6",
                    "lc": 1712826164.145629
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
                        "latitude": 48.9295654296875,
                        "longitude": 24.708282754938345,
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
                    "c": "01HV5MDDX3Q0ZMBGAK0M5JV7T5",
                    "lc": 1712807393.187419
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
                    "s": "32.1849053739901",
                    "a": {
                        "state_class": "measurement",
                        "unit_of_measurement": "KiB/s",
                        "device_class": "data_rate",
                        "icon": "mdi:server-network",
                        "friendly_name": "Archer C80 AC1900 MU-MIMO Wi-Fi Router Download speed"
                    },
                    "c": "01HV68WNND4BE51WE4T4PMCKHB",
                    "lc": 1712828864.173219
                },
                "sensor.archer_c80_ac1900_mu_mimo_wi_fi_router_upload_speed": {
                    "s": "68.6350330497443",
                    "a": {
                        "state_class": "measurement",
                        "unit_of_measurement": "KiB/s",
                        "device_class": "data_rate",
                        "icon": "mdi:server-network",
                        "friendly_name": "Archer C80 AC1900 MU-MIMO Wi-Fi Router Upload speed"
                    },
                    "c": "01HV68WNNDNSVSMVTNFAWQ0WN4",
                    "lc": 1712828864.173282
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
                    "s": "1",
                    "a": {
                        "state_class": "measurement",
                        "icon": "pap:iai",
                        "friendly_name": "philips purifier Indoor Allergen Index"
                    },
                    "c": "01HV68TAZ3EEYTAM03NB8209HH",
                    "lc": 1712828787.68317
                },
                "sensor.philips_purifier_pm2_5": {
                    "s": "2",
                    "a": {
                        "state_class": "measurement",
                        "unit_of_measurement": "µg/m³",
                        "device_class": "pm25",
                        "icon": "pap:pm25",
                        "friendly_name": "philips purifier Pm2.5"
                    },
                    "c": "01HV68W74CS6SAB1RWRJMH89Z4",
                    "lc": 1712828849.29243
                },
                "sensor.philips_purifier_humidity": {
                    "s": "70",
                    "a": {
                        "state_class": "measurement",
                        "unit_of_measurement": "%",
                        "device_class": "humidity",
                        "icon": "mdi:water-percent",
                        "friendly_name": "philips purifier Humidity"
                    },
                    "c": "01HV68G8TAJ8713QCD4ZCBYYB0",
                    "lc": 1712828457.802262
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
                    "c": "01HV65JNFWWBKYDBCVE157H3K7",
                    "lc": 1712825390.588389
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
                    "s": "-34",
                    "a": {
                        "state_class": "measurement",
                        "unit_of_measurement": "dBm",
                        "device_class": "signal_strength",
                        "icon": "mdi:wifi-strength-3",
                        "friendly_name": "philips purifier Rssi"
                    },
                    "c": "01HV68TAZ33JQKHAVNVPQQJZ21",
                    "lc": 1712828787.683295
                },
                "sensor.philips_purifier_pre_filter": {
                    "s": "183",
                    "a": {
                        "unit_of_measurement": "h",
                        "icon": "mdi:dots-grid",
                        "friendly_name": "philips purifier Pre Filter"
                    },
                    "c": "01HV67C10Y5FN6X3T7F0MTRW4D",
                    "lc": 1712827270.174786
                },
                "sensor.philips_purifier_hepa_filter": {
                    "s": "2085",
                    "a": {
                        "type": "A3",
                        "unit_of_measurement": "h",
                        "icon": "mdi:dots-grid",
                        "friendly_name": "philips purifier Hepa Filter"
                    },
                    "c": "01HV67C10YX47CAR9DRWVC4W05",
                    "lc": 1712827270.17485
                },
                "sensor.philips_purifier_active_carbon_filter": {
                    "s": "2085",
                    "a": {
                        "type": "C7",
                        "unit_of_measurement": "h",
                        "icon": "mdi:dots-grid",
                        "friendly_name": "philips purifier Active Carbon Filter"
                    },
                    "c": "01HV67C10YTG5655PSNNZHCDV8",
                    "lc": 1712827270.174881
                },
                "sensor.philips_purifier_wick": {
                    "s": "2085",
                    "a": {
                        "unit_of_measurement": "h",
                        "icon": "mdi:dots-grid",
                        "friendly_name": "philips purifier Wick"
                    },
                    "c": "01HV67C10YDD3T42MKBCFZFKQF",
                    "lc": 1712827270.174909
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
                        "runtime": "2 days, 19:49:50",
                        "icon": "pap:auto_mode",
                        "friendly_name": "philips purifier",
                        "supported_features": 9
                    },
                    "c": "01HV68W74CG9K5BXP59N1KX6ZT",
                    "lc": 1712814706.073674,
                    "lu": 1712828849.292704
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
                    "c": {
                        "id": "01HV5YZ2JZ5THE8Q4JBTMBN44R",
                        "parent_id": null,
                        "user_id": "cc4e3e7bd8304aa48c316a47f9a8bb66"
                    },
                    "lc": 1712818457.285329
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
    }
''';

//Unhandled Exception: type 'Null' is not a subtype of type 'String' in type cast
const String jsonRaw2 = '''
{"type":"event","event":{"c":{"fan.philips_purifier":{"+":{"lu":1712828878.514165,"c":"01HV68X3NJDK579CYJNST1VA72","a":{"runtime":"2 days, 19:50:20"}}}}},"id":3}
''';

void main() {
  test("Event deserialization", () {
    final json = jsonDecode(jsonRaw);
    final reponse = WebSocketResponse.fromJson(json);
    final state =
        reponse.maybeWhen(event: (i, state) => state, orElse: () => null)!;

    expect(
        state.add
            ?.containsKey("binary_sensor.ivano_frankivska_oblast_artillery"),
        isTrue);
  });

  test("Event deserialization 2", () {
    final json = jsonDecode(jsonRaw2);
    final reponse = WebSocketResponse.fromJson(json);
    final state = reponse.maybeWhen(event: (i, s) => s, orElse: () => null)!;

    expect(state.change!["fan.philips_purifier"]?.remove, isNull);
    expect(state.change!["fan.philips_purifier"]?.add, isNotNull);
    expect(state.change!["fan.philips_purifier"]?.add?.state, isNull);
  });
}
