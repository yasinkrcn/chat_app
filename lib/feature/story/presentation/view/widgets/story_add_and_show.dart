import 'dart:io';

import 'package:chat_app/core/_core_exports.dart';
import 'package:chat_app/feature/story/presentation/view_model/story_view_model.dart';

class StoryAddAndShow extends StatefulWidget {
  File? imageFile;

  StoryAddAndShow({
    Key? key,
    required this.imageFile,
  }) : super(key: key);

  @override
  State<StoryAddAndShow> createState() => _StoryAddAndShowState();
}

class _StoryAddAndShowState extends State<StoryAddAndShow> {
  Future<void> getImage() async {
    ImagePicker picker = ImagePicker();

    await picker.pickImage(source: ImageSource.gallery).then((xFile) {
      if (xFile != null) {
        setState(() {
          widget.imageFile = File(xFile.path);

          print(widget.imageFile?.path);
          print(sl<StoryViewModel>().imageFile?.path);
        });
      }
    });
  }

  void removeImage() async {
    if (widget.imageFile != null) {
      // Cihazdan dosyayı sil
      await widget.imageFile!.delete();
      setState(() {
        widget.imageFile = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.imageFile == null
        ? GestureDetector(
            onTap: () {
              getImage();
            },
            child: Container(
              color: Colors.transparent,
              height: double.infinity,
              width: double.infinity,
              child: const Icon(
                Icons.add_a_photo,
                color: Colors.red,
                size: 72.0,
              ),
            ),
          )
        : Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Image.file(
                  File(widget.imageFile!.path),
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    removeImage();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 3),
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.red,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.delete_outline_rounded,
                        size: 40.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
  }
}
