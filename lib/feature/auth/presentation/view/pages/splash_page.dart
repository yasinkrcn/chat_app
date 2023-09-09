import 'dart:async';

import 'package:chat_app/core/_core_exports.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    Timer(
      const Duration(seconds: 3),
      () {
        if (FirebaseAuth.instance.currentUser != null) {
          Go.to.pageAndRemoveUntil(PageRoutes.bottomNavigationPage);
        } else {
          Go.to.pageAndRemoveUntil(PageRoutes.loginPage);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);

    return AppScaffold(
      backgroundColor: AppColors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ScreenSize().getWidthPercent(.2)),
            child: Image.asset(AssetPaths().appIcon),
          ),
          const CircularProgressIndicator.adaptive(),
        ],
      ),
    );
  }
}
