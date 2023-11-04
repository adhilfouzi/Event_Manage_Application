import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_event/Core/Color/font.dart';

class AddImage extends StatefulWidget {
  final Function(String) onImageSelected;

  const AddImage({super.key, required this.onImageSelected});

  @override
  State<AddImage> createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  String? imagepath;
  File? imageevent;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 15, 10, 5),
      child: InkWell(
        onTap: () {
          addphoto(context);
        },
        child: SizedBox(
          width: double.infinity,
          height: 175,
          child: Card(
            color: Colors.transparent,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(19),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: imageevent == null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/UI/icons/addimage.png',
                          width: 75,
                          height: 70,
                        ),
                        Text(
                          'Add image of event',
                          style: raleway(color: Colors.black),
                        )
                      ],
                    )
                  : Image.file(
                      imageevent!,
                      width: double.infinity,
                      height: 160,
                      fit: BoxFit.fill, // Fit the image within the container
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getimage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) {
        return;
      }
      setState(() {
        imageevent = File(image.path);
        final imagepath = image.path.toString();
        widget.onImageSelected(imagepath); // Pass imagepath to the callback
      });
    } catch (e) {
      print('Failed image picker:$e');
    }
  }

  void addphoto(ctxr) {
    showDialog(
      context: ctxr,
      builder: (ctxr) {
        return AlertDialog(
          content: const Text('Choose Image From.......'),
          actions: [
            IconButton(
              onPressed: () {
                getimage(ImageSource.camera);
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.camera_alt_rounded,
                color: Colors.red,
              ),
            ),
            IconButton(
              onPressed: () {
                getimage(ImageSource.gallery);
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.image,
                color: Colors.red,
              ),
            ),
          ],
        );
      },
    );
  }
}
