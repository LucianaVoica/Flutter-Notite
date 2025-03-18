import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../theme/app_colors.dart';

class Avatar extends StatefulWidget {
  const Avatar({super.key});

  @override
  State<Avatar> createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  File? image;

  final ImagePicker picker = ImagePicker();

  Future<void> pickImage(ImageSource source) async {
    final XFile? pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
    Navigator.pop(context);
  }

  void showImage() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.secondaryLight,
      builder: (BuildContext context) {
        return Wrap(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 2),
              child: ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Fa o poza'),
                onTap: () => pickImage(ImageSource.camera),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 2, 20, 10),
              child: ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Alege din galerie'),
                onTap: () => pickImage(ImageSource.gallery),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: GestureDetector(
        onTap: showImage,
        child: CircleAvatar(
          radius: 20,
          backgroundImage: image != null ? FileImage(image!) : null,
          child:
              image == null
                  ? const Icon(Icons.person, size: 20, color: Colors.white)
                  : null,
        ),
      ),
    );
  }
}
