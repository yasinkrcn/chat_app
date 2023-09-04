import '../../../../../core/_core_exports.dart';

class ChatPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatPageAppBar({
    super.key,
    required this.userData,
  });

  final UserModel userData;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        elevation: 0,
        leading: GestureDetector(onTap: () => Go.to.back(), child: const Icon(Icons.arrow_back_ios_new)),
        title: InkWell(
          onTap: () => Go.to.page(PageRoutes.contactDetailsPage, arguments: userData),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipOval(
                child: SizedBox(
                  height: 36,
                  width: 36,
                  child: CachedNetworkImage(fit: BoxFit.cover, imageUrl: userData.userImage!),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                children: [
                  AppText(
                    userData.name!,
                  ),
                ],
              ),
              const SizedBox(
                width: 8,
              ),
            ],
          ),
        ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(55);
}
