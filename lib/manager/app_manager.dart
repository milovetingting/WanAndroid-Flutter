import 'package:event_bus/event_bus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppManager {
  static const String ACCOUNT = "accountName";
  static EventBus eventBus = EventBus();
  static SharedPreferences preferences;

  static initApp() async {
    preferences = await SharedPreferences.getInstance();
  }
}
