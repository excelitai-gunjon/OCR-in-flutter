import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ocr_in_flutter/api/firebase_ml_api.dart';
import 'package:ocr_in_flutter/view/controls_widget.dart';
import 'dart:io';

import 'package:ocr_in_flutter/view/text_area_widget.dart';

class TextRecognitionWidget extends StatefulWidget {
  const TextRecognitionWidget({Key? key}) : super(key: key);

  @override
  _TextRecognitionWidgetState createState() => _TextRecognitionWidgetState();
}

class _TextRecognitionWidgetState extends State<TextRecognitionWidget> {
  String text = '';
  var image;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: buildImage(),
          ),
          const SizedBox(
            height: 16,
          ),
          ControlsWidget(
            onClickedPickImage: pickImage,
            onClickedScanText: scanText,
            onClickedClear: clear,
          ),
          const SizedBox(
            height: 16,
          ),
          TextAreaWidget(
            text: text,
            onClickedCopy: copyToClipboard,
          ),
        ],
      ),
    );
  }

  Widget buildImage() {
    return Container(
      child: image != null
          ? Image.file(image)
          : const Icon(Icons.photo, size: 80, color: Colors.black),
    );
  }

  Future pickImage() async {
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    setImage(File(file!.path));
  }
  void setImage(File newImage){
    setState((){
      image = newImage;
    });
  }
  Future scanText()async{
    showDialog(
      context: context,
      builder: (BuildContext context){
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    final text = await FirebaseMLApi.recogniseText(image);
    setText(text);
    Navigator.of(context).pop();
  }
  void setText(String newText){
    setState((){
      text=newText;
    });
  }
  void clear(){
    setText('');
    setImage(File(''));
  }
  void copyToClipboard(){
    if(text.trim() !=''){
      FlutterClipboard.copy(text);
    }
  }

}
