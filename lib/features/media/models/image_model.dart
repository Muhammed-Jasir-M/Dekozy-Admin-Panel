import 'dart:typed_data';
import 'package:universal_html/html.dart';

import 'package:aura_kart_admin_panel/utils/formatters/formatter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ImageModel {
  String id;
  final String url;
  final String folder;
  final int? sizeBytes;
  String mediaCategory;
  final String filename;
  final String? publicId;
  final String? fullPath;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? contentType;

  // Not Mapped
  final File? file;
  RxBool isSelected = false.obs;
  final Uint8List? localImageToDisplay;

  /// Constructor
  ImageModel({
    this.id = '',
    this.mediaCategory = '',
    required this.url,
    required this.folder,
    this.publicId,
    this.sizeBytes,
    required this.filename,
    this.fullPath,
    this.createdAt,
    this.updatedAt,
    this.contentType,
    this.file,
    this.localImageToDisplay,
  });

  /// Static function to create an empty user model.
  static ImageModel empty() => ImageModel(url: '', folder: '', filename: '');

  String get createdAtFormatted => AFormatter.formatDate(createdAt);
  String get updatedAtFormatted => AFormatter.formatDate(updatedAt);

  /// Convert to Json to Store in DB
  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'folder': folder,
      'publicId': publicId,
      'filename': filename,
      'sizeBytes': sizeBytes,
      'fullPath': fullPath,
      'createdAt': createdAt?.toUtc(),
      'contentType': contentType,
      'mediaCategory': mediaCategory,
    };
  }

  /// Convert Firestore Json and Map on Model
  factory ImageModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data != null) {
      // Map Json to Model
      return ImageModel(
        id: document.id,
        url: data['url'] ?? '',
        folder: data['folder'] ?? '',
        publicId: data['publicId'] ?? '',
        filename: data['filename'] ?? '',
        fullPath: data['fullPath'] ?? '',
        sizeBytes: data['sizeBytes'] ?? 0,
        createdAt:
            data.containsKey('createdAt') ? data['createdAt']?.toDate() : null,
        updatedAt:
            data.containsKey('updatedAt') ? data['updatedAt']?.toDate() : null,
        contentType: data['contentType'] ?? '',
        mediaCategory: data['mediaCategory'],
      );
    } else {
      return ImageModel.empty();
    }
  }

  factory ImageModel.fromCloudinaryResponse(Map<String, dynamic> response, String folder , String imageName) {
    return ImageModel(
      url: response['secure_url'] ?? '',
      publicId: response['public_id'] ?? '',
      folder: folder,
      filename: imageName,
      fullPath: '${response['folder'] ?? ''}/${response['public_id'] ?? ''}',
      sizeBytes: response['bytes'] ?? 0,
      contentType: '${response['resource_type']}/${response['format']?? ''}',
      createdAt: DateTime.now(),
    );
  }
}
