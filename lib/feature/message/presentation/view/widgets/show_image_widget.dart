import 'package:chat_app/core/_core_exports.dart';

class ShowImage extends StatelessWidget {
  final String imageUrl;

  const ShowImage({required this.imageUrl, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Center(
              child: Container(
                  color: Colors.black,
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    placeholder: (context, url) {
                      return const Center(child: CircularProgressIndicator.adaptive());
                    },
                    errorWidget: (context, url, error) {
                      return const Icon(Icons.error);
                    },
                    fit: BoxFit.cover,
                  )),
            ),
            Container(
              alignment: Alignment.center,
              height: 64.h,
              width: double.infinity,
              color: Colors.black38,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: InkWell(
                      onTap: () => Go.to.back(),
                      child: Icon(
                        Icons.close,
                        size: 42.h,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
