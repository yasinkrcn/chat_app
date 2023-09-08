import 'package:chat_app/core/_core_exports.dart';

class StoryCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final double size;
  final bool isMe;
  final void Function()? onTap;
  const StoryCard({
    super.key,
    required this.imageUrl,
    required this.name,
    this.size = 84,
    this.isMe = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size + 4,
      width: size,
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: onTap,
                child: Container(
                  height: size,
                  width: size,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: AppGradients.instagramGradient,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(imageUrl))),
                    ),
                  ),
                ),
              ),
              AppText(
                name,
                style: AppTextStyles.medium15W500,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          if (isMe) ...[
            Positioned(
              right: 0,
              bottom: 24,
              child: Container(
                alignment: Alignment.center,
                height: 24,
                width: 24,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppGradients.instagramGradient,
                ),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ],
      ),
    );
  }
}
