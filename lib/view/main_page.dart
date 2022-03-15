import 'package:flutter/material.dart';
import 'package:ocr_in_flutter/view/text_recognition_page.dart';
class MainPage extends StatefulWidget {
  final String title;

  const MainPage({
    required this.title,
  });

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(widget.title),
    ),
    body: Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: const [
          SizedBox(height: 25),
          TextRecognitionWidget(),
          SizedBox(height: 15),
        ],
      ),
    ),
  );
}