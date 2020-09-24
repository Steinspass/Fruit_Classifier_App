import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:ifruit_classifier/provider/tflite_provider.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool _laoding = true;
  File _image;
  List<dynamic> _output;

  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    loadModel().then((value){
      setState(() {});
    });
  }


  @override
  void dispose() {
    super.dispose();
    closeTFlite();
  }

  pickImagePhoto() async {

    var image = await picker.getImage(source: ImageSource.camera);

    if(image == null) return null;

    setState(() {
      _image = File(image.path);
    });

    _output = await classifyImage(_image);
    _laoding = false;

    setState(() {});


  }  


  pickImageGallery() async {

    var image = await picker.getImage(source: ImageSource.gallery);

    if(image == null) return null;

    setState(() {
      _image = File(image.path);
    });

    _output = await classifyImage(_image);
    _laoding = false;
    
    setState(() {});


  }  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _backgroundContainer(),
    );
  }

  Widget _backgroundContainer() {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [ 
            Color(0xFFB583F0),
            Color(0xFFEB6CC1), 
            Color(0xFFFF6589)
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 24
        ),
        child: _columnTextAndImage()
      ),
    );
  }

  Widget _columnTextAndImage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 50.0,),
        _titleFlowers(),
        _subtitleFlowers(),
        SizedBox(height: 40.0,),
        _centerImage(),
        SizedBox(height: 40.0,),
        _output != null 
          ? _textWhatIs() 
          : Container(),
          SizedBox(height: 20.0,),
          _rowButtons()
      ],
    );
  }

  Widget _titleFlowers() {
    return ColorizeAnimatedTextKit(
      text: ['Classifier Fruits & Vegetables'],
      textStyle: TextStyle(
        fontSize: 30.0,
        fontWeight: FontWeight.bold
      ),
      colors: [
        Color(0xFFB9E069),
        Color(0xFF6CEB96), 
        Color(0xFF00F0D1)
      ], 
      repeatForever: true,
      speed: Duration(milliseconds: 600),
      pause: Duration(milliseconds: 100),
    );
  }

  Widget _subtitleFlowers() {
    return ColorizeAnimatedTextKit(
      text: ['Custom Tensorflow CNN'],
      textStyle: TextStyle(
        fontSize: 22.0,
        fontWeight: FontWeight.bold
      ),
      colors: [
        Color(0xFFB9E069),
        Color(0xFF6CEB96), 
        Color(0xFF00F0D1)
      ], 
      repeatForever: true,
      speed: Duration(milliseconds: 600),
      pause: Duration(milliseconds: 100),
    );
  }

  Widget _centerImage() {

    return Center(
      child: _laoding ? _imagePlaceholder() : _imagePhoto(),
    );
  }

  Widget _imagePlaceholder() {
    return Container(
      width: 220.0,
      child: Column(
        children: [
          Image.asset('assets/healty-food.png'),
          SizedBox(height: 40.0,)
        ],
      ),
    );
  }

  Widget _imagePhoto() {
    return Container(
      child: Column(
        children: [
           Container(
             height: 220.0,
             child: Image.file(_image),
           ),
           SizedBox(
             height: 20.0,
           ),
        ],
      ),
    );
  }
  
  Widget _textWhatIs() {
    String whatIs = 'Prediction is: ${_output[0]['label']}';

    return Text(
      whatIs,
      style: TextStyle(
        color: Color(0xFF6CEB96),
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic
      ),
    );
  }

  Widget _rowButtons(){
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buttonTakePhoto(),
          SizedBox(width: 15.0,),
          _buttonOpenGallery()
        ],
      ),
    );
  }

  Widget _buttonTakePhoto() {
    return GestureDetector(
      onTap: pickImagePhoto,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 18.0
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          gradient: new LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFFB9E069),
              Color(0xFF6CEB96), 
              Color(0xFF00F0D1)
            ], // whitish to gray
            tileMode: TileMode.repeated, // repeats the gradient over the canvas
          ),
        ),
        child: Text(
          'Take a photo',
          style: TextStyle(
            color: Color(0xFFEB6CC1),
            fontSize:  18.0,
            fontWeight: FontWeight.w400
          ),
        ),
      ),
    );
  }

  Widget _buttonOpenGallery() {
    return GestureDetector(
      onTap: pickImageGallery,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 18.0
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          gradient: new LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFF00F0D1),
              Color(0xFF6CEB96), 
              Color(0xFFB9E069),
            ], // whitish to gray
            tileMode: TileMode.repeated, // repeats the gradient over the canvas
          ),
        ),
        child: Text(
          'Open Gallery',
          style: TextStyle(
            color: Color(0xFFEB6CC1),
            fontSize:  18.0,
            fontWeight: FontWeight.w400
          ),
        ),
      ),
    );
  }

}