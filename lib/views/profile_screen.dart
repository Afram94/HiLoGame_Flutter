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
  int _selectedDestination = 0;

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
    final mq = MediaQuery.of(context);
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

    /*  Future getImage() async {
      final pickedImage = await picker.getImage(source: ImageSource.camera);

      setState(() {
        if (pickedImage != null) {
          _image = File(pickedImage.path);
          _showMyDialog();
        } else {
          print('No image selected.');
        }
      });
    } */

    final profilePicture = Builder(
      builder: (context) => Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 5.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.grey[300],
                    child: ClipOval(
                      child: SizedBox(
                        height: 180.0,
                        width: 180.0,
                        child: (_image != null)
                            ? Image.file(_image, fit: BoxFit.fill)
                            : Image.asset("logo.jpg"),
                      ),
                    ),
                  ),
                ),
                // Upload a photo (camera icon) __________
                /*  Padding(
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
                  ), */
              ],
            )
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );

    final settingsButtons = RawMaterialButton(
      highlightColor: Colors.blue[50],
      elevation: 2.0,
      fillColor: Colors.white,
      child: Icon(
        Icons.settings_backup_restore,
        color: Colors.blue[400],
        size: 30.0,
      ),
      padding: EdgeInsets.all(20.0),
      shape:
          CircleBorder(side: BorderSide(width: 1.0, color: Colors.blue[400])),
      onPressed: () {
        Navigator.of(context).pushNamed(AppRoutes.authSettings);
      },
    );

    final inviteButtons = Container(
      child: RawMaterialButton(
        highlightColor: Colors.blue[50],
        splashColor: Colors.blue[50],
        elevation: 2.0,
        fillColor: Colors.white,
        child: Icon(
          Icons.get_app,
          color: Colors.blue[400],
          size: 45.0,
        ),
        padding: EdgeInsets.all(20.0),
        shape:
            CircleBorder(side: BorderSide(width: 1.0, color: Colors.blue[400])),
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.authSettings);
        },
      ),
     /*  decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.blue[100].withOpacity(0.8),
            spreadRadius: 5,
            blurRadius: 10,
            offset: Offset(0, 7), // changes position of shadow
          ),
        ],
      ), */
    );

    /* final hehe = DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            spreadRadius: 4,
            color: Colors.black,
            offset: Offset(2, 2),
            blurRadius: 3,
          )
        ],
      ),
    );
 */
    final historyButtons = RawMaterialButton(
      highlightColor: Colors.blue[50],
      elevation: 2.0,
      fillColor: Colors.white,
      child: Icon(
        Icons.settings,
        color: Colors.blue[400],
        size: 30.0,
      ),
      padding: EdgeInsets.all(20.0),
      shape:
          CircleBorder(side: BorderSide(width: 1.0, color: Colors.blue[400])),
      onPressed: () {
        Navigator.of(context).pushNamed(AppRoutes.authSettings);
      },
    );

    final buttons = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      //crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(padding: EdgeInsets.only(right: 25), child: settingsButtons),
        Padding(
            padding: EdgeInsets.only(right: 25, bottom: 20),
            child: inviteButtons),
        Padding(padding: EdgeInsets.only(), child: historyButtons),
      ],
    );

    final item1 = ListTile(
      leading: Icon(Icons.favorite),
      title: Text('Item 1'),
      selected: _selectedDestination == 0,
      onTap: () {
        Navigator.of(context).pushNamed(AppRoutes.authSettings);
      },
    );
     final item2 = ListTile(
      leading: Icon(Icons.favorite),
      title: Text('Item 2'),
      selected: _selectedDestination == 0,
      onTap: () {
        Navigator.of(context).pushNamed(AppRoutes.authSettings);
      },
    );
     final item3 = ListTile(
      leading: Icon(Icons.favorite),
      title: Text('Item 3'),
      selected: _selectedDestination == 0,
      onTap: () {
        Navigator.of(context).pushNamed(AppRoutes.authSettings);
      },
    );

    final items = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      //crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        item1,
        item2,
        item3
      ],
    );

    return Scaffold(
        backgroundColor: Colors.grey[100],
        body: Container(
          child: Form(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(36),
              child: Container(
                height: mq.size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    
                    profilePicture,
                    buttons,
                    Padding(
                      padding: EdgeInsets.only(bottom:200),
                      child: items,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
