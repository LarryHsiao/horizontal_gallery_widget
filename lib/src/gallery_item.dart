/// Item of the gallery.
class GalleryItem {
  final int id;

  /// The uri of the image.
  final String uri;

  /// The title of the image.
  final String title;

  /// The description of the image.
  final String description;

  GalleryItem({
    this.id = -1,
    this.uri = "",
    this.title = "",
    this.description = "",
  });
}
