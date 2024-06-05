import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageHelper {
  ImageHelper({
    ImagePicker? imagePicker,
    ImageCropper? imageCropper,
  })  : _imagePicker = imagePicker ?? ImagePicker(),
        _imageCropper = imageCropper ?? ImageCropper();

  final ImagePicker _imagePicker;
  final ImageCropper _imageCropper;
  Future<XFile?> pickimage(
      {ImageSource source = ImageSource.gallery,
      int imageQuality = 100}) async {
    return await _imagePicker.pickImage(
        source: source, imageQuality: imageQuality);
  }

  Future<CroppedFile?> crop({
    required XFile file,
    CropStyle cropstyle = CropStyle.rectangle,
  }) async =>
      await _imageCropper.cropImage(
          sourcePath: file.path, cropStyle: cropstyle, compressQuality: 100);
}
