import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:horizontal_gallery_widget/horizontal_gallery_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {PointerDeviceKind.mouse}, // for web scrolls horizontally.
      ),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: HorizontalGalleryWidget(
        images: [
          GalleryItem(
            uri: 'https://dummyimage.com/300x100',
            title: 'Image 1',
            description: 'Description 1',
          ),
          GalleryItem(
            uri: 'https://dummyimage.com/300x600',
            title: 'Image 2',
            description: 'Description 2',
          ),
          GalleryItem(
            uri: 'https://dummyimage.com/300x400',
            title: 'Image 3',
            description: 'Description 3',
          ),
          GalleryItem(
            uri: 'https://dummyimage.com/300x200',
            title: 'Image 4',
            description: 'Description 4',
          ),
          GalleryItem(
            uri: 'https://dummyimage.com/300x300',
            title: 'Image 5',
            description: 'Description 5',
          )
        ],
      ),
    );
  }
}
