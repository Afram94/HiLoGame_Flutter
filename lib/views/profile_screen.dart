import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hilogame/theme/routes.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File _image;
  final picker = ImagePicker();

  @override
  Future uploadPic(BuildContext context) async {
    String fileName = basename(_image.path);
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = firebaseStorageRef.putFile(_image);
    TaskSnapshot taskSnapshot = await uploadTask;
    setState(() {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Profile pic uploaded"),
      ));
    });
  }

  Widget build(BuildContext context) {
    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Change Photo ?'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Are you sure about your edit ?'),
                  // Text('Would you like to approve of this message?'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Yes'),
                onPressed: () {
                  uploadPic(context);
                  //Navigator.of(context).pushNamed(AppRoutes.authProfile);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    Future getImage() async {
      final pickedImage = await picker.getImage(source: ImageSource.camera);

      setState(() {
        if (pickedImage != null) {
          _image = File(pickedImage.path);
          _showMyDialog();
        } else {
          print('No image selected.');
        }
      });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Builder(
        builder: (context) => Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 70.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.blue[200],
                      child: ClipOval(
                        child: SizedBox(
                          height: 180.0,
                          width: 180.0,
                          child: (_image != null)
                              ? Image.file(_image, fit: BoxFit.fill)
                              : Image.network(
                                  "https://i.picsum.photos/id/1025/4951/3301.jpg?hmac=_aGh5AtoOChip_iaMo8ZvvytfEojcgqbCH7dzaz-H8Y"),
                        ),
                      ),
                    ),
                  ),
                  // Upload a photo (camera icon) __________
                  Padding(
                    padding: EdgeInsets.only(top: 60.0),
                    child: IconButton(
                      icon: Icon(
                        Icons.camera_alt_outlined,
                        size: 30.0,
                      ),
                      onPressed: () {
                        print("camera");
                        getImage();
                      },
                    ),
                  ),
                ],
              )
            ],
            mainAxisAlignment: MainAxisAlignment.start,
          ),
        ),
      ),
    );
  }
}
