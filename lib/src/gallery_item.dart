/// Item of the gallery.
sealed class GalleryItem {
  final int id;

  /// The title of the image.
  final String title;

  /// The description of the image.
  final String description;

  GalleryItem({
    this.id = -1,
    this.title = "",
    this.description = "",
  });
}

class NetworkGalleryItem extends GalleryItem {
  final String uri;
  final Map<String, String> headers;

  NetworkGalleryItem({
    super.id,
    this.uri = "",
    this.headers = const {},
    super.title,
    super.description,
  });
}

class LocalGalleryItem extends GalleryItem {
  final String path;

  LocalGalleryItem({
    super.id,
    this.path = "",
    super.title,
    super.description,
  });
}
