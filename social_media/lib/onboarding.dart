// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:social_media/sing_in.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: PageView(
          controller: controller,
          children: [
            Container(
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Column(
                  
                    children: [
                    
                     Padding(
                       padding: const EdgeInsets.only(bottom: 18.0),
                       child: Image.asset(
                          'assets/images/onboarding1.png', 
                        ),
                     ),
                    
                    SizedBox(
                      height: 120,
                      child: Text(
                        "Let’s connect with each other",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 40,
                            color: Color.fromARGB(500, 26, 27, 35)),
                      ),
                    ),
                    Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(1000, 145, 145, 145)),
                    ),
                  ],
                  ),
                )
                ),
            Container(
                color: Colors.white,
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Image.asset(
                      'assets/images/onboarding1.png',
                    ),
                  ),
                  SizedBox(
                    height: 120,
                    child: Text(
                      "Let’s connect with each other",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 40,
                          color: Color.fromARGB(1000, 26, 27, 35)),
                    ),
                  ),
                  Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Color.fromARGB(1000, 145, 145, 145)),
                  )
                ])),
            Container(
                color: Colors.white,
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Image.asset(
                      'assets/images/onboarding1.png',
                    ),
                  ),
                  SizedBox(
                    height: 120,
                    child: Text(
                      "Let’s connect with each other",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 40,
                          color: Color.fromARGB(1000, 26, 27, 35)),
                    ),
                  ),
                     Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(1000, 145, 145, 145)),
                    ),
                  
                ])),
          ],
        ),
      ),
      bottomSheet:
      
      Container(
          height: 130,
          color: Colors.white,
          padding: EdgeInsets.only(bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(

                    child: SmoothPageIndicator(
                      effect: ExpandingDotsEffect(
                        dotWidth: 25,
                        dotHeight: 10
                      ),
                      controller: controller,
                      count: 3,
                      ),
                  ),
              SizedBox(
                height: 60,
                width: 320,
                child: ElevatedButton(
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
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignIn()));
                    },
                    child: Text(
                      "Get started",
                      style: TextStyle(color: Colors.white),
                    )
                    ),
              ),
            ],
          )
              ),
    );
  }
}
