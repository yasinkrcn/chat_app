import 'package:chat_app/core/_core_exports.dart';
import 'package:chat_app/feature/bottom_nav_bar/domain/entities/bottom_navigation_bar_state.dart';

class CustomBottomNavigationBarItem extends StatelessWidget {
  final Function() onTap;
  final bool isActive;
  final BottomNavigationBarState barState;

  const CustomBottomNavigationBarItem({
    Key? key,
    required this.onTap,
    this.isActive = false,
    required this.barState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        highlightColor: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: isActive ? Colors.white : Colors.transparent,
                width: 3,
              ),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                barState.stateToAssetPath(),
                height: barState.stateToAssetPathSize(),
                color: isActive ? Colors.white : Colors.black54,
              ),
              if (isActive) ...[
                AppText(
                  barState.stateToTitle(),
                  style: TextStyle(
                    fontSize: 14.h,
                    color: isActive ? barState.stateToActiveColor() : AppColors.black,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ]
            ],
          ),
        ),
      ),
    );
  }
}
