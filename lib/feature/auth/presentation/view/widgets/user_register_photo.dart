import 'dart:io';
import 'package:chat_app/core/_core_exports.dart';

// ignore: must_be_immutable
class UserRegistrationAddPhotoWidget extends StatelessWidget {
  dynamic viewModel;
  bool? isUpdate = false;

  final String? imageUrl;

  UserRegistrationAddPhotoWidget({
    Key? key,
    this.viewModel,
    this.isUpdate,
    this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () {
          viewModel.getImage();
        },
        child: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              height: 140.w,
              width: 140.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primaryColor,
                  width: 1.5,
                ),
              ),
              child: viewModel == null
                  ? null
                  : viewModel.imageFile == null
                      ? isUpdate!
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(100.r),
                              child: SizedBox(
                                  height: 140.w,
                                  width: 140.w,
                                  child: CachedNetworkImage(
                                      fit: BoxFit.cover, imageUrl: imageUrl ?? viewModel.selectedUser.data!.userImage)),
                            )
                          : Icon(
                              Icons.add_a_photo,
                              color: AppColors.primaryColor,
                              size: 32.w,
                            )
                      : SizedBox(
                          height: 140.w,
                          width: 140.w,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100.r),
                            child: Image.file(
                              File(viewModel.imageFile!.path),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
            ),
            if (viewModel != null) ...[
              Visibility(
                visible: viewModel.imageFile != null,
                child: Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      viewModel.removeImage();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 40.w,
                      width: 40.w,
                      decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.red),
                      child: Icon(
                        Icons.cancel_rounded,
                        size: 40.w,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ],
        ),
      ),
    );
  }
}
