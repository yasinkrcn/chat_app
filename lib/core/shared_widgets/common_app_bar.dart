import '../_core_exports.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? actions;
  final String? title;

  const CommonAppBar({Key? key, this.actions, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 4,
      title: AppText(
        title ?? "",
        style: const TextStyle(color: Colors.black, fontSize: 24),
      ),
      centerTitle: true,
      iconTheme: const IconThemeData(color: AppColors.black),
      actions: [
        if (actions != null) actions!,
        AppSizedBox.w(10.w),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
