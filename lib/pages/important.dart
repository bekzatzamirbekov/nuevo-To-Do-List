// ignore_for_file: unnecessary_null_comparison
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  File? image;
  Future pickImage(ImageSource source) async {
    try {
      await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemp = File(image!.path);
      // final imagePermanent = await saveFilePermamently(image?.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      Text('falied to pick an image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            'Motivate yourself with quotes',
            style: TextStyle(fontSize: 25),
          ),
          SizedBox(
            height: 20,
          ),
          image != null
              ? Image.file(
                  image!,
                  width: 250,
                  height: 250,
                  fit: BoxFit.cover,
                )
              : Image.network(
                  'https://wonderwordss.files.wordpress.com/2015/08/wpid-1175228_585017948240406_1404096767_n.jpeg'),
          SizedBox(
            height: 40,
          ),
          CustomButton(
              title: 'Pick From Gallery',
              icon: Icons.image_outlined,
              onClick: () => pickImage(ImageSource.gallery)),
          CustomButton(
              title: 'Pick From Camera',
              icon: Icons.image_outlined,
              onClick: () {})
        ],
      )),
    );
  }
}

Widget CustomButton(
    {required String title,
    required IconData icon,
    required VoidCallback onClick}) {
  return Container(
    width: 280,
    child: ElevatedButton(
      onPressed: onClick,
      child: Row(
        children: [
          Icon(icon),
          SizedBox(
            width: 20,
          ),
          Text(title)
        ],
      ),
    ),
  );
}
