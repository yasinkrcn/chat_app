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
      const Duration(seconds: 0),
      () {
        if (FirebaseAuth.instance.currentUser != null) {
          Go.to.page(PageRoutes.messagePage);
        } else {
          Go.to.page(PageRoutes.loginPage);
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 102,
            width: 102,
            color: Colors.redAccent,
          ),
          const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
        ],
      ),
    );
  }
}
