// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:social_media/firebase_auth.dart';
import 'package:social_media/injection_container.dart';

class CreatePost extends StatefulWidget {
   final File? imagePath;
  const CreatePost({super.key, required this.imagePath});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  @override


  Widget build(BuildContext context) {
  String imagePath = widget.imagePath.toString();
  TextEditingController titleText = TextEditingController();
  TextEditingController descriptionText = TextEditingController();

    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                  // child: Text(widget.imagePath.toString()),
                  // child: Image.file(widget.imagePath),
                  child: widget.imagePath != null ?  Image?.file(widget.imagePath!): Image.network("https://t4.ftcdn.net/jpg/04/70/29/97/360_F_470299797_UD0eoVMMSUbHCcNJCdv2t8B2g1GVqYgs.jpg"),
                  ),
              TextField(
                controller: titleText,
                decoration: InputDecoration(
                    hintText: "Title",
                    hintStyle: TextStyle(
                      color: Color.fromARGB(1000, 77, 217, 1),
                    )),
              ),
              TextField(
                controller: descriptionText,
                maxLines: 5,
                decoration: InputDecoration(
                    hintText: "Description",
                    hintStyle: TextStyle(
                      color: Color.fromARGB(1000, 77, 217, 1),
                    )),
              ),
              ElevatedButton(
                  onPressed: () async 
                  {
                    final userId = await locator<authService>().getUserId();
                    final userRef = FirebaseFirestore.instance.collection('posts').doc();
                    final path = "posts/${widget.imagePath!.path.split('/').last}";
                    final imagePath = FirebaseStorage.instance.ref().child(path);
                    final uploadTask = imagePath.putFile(widget.imagePath!);
                    final snapshot = await uploadTask.whenComplete(() => null);
                    final downloadUrl = await snapshot.ref.getDownloadURL();
                    await userRef.set({
                      "title" : titleText.text,
                      "description" : descriptionText.text,
                      "image" : downloadUrl,
                      "created_by" : userId,
                      }
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(
                        Color.fromARGB(1000, 77, 217, 1)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side:
                            BorderSide(color: Color.fromARGB(1000, 77, 217, 1)),
                      ),
                    ),
                  ),
                  child: Text(
                    "POST",
                    style: TextStyle(
                      color: Colors.white),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
