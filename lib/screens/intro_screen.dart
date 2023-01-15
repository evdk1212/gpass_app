import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gpass/screens/login_screen.dart';
import 'package:gpass/screens/signup_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                  color: Colors.transparent,
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/gpassIntro.png',
                    ),
                    fit: BoxFit.cover,
                  )),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: SafeArea(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Spacer(),
                       Text("G-PASS",style: GoogleFonts.pressStart2p(textStyle: const TextStyle(color:  Colors.white,fontSize: 30)),),
                       const SizedBox(height: 20,),
                       Text("Design Project - 2 by ",style: GoogleFonts.pressStart2p(textStyle: const TextStyle(color: Color.fromARGB(156, 255, 255, 255)),fontSize: 10,),),
                       const SizedBox(height: 10,),
                       Text("DEEPAKKUMAR E(20137024)",style: GoogleFonts.pressStart2p(textStyle: const TextStyle(color: Color.fromARGB(156, 255, 255, 255)),fontSize: 10,),),
                       const SizedBox(height: 10,),
                       Text("S MOHAMED IRSHAD(20137031)",style: GoogleFonts.pressStart2p(textStyle: const TextStyle(color: Color.fromARGB(156, 255, 255, 255)),fontSize: 10,),),
                       const SizedBox(height: 10,),
                       Text("CSE AI&ML (6th SEM)",style: GoogleFonts.pressStart2p(textStyle: const TextStyle(color: Color.fromARGB(156, 255, 255, 255)),fontSize: 10,),),
                       const SizedBox(height: 10,),
                       Text("HITS CHENNAI",style: GoogleFonts.pressStart2p(textStyle: const TextStyle(color: Color.fromARGB(156, 255, 255, 255)),fontSize: 10,),),
                       const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignUpScreen()));
                          },
                          child: Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width/1.7,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(136, 14, 127, 214),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Text("SignUp",style: GoogleFonts.pressStart2p(textStyle: const TextStyle(color: Colors.white)),),
                                ),
                            )
                            ,
                          ),
                        ),
                      ),
                       Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: InkWell(
                          onTap: (){
                             Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
                          },
                          child: Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width/1.7,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(136, 14, 127, 214),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Text("Login",style: GoogleFonts.pressStart2p(textStyle: const TextStyle(color: Colors.white)),),
                                ),
                            )
                            ,
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
