import 'package:flutter/material.dart';
import 'package:horizontal_gallery_widget/src/gallery_item.dart';

class HorizontalGalleryWidget extends StatelessWidget {
  final List<GalleryItem> images;

  const HorizontalGalleryWidget({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Card(
            child: SizedBox(
              width: 300,
              height: 300,
              child: Image.network(
                images[index].uri,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
