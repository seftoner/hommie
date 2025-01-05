enum SensorType {
  binarySensor('binary_sensor'),
  sensor('sensor');

  final String type;

  const SensorType(this.type);

  @override
  String toString() => type;
}

abstract class Sensor {
  ///An identifier unique to this installation of your app.
  ///You'll need this later.
  ///Usually best when its a safe version of the sensor name
  ///This is required.
  String uniqueId;

  ///The name of the sensor
  String name;

  ///The state of the sensor
  dynamic state;

  ///The type of the sensor. Must be one of `binary_sensor` or `sensor`
  SensorType type = SensorType.sensor;

  ///The unit of measurement for the sensor. Example: '%', ''
  late String unitOfMeasurement;

  late String stateClass = 'measurement';

  ///Must be prefixed mdi:. If not provided, default value is `mdi:cellphone`
  late String icon;

  ///The entity category of the entity
  late dynamic entityCategory;

  ///Full list described here:
  ///https://www.home-assistant.io/integrations/sensor/#device-class
  late String deviceClass;

  ///If the entity should be enabled or disabled.
  bool isDisabled = true;

  ///Attributes to attach to the sensor
  late Map<String, dynamic> attributes;

  Sensor({required this.uniqueId, required this.name, this.state});
}
