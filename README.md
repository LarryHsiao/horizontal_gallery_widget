horizontal_gallery_widget
----

Just a simple widget to display a horizontal gallery of images.

![](doc/example_01.png)

### Example

```dart
  HorizontalGalleryWidget(
    items: [
      GalleryItem(
        uri: 'https://picsum.photos/300/100',
        title: 'Image 1',
        description: 'Description 1',
      ),
      GalleryItem(
        uri: 'https://picsum.photos/300/600',
        title: 'Image 2',
        description: 'Description 2',
      ),
      GalleryItem(
        uri: 'https://picsum.photos/300/400',
        title: 'Image 3',
        description: 'Description 3',
      ),
      GalleryItem(
        uri: 'https://picsum.photos/300/200',
        title: 'Image 4',
        description: 'Description 4',
      ),
      GalleryItem(
        uri: 'https://picsum.photos/300/300',
        title: 'Image 5',
        description: 'Description 5',
      )
    ],
    onItemTap: (item) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Tapped on ${item.title}'),
        ),
      );
    },
  );
```