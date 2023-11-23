import 'package:tickets/exports/exports.dart';

class NotificationService {
  NotificationService._();

  static final NotificationService instance = NotificationService._();

  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
    "high_importance_channel",
    "High Importance Notifications",
    description: "This channel is used for important notifications",
    importance: Importance.high,
    playSound: true,
  );

  Future<void> initializeNotificationPlugin(
    WidgetRef ref,
  ) async {
    final plugin = ref.read(localNotificationsPluginProvider);
    const initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    );
    await plugin.initialize(initializationSettings);
  }

  Future<void> pushNotification(
    WidgetRef ref,
    String title,
    String body,
  ) async {
    final plugin = ref.read(localNotificationsPluginProvider);
    final notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        channel.id,
        channel.name,
        importance: Importance.max,
        priority: Priority.high,
      ),
    );
    Future.delayed(
      const Duration(minutes: 1),
      () async => await plugin.show(
        title.hashCode,
        title,
        body,
        notificationDetails,
      ),
    );
  }
}
