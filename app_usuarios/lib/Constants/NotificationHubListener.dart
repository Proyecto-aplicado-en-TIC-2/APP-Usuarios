import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  messaging.subscribeToTopic("emergencias"); // Tema para alertas globales
}
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

void configurarNotificacionDeEmergencia() {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (message.notification != null) {
      mostrarNotificacionDeEmergencia(
        message.notification!.title!,
        message.notification!.body!,
      );
    }
  });
}

Future<void> mostrarNotificacionDeEmergencia(String titulo, String mensaje) async {
  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'emergencia_channel',
    'Emergencias',
    importance: Importance.max,
    priority: Priority.high,
    color: Colors.red,
    playSound: true,
    fullScreenIntent: true,
    styleInformation: BigTextStyleInformation(''),
  );

  const NotificationDetails platformChannelSpecifics =
  NotificationDetails(android: androidDetails);

  await flutterLocalNotificationsPlugin.show(
    0,
    titulo,
    mensaje,
    platformChannelSpecifics,
  );
}