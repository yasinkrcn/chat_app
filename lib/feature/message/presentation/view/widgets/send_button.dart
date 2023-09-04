import '../../../../../core/_core_exports.dart';

class SendButtonWidget extends StatelessWidget {
  void Function()? onTap;
  SendButtonWidget({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Container(
          height: 48,
          width: 48,
          alignment: Alignment.center,
          decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.primaryColor),
          child: const Icon(
            Icons.send_rounded,
            size: 30,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
