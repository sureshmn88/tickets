import 'package:tickets/exports/exports.dart';

final pickedFilePathProvider = StateProvider<FilePickerResult?>((ref) => null);

final pickedFileNameProvider = StateProvider<String>((ref) => "Choose");

final locationProvider = StateProvider<String?>((ref) => "");

final errorProvider = StateProvider<String>((ref) => "");

final localNotificationsPluginProvider =
    Provider<FlutterLocalNotificationsPlugin>((ref) {
  return FlutterLocalNotificationsPlugin();
});
