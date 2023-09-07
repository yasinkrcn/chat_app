import 'package:chat_app/core/_core_exports.dart';
import 'package:chat_app/core/constants/app_constants.dart';
import 'package:chat_app/core/constants/main_provider_list.dart';
import 'package:chat_app/core/constants/theme/app_theme.dart';
import 'package:chat_app/core/init/injection_container.dart' as locator;
import 'package:chat_app/core/utils/awesome_notification_manager.dart';
import 'package:chat_app/core/utils/permission_manager.dart';
import 'package:chat_app/feature/auth/presentation/view/pages/login_page.dart';
import 'package:chat_app/feature/auth/presentation/view/pages/splash_page.dart';
import 'package:chat_app/feature/bottom_nav_bar/view/pages/bottom_navigation_page.dart';
import 'package:chat_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessagingService().initialize();

  NotificationManager().init();

  await PermissionManager().notificationPermission();

  await locator.init();

  runApp(
    MultiProvider(
      providers: MainProviderList.getMainProviderList(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants().appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.appThemeData,
      onGenerateRoute: generateRoute,
      navigatorKey: GlobalContextKey.instance.globalKey,
      home: BottomNavigationPage(),
    );
  }
}
