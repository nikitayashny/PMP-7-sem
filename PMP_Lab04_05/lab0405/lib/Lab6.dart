import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LightSensor {
  static const MethodChannel _channel = MethodChannel('com.example.light/sensor');

  static Future<Map<String, dynamic>?> getLightSensorData() async {
    try {
      final Map<dynamic, dynamic>? lightSensorInfo = await _channel.invokeMethod('getLightSensorData');
      return lightSensorInfo?.map((key, value) => MapEntry(key.toString(), value));
    } on PlatformException catch (e) {
      print("Не удалось получить данные с датчика света: '${e.message}'");
      return null;
    }
  }
}

class Battery {
  static const MethodChannel _channel = MethodChannel('com.example.battery/level');

  static Future<int?> getBatteryLevel() async {
    try {
      final int? batteryLevel = await _channel.invokeMethod('getBatteryLevel');
      return batteryLevel;
    } on PlatformException catch (e) {
      print("Не удалось получить уровень заряда батареи: '${e.message}'");
      return null;
    }
  }
}

class Email {
  static const MethodChannel _channel = MethodChannel('com.example.email/open');

  static Future<void> openEmail(String subject) async {
    try {
      await _channel.invokeMethod('openEmail', {'subject': subject});
    } on PlatformException catch (e) {
      print("Не удалось открыть почтовое приложение: '${e.message}'");
    }
  }
}

class Lab6 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lab 6")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                Map<String, dynamic>? lightSensorInfo = await LightSensor.getLightSensorData();
                if (lightSensorInfo != null && lightSensorInfo['error'] == null) {
                  print("Уровень света: ${lightSensorInfo['lightLevel']}");
                } else {
                  print("Ошибка: ${lightSensorInfo?['error'] ?? 'Неизвестная ошибка'}");
                }
              },
              child: Text("Получить данные с датчика света"),
            ),
            ElevatedButton(
              onPressed: () async {
                int? batteryLevel = await Battery.getBatteryLevel();
                if (batteryLevel != null) {
                  print("Уровень заряда батареи: $batteryLevel%");
                } else {
                  print("Не удалось получить уровень заряда батареи.");
                }
              },
              child: Text("Получить уровень заряда батареи"),
            ),
            ElevatedButton(
              onPressed: () async {
                await Email.openEmail("Тема вашего сообщения");
                print("Открыто почтовое приложение с темой сообщения");
              },
              child: Text("Открыть почтовое приложение"),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Lab6(),
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
  ));
}