import 'package:flutter/material.dart';
import 'package:horizontal_gallery_widget/src/gallery_item.dart';

/// A widget that displays a horizontal gallery of items.
class HorizontalGalleryWidget extends StatelessWidget {
  final bool _editing;
  final bool _labels;
  final double _size;
  final List<GalleryItem> _items;
  final void Function(GalleryItem item)? _onItemTap;
  final void Function()? _onAddItem;
  final void Function(GalleryItem item)? _onItemDelete;
  final Widget Function(String url)? _imageBuilder;

  /// Ctor.
  const HorizontalGalleryWidget({
    super.key,
    required List<GalleryItem> items,
    bool editing = false,
    bool labels = true,

    /// Original size, if the container is smaller then this size, the widgets will be scaled down.
    double size = 300,
    void Function(GalleryItem)? onItemTap,
    void Function()? onAddItem,
    void Function(GalleryItem)? onItemDelete,
    Widget Function(String uri)? imageBuilder,
  })  : _items = items,
        _size = size,
        _editing = editing,
        _onItemTap = onItemTap,
        _imageBuilder = imageBuilder,
        _labels = labels,
        _onItemDelete = onItemDelete,
        _onAddItem = onAddItem;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: _editing ? _items.length + 1 : _items.length,
      itemBuilder: (context, index) {
        if (_editing && index == 0) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: FittedBox(
              child: SizedBox(
                  width: _size,
                  height: _size,
                  child: GestureDetector(
                    onTap: () => _onAddItem?.call(),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: SizedBox(
                          width: 24,
                          height: 24,
                          child: ClipOval(
                            child: Container(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withOpacity(0.4),
                              child: Icon(
                                Icons.add,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onInverseSurface,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )),
            ),
          );
        }
        final itemIndex = _editing ? index - 1 : index;
        final item = _items[itemIndex];
        return GestureDetector(
          onTap: () => _onItemTap?.call(item),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            clipBehavior: Clip.antiAlias,
            child: FittedBox(
              child: SizedBox(
                width: _size,
                height: _size,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: _imageBuilder == null
                          ? Image.network(
                              item.uri,
                              fit: BoxFit.cover,
                              frameBuilder: (context, child, frame, _) {
                                if (frame == null) {
                                  return const Center(
                                    child: SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                }
                                return child;
                              },
                              errorBuilder: (context, error, _) {
                                return const Center(
                                  child: Icon(Icons.warning),
                                );
                              },
                            )
                          : _imageBuilder(item.uri),
                    ),
                    if (_editing)
                      Positioned(
                        top: 0,
                        right: 0,
                        child: InkWell(
                          onTap: () => _onItemDelete?.call(item),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipOval(
                              child: Container(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withOpacity(0.4),
                                child: Icon(
                                  Icons.close,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onInverseSurface,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    if (item.title.isNotEmpty &&
                        item.description.isNotEmpty &&
                        _labels)
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: _buildLabels(context, item),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLabels(BuildContext context, GalleryItem item) {
    return Container(
      width: _size,
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
            item.title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onInverseSurface,
                ),
          ),
          Text(
            item.description,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onInverseSurface,
                ),
          ),
        ],
      ),
    );
  }
}
