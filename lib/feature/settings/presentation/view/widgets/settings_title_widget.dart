import 'package:chat_app/core/_core_exports.dart';

class SettingsTitleWidget extends StatelessWidget {
  final String title;
  final IconData? icon;
  final bool isIconAvailable;
  final void Function()? onTap;
  final bool isBorderAvailable;
  final Color? textColor;

  const SettingsTitleWidget({
    super.key,
    required this.title,
    this.icon,
    this.isIconAvailable = true,
    this.onTap,
    this.isBorderAvailable = true,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 56.h,
        width: double.infinity,
        decoration: BoxDecoration(
            border: isBorderAvailable
                ? const Border(
                    bottom: BorderSide(
                      color: Colors.black12,
                    ),
                  )
                : null),
        child: Row(
          children: [
            AppText(
              title,
              style: AppTextStyles.medium18W500.copyWith(color: textColor ?? AppColors.black.withOpacity(.7)),
            ),
            const Spacer(),
            isIconAvailable
                ? Icon(
                    icon ?? Icons.keyboard_arrow_right_rounded,
                    size: 36,
                    color: AppColors.primaryColor,
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
