import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media/Home.dart';
import 'package:social_media/firebase_auth.dart';
import 'package:social_media/injection_container.dart';
import 'package:social_media/sing_in.dart';

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});
  @override
  MyCustomFormState createState() => MyCustomFormState();
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Enter some text';
              }
              return null;
            },
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')));
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}

class SignUp extends StatefulWidget {
  const SignUp({super.key});
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  XFile? image;
  String? userId;
  Future<void> _signup() async {
    final user = await locator<authService>().createUserWithEmailAndPassword(emailText.text, passwordText.text);
    if (user != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );
      await storeUserDetails();
    } else {
      print("New error occurred");
    }

  }
  TextEditingController nameText = TextEditingController();
  TextEditingController usernameText = TextEditingController();
  TextEditingController emailText = TextEditingController();
  TextEditingController passwordText = TextEditingController();

  Future<void> storeUserDetails() async {
    userId = await locator<authService>().getUserId();
    if (userId != null) {
      final userRef = FirebaseFirestore.instance.collection('users').doc(userId);
      try {
        if (_selectedImage != null  ) {
          final path = "users/${_selectedImage!.path.split('/').last}";
          final imagePath = FirebaseStorage.instance.ref().child(path);
          final uploadTask = imagePath.putFile(_selectedImage!);
          final snapshot = await uploadTask.whenComplete(() => null);
          final downloadUrl = await snapshot.ref.getDownloadURL();

            await userRef.set({
              "name": nameText.text,
              "username": usernameText,
              "image": downloadUrl,
              "email" : emailText.text, 
          });
        } else {
          await userRef.set({
            "name": nameText.text,
            "username": usernameText.text,
            "image": null,
            "email" : emailText.text,
          });
        }
        setState(() {
          locator<authService>().isLogged= true;
        });
      } catch (e) {
        rethrow;
      }
    }
  }

  final regex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  File? _selectedImage;
  bool isSelected = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      body: Form(
        child: SafeArea(
          child: Container(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Sign Up!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color.fromARGB(255, 29, 29, 32),
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "Create a new account",
                    style: TextStyle(
                      color: Color.fromRGBO(29, 29, 32, 1),
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                    ),
                  ),
                  IconButton(
                    onPressed: _pickImageFromGallery,
                    icon: CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          isSelected ? FileImage(_selectedImage!) : null,
                      child: !isSelected
                          ? const Icon(
                              Icons.person,
                              size: 50,
                              color: Colors.grey,
                            )
                          : null,
                    ),
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    margin: EdgeInsets.fromLTRB(25, 10, 25, 50),
                    child: Column(
                      children: [
                        _buildTextField(
                          controller: nameText,
                          labelText: "Name",
                        ),
                        const SizedBox(height: 25),
                        _buildTextField(
                          controller: usernameText,
                          labelText: "Username",
                        ),
                        const SizedBox(height: 25),
                        _buildTextField(
                          controller: emailText,
                          labelText: "Email Address",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your email";
                            } else if (!regex.hasMatch(value)) {
                              return "Please enter a valid email address";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 25),
                        _buildTextField(
                          controller: passwordText,
                          labelText: "Password",
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            } else if (value.length < 6) {
                              return 'Password is too short';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 25),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: _signup,
                            style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll<Color>(
                                  Color.fromARGB(1000, 77, 217, 1)),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: BorderSide(color: Color.fromARGB(1000, 77, 217, 1)),
                                ),
                              ),
                            ),
                            child: const Text(
                              "Sign Up",
                              style: TextStyle(
                                color: Colors.white,
                                overflow: TextOverflow.visible,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Already have an account? ",
                                style: TextStyle(
                                  color: Color.fromARGB(1000, 129, 129, 129),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const SignIn(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Sign In",
                                  style: TextStyle(
                                    color: Color.fromARGB(1000, 77, 217, 1),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          validator: validator,
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: const TextStyle(color: Colors.grey),
            floatingLabelStyle: const TextStyle(
              color: Color.fromARGB(1000, 77, 217, 1),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromARGB(1000, 77, 217, 1),
              ),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _pickImageFromGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _selectedImage = image != null ? File(image.path) : null;
      isSelected = image != null;
    });
    print("THIS IS IMAGE PATH : $_selectedImage");
  }
}
