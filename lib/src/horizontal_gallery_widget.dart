import 'package:flutter/material.dart';
import 'package:horizontal_gallery_widget/src/gallery_item.dart';

/// A widget that displays a horizontal gallery of items.
class HorizontalGalleryWidget extends StatelessWidget {
  final bool labels;
  final double labelWidth;
  final List<GalleryItem> items;
  final void Function(GalleryItem item)? _onItemTap;
  final Widget Function(String url)? _imageBuilder;

  /// Ctor.
  const HorizontalGalleryWidget({
    super.key,
    required this.items,
    this.labels = true,
    this.labelWidth = 300,
    void Function(GalleryItem)? onItemTap,
    Widget Function(String uri)? imageBuilder,
  })  : _onItemTap = onItemTap,
        _imageBuilder = imageBuilder;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => _onItemTap?.call(items[index]),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            clipBehavior: Clip.antiAlias,
            child: AspectRatio(
              aspectRatio: 1,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: _imageBuilder == null
                        ? Image.network(items[index].uri, fit: BoxFit.cover)
                        : _imageBuilder(items[index].uri),
                  ),
                  if (items[index].title.isNotEmpty &&
                      items[index].description.isNotEmpty &&
                      labels)
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: FittedBox(child: _labels(context, index)),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _labels(BuildContext context, int index) {
    return Container(
      width: labelWidth,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            Colors.transparent,
          ],
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            items[index].title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onInverseSurface,
                ),
          ),
          Text(
            items[index].description,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onInverseSurface,
                ),
          ),
        ],
      ),
    );
  }
}
