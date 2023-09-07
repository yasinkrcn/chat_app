import '../_core_exports.dart';

class AppScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final Widget? bottomSheet;
  final Color? backgroundColor;
  final Drawer? drawer;

  final FloatingActionButtonLocation? floatingActionButtonLocation;

  const AppScaffold({
    Key? key,
    this.appBar,
    this.backgroundColor = Colors.white,
    this.body,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.bottomSheet,
    this.drawer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        color: backgroundColor,
        padding: EdgeInsets.only(
          bottom: ScreenSize().bottomMargin,
        ),
        child: Scaffold(
          backgroundColor: backgroundColor,
          appBar: appBar ??
              AppBar(
                toolbarHeight: 0,
                backgroundColor: backgroundColor,
                elevation: 0,
              ),
          body: body,
          drawer: drawer,
          bottomNavigationBar: bottomNavigationBar,
          floatingActionButton: floatingActionButton,
          floatingActionButtonLocation: floatingActionButtonLocation ?? FloatingActionButtonLocation.miniCenterFloat,
          bottomSheet: bottomSheet,
        ),
      ),
    );
  }
}
