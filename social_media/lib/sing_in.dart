import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media/Home.dart';
import 'package:social_media/firebase_auth.dart';
import 'package:social_media/injection_container.dart';
import 'package:social_media/sign_up.dart';

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
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
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text('Processing Data')));
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final regex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  TextEditingController emailText = TextEditingController();
  TextEditingController passwordText = TextEditingController();

  _signin() async {
    if (_formKey.currentState!.validate()) {
      try {
      final user = await locator<authService>().loginUserWithEmailAndPassword(
          emailText.text.trim(), passwordText.text);
      if (user != null) {
        setState(() {
          locator<authService>().isLogged = true;
        });
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Home()));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Login failed')));
      }
      }on FirebaseAuthException catch(e) {
        passwordText.text = "";
        showDialog(
          context: context,
          builder: (context) => AlertDialog(content: Text(e.message ?? "Unexpected behaviour"),));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromARGB(1000, 77, 217, 0)),
          margin: const EdgeInsets.all(8),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
            iconSize: 20,
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topCenter,
          margin: const EdgeInsets.only(top: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Hello Again!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 29, 29, 32),
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "Sign in to your account",
                style: TextStyle(
                  color: Color.fromRGBO(29, 29, 32, 1),
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                ),
              ),
              Container(
                alignment: Alignment.topCenter,
                margin: const EdgeInsets.fromLTRB(25, 40, 25, 50),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey),
                        ),
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.only(bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              autovalidateMode:AutovalidateMode.onUserInteraction,
                              controller: emailText,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                label: Text("Email address"),
                                labelStyle: TextStyle(
                                  color: Color.fromARGB(255, 77, 217, 105)
                                )
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your email";
                                } else if (!regex.hasMatch(value)) {
                                  return "Please enter a valid email";
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey),
                        ),
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.only(bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: passwordText,
                              obscureText: true,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                label: Text("Password"),  
                                labelStyle: TextStyle(
                                  color: Color.fromARGB(255, 77, 217, 105)
                                )
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                } else if (value.length < 6) {
                                  return 'Password is too short';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _signin,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(1000, 77, 217, 1)),
                          child: const Text(
                            "Sign In",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child:  Text(
                              "Don't have an account? ",
                              style: TextStyle(
                                  color: Color.fromARGB(1000, 129, 129, 129)),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SignUp()));
                            },
                            child: const Text(
                              "Sign Up",
                              style: TextStyle(
                                  color: Color.fromARGB(1000, 77, 217, 1)),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
