import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants/app_constants.dart';

class ImageUpoader extends ChangeNotifier {
  final ImagePicker _picker = ImagePicker();

  List<String> imageUrl = [];

  Future<void> pickImage() async {
    // ignore: no_leading_underscores_for_local_identifiers

    var imageFile = await _picker.pickImage(source: ImageSource.gallery);

    if (imageFile != null) {
      // Crop the image

      imageFile = await cropImage(imageFile);
      if (imageFile != null) {
        imageUrl.add(imageFile.path);
      } else {
        return;
      }
    }
  }

  Future<XFile?> cropImage(XFile imageFile) async {
    // Crop the image using image_cropper package
    final croppedFile = await ImageCropper.platform.cropImage(
      sourcePath: imageFile.path,
      maxWidth: 1080,
      maxHeight: 1920,
      compressQuality: 80,
      aspectRatioPresets: [CropAspectRatioPreset.ratio4x3],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Jobhub Cropper',
            toolbarColor: Color(kLightBlue.value),
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.ratio4x3,
            lockAspectRatio: true),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );

    if (croppedFile != null) {
      notifyListeners();
      return XFile(croppedFile.path);
    } else {
      return null;
    }
  }

//  imageUpload() async {
//   final ref =
//       FirebaseStorage.instance.ref().child('jobhub').child('${uid}jpg');
//   await ref.putFile(imageUrl[0]);
//   imageUrl = await ref.getDownloadURL();
// }
}
