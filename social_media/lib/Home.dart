// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media/firebase_auth.dart';
import 'package:social_media/injection_container.dart';
// import 'package:social_media/sign_in.dart';
import 'package:social_media/create_post.dart';
import 'package:social_media/sing_in.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  File? _selectedImage;
  bool isSelected = false;

  Future<File?> _pickImageFromGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _selectedImage = image != null ? File(image.path) : null;
      isSelected = image != null;
    });
    return _selectedImage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: AlertDialog(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text("Camera"),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          File? imagePath = await _pickImageFromGallery();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreatePost(
                                imagePath: imagePath,
                              ),
                            ),
                          );
                        },
                        child: const Text("Gallery"),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          icon: Icon(Icons.camera_alt),
        ),
        actions: [
          IconButton(
            onPressed: () {
              locator<authService>().userSignOut();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SignIn(),
                ),
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              ListView.builder(
                
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: EdgeInsets.only(bottom: 30),
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: _selectedImage != null
                                  ? FileImage(_selectedImage!)
                                  : null,
                            ),
                            // Spacer(flex: 1,),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("username",style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Color.fromARGB(1000, 26, 27, 35),
                                  ),),
                                  Text("52 minutes ago", style: TextStyle(
                                      fontSize: 12,
                                      color: Color.fromARGB(100, 145, 145, 145)
                                  ),),
                                ],
                              ),
                            ),
                            Spacer(),
                            ElevatedButton(
                              style: ButtonStyle(
                                elevation: MaterialStatePropertyAll(0),
                                backgroundColor: MaterialStatePropertyAll<Color> (
                                  Colors.white,
                                ),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  side: BorderSide(color: const Color.fromARGB(255, 213, 212, 212)),
                                ),
                              ),
                              ),
                              onPressed: () {},
                              child: Text("Following", style: TextStyle(color: Colors.black),),
                            ),
                            // SizedBox(
                            //   height: 550,
                            // ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                          height: 200,
                          width: 490,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Colors.grey
                            )
                            ),
                          ),
                        Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et.",
                          style: TextStyle(
                            fontSize: 12,
                            color: Color.fromARGB(500, 145, 145, 145),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
