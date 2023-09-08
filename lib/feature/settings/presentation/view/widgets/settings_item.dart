import 'package:chat_app/core/_core_exports.dart';

class SettingsItem extends StatelessWidget {
  final String text;
  final Color color;

  final void Function()? onTap;
  const SettingsItem({
    super.key,
    required this.text,
    this.onTap,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade300))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText(
              text,
              style: AppTextStyles.medium16W500.copyWith(color: color),
            ),
            Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey.shade500)
          ],
        ),
      ),
    );
  }
}
