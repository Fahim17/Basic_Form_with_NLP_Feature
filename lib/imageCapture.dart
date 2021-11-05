import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class captureImage {
  static Future<bool> captureFromCamera() async {
    String name = "temp.png";
    final ImagePicker _picker = ImagePicker();
    try {
      final XFile photo = await _picker.pickImage(source: ImageSource.camera);

      final dir = await getTemporaryDirectory();

      photo.saveTo('${dir.path}/$name');
    } on Exception catch (e) {
      print("CAPTURE IMAGE EXCEPTION: $e");
      return false;
    }

    print("IMAGE SAVED!!!");
    return true;
  }
}
