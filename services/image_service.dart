import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:universal_html/html.dart' as html;

class ImageService {
  static void downloadImageWeb(Uint8List bytes) {
    if (kIsWeb) {
      final blob = html.Blob([bytes], 'image/png');
      final url = html.Url.createObjectUrlFromBlob(blob);

      final anchor = html.AnchorElement(href: url)
        ..setAttribute("download", "offer_letter.png")
        ..click();

      html.Url.revokeObjectUrl(url);
    }
  }
}


