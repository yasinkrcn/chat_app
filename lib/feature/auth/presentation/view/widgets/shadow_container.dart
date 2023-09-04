import 'package:chat_app/core/_core_exports.dart';

class ShadowContainer extends StatelessWidget {
  final Widget child;
  const ShadowContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 4,
            blurRadius: 4,
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 24.w),
        child: child,
      ),
    );
  }
}
