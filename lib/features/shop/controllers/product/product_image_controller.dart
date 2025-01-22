import 'package:aura_kart_admin_panel/features/media/controller/media_controller.dart';
import 'package:aura_kart_admin_panel/features/media/models/image_model.dart';
import 'package:get/get.dart';

class ProductImageController extends GetxController {
  static ProductImageController get instance => Get.find();

//Rx observable for the selected thumbnail images
  Rx<String?> selectedThumbnailImageUrl = Rx<String?>(null);

// Lsits to store additional product Images
  final RxList<String> additionalProductImageUrls = <String>[].obs;

  ///Pick Thimbnail Image free From Media
  void selectThumbnailImage() async {
    final controller = Get.put(MediaController());
    List<ImageModel>? selectedImages = await controller.selectImagesFromMedia();

    // Handle the Selected images
    if (selectedImages != null && selectedImages.isNotEmpty) {
      //Set the selected  images to the main image or perform any other action
      ImageModel selectedImage = selectedImages.first;
      //Update the main image using the selectedImage
      selectedThumbnailImageUrl.value = selectedImage.url;
    }
  }

  ///Pick Multiple Images from Media
  void selectMultipleProductImages() async {
    final controller = Get.put(MediaController());
    final selectedImages = await controller.selectImagesFromMedia(
        multipleSelection: true, selectedUrls: additionalProductImageUrls);

    // Handle the Selected images
    if (selectedImages != null && selectedImages.isNotEmpty) {
      additionalProductImageUrls.assignAll(selectedImages.map((e) => e.url));
    }
  }

  ///Funtion to remove Product Image
  Future<void> removeImage(int index) async {
    additionalProductImageUrls.removeAt(index);
  }
}
