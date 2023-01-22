import 'dart:ui';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_auth/local_auth.dart';
import 'package:lottie/lottie.dart';
import 'package:gpass/services/auth/controller/auth_controller.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final LocalAuthentication auth = LocalAuthentication();
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  _SupportState supportState = _SupportState.unknown;

  String _authorized = 'Not Authorized';
  String _authorizedSignup = 'Not Authorized';
  bool _isAuthenticatingLogin = false;
  bool isAuthenticatingSignup = false;
  List deviceIdentifier = [];
  String deviceDetails = '';
  String weekend = 'weeknd';
  String dog = 'dog with bat wings';
  String beach = 'boy in beach';
  String messi = 'messi';
  String chess = 'chess';

  bool isDog = false;
  bool isBeach = false;
  bool isMessi = false;
  bool isWeeknd = false;
  bool isChess = false;
  bool is1 = false;
  bool is2 = false;
  bool is3 = false;
  bool is4 = false;
  bool is5 = false;
  bool is6 = false;
  bool is7 = false;
  bool is8 = false;
  bool is9 = false;
  bool select1 = false;
  bool select2 = false;
  bool select3 = false;
  bool select4 = false;
  bool select5 = false;
  bool select6 = false;
  bool select7 = false;
  bool select8 = false;
  bool select9 = false;
  bool gotDetails = false;
  bool isRookBlack1 = false;
  bool isKnightBlack1=false;
  bool isBishopBlack1 = false;
  TextEditingController nameController = TextEditingController();
  String name='';

  @override
  void initState() {
    super.initState();
    auth.isDeviceSupported().then(
          (bool isSupported) => setState(() => supportState = isSupported
              ? _SupportState.supported
              : _SupportState.unsupported),
        );
  }

  void signUp() {
    ref.read(authControllerProvider).signUp(
          context,
          name,
          
          deviceIdentifier,
          deviceDetails,
          isBeach? beach+_password.join("").toString():isMessi?messi+_password.join("").toString():isWeeknd?weekend+_password.join("").toString():isDog?dog+_password.join("").toString():chess+_password.join("").toString(),
        );
  }

  // void signin() {
  //   ref.read(authControllerProvider).signIn(context, deviceIdentifier, _password.join("").toString(), ref);
  // }


  Future<void> _authenticateWithBiometricsSignUp() async {
    bool authenticated = false;

    try {
      setState(() {
        isAuthenticatingSignup = true;
        _authorizedSignup = 'Authenticating';
      });
      authenticated = await auth.authenticate(
        localizedReason:
            'Scan your fingerprint (or face or whatever) to authenticate',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      if (authenticated) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        // AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        setState(() {
          deviceIdentifier.add( iosInfo.identifierForVendor.toString());
          deviceDetails = " Model: ${iosInfo.model.toString()} , System Version: ${iosInfo.systemVersion.toString()}";
          // deviceDetails = " Model: ${androidInfo.model.toString()} , System Version: ${androidInfo.brand.toString()}";
          // deviceIdentifier .add( androidInfo.id.toString());
        });
      } else {
        null;
      }
      setState(() {
        isAuthenticatingSignup = false;
        _authorizedSignup = 'Authenticating';
      });
    } on PlatformException catch (e) {
      setState(() {
        isAuthenticatingSignup = false;
        _authorizedSignup = 'Error - ${e.message}';
      });
      return;
    }
    if (!mounted) {
      return;
    }

    final String message = authenticated ? 'Authorized' : 'Not Authorized';
    setState(() {
      _authorizedSignup = message;
    });
  }

  Future<void> _cancelAuthentication() async {
    await auth.stopAuthentication();
    setState(() => _isAuthenticatingLogin = false);
  }

  Future<void> _cancelAuthenticationSignUp() async {
    await auth.stopAuthentication();
    setState(() => isAuthenticatingSignup = false);
  }

  final List<int> _password = [];
  final List<String> _imageListDog = [
    'assets/images/dog/9.png',
    'assets/images/dog/8.png',
    'assets/images/dog/7.png',
    'assets/images/dog/6.png',
    'assets/images/dog/5.png',
    'assets/images/dog/4.png',
    'assets/images/dog/3.png',
    'assets/images/dog/2.png',
    'assets/images/dog/1.png',
  ];
  final List<String> _imageListBeach = [
    'assets/images/beach/9.png',
    'assets/images/beach/8.png',
    'assets/images/beach/7.png',
    'assets/images/beach/6.png',
    'assets/images/beach/5.png',
    'assets/images/beach/4.png',
    'assets/images/beach/3.png',
    'assets/images/beach/2.png',
    'assets/images/beach/1.png',
  ];
  final List<String> _imageListMessi = [
    'assets/images/messi/9.png',
    'assets/images/messi/8.png',
    'assets/images/messi/7.png',
    'assets/images/messi/6.png',
    'assets/images/messi/5.png',
    'assets/images/messi/4.png',
    'assets/images/messi/3.png',
    'assets/images/messi/2.png',
    'assets/images/messi/1.png',
  ];
  final List<String> _imageListWeeknd = [
    'assets/images/weeknd/9.png',
    'assets/images/weeknd/8.png',
    'assets/images/weeknd/7.png',
    'assets/images/weeknd/6.png',
    'assets/images/weeknd/5.png',
    'assets/images/weeknd/4.png',
    'assets/images/weeknd/3.png',
    'assets/images/weeknd/2.png',
    'assets/images/weeknd/1.png',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: gotDetails?null: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        actions: [
         name.isEmpty?const SizedBox.shrink(): TextButton(onPressed: (){
            setState(() {
              gotDetails=true;
            });
          }, child: const Text('Next',style: TextStyle(color: Colors.white),))
        ],
      ),
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
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: SafeArea(
              child: Center(
                child: !gotDetails
                    ? Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Center(
                          child: TextFormField(
                            autofocus: true,
                            onChanged: (val){
                              setState(() {
                                name=val;
                              });
                            },
                            controller: nameController,
                            style:const TextStyle(color: Colors.white),
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              hintText: 'Full Name as per aadhar',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor:const Color.fromARGB(101, 255, 255, 255),
                            ),
                          ),
                        ),
                    )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 40,
                              right: 40,
                              top: 40,
                              bottom: 30,
                            ),
                            child: Container(
                              height: 40,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(103, 14, 127, 214),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: deviceIdentifier.isEmpty
                                      ? TextButton(
                                          onPressed: () {
                                            _authenticateWithBiometricsSignUp();
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const [
                                              Text(
                                                'Get Device Id',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              Icon(
                                                Icons.download,
                                                color: Colors.white,
                                              ),
                                            ],
                                          ))
                                      : Text(
                                          "Device Id : $deviceIdentifier",
                                          style: GoogleFonts.pressStart2p(
                                              textStyle: const TextStyle(
                                                  color: Colors.white),
                                              fontSize: 10),
                                        ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 40,
                              right: 40,
                              top: 0,
                              bottom: 30,
                            ),
                            child: InkWell(
                              onTap: () async {
                                await showDialog(
                                    context: context,
                                    builder: (context) {
                                      return StatefulBuilder(
                                        builder:
                                            (BuildContext context, setState) {
                                          return AlertDialog(
                                            backgroundColor: Colors.transparent,
                                            content: Container(
                                              height: 500,
                                              width: 300,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: const Color.fromARGB(
                                                    73, 255, 255, 255),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 40,
                                                            right: 40),
                                                    child: Container(
                                                      height: 60,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      decoration: BoxDecoration(
                                                        color: const Color
                                                                .fromARGB(
                                                            103, 14, 127, 214),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Center(
                                                        child: CheckboxListTile(
                                                          controlAffinity:
                                                              ListTileControlAffinity
                                                                  .leading,
                                                          value: isDog,
                                                          onChanged: (val) =>
                                                              setState(() {
                                                            isDog = val!;
                                                            if (val == true) {
                                                              isBeach = false;
                                                              isMessi = false;
                                                              isWeeknd = false;
                                                              isChess=false;
                                                            }
                                                          }),
                                                          title: Center(
                                                              child: Text(
                                                            'Dog with bat wings',
                                                            style: GoogleFonts.pressStart2p(
                                                                textStyle: const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        10)),
                                                          )),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 40,
                                                            right: 40),
                                                    child: Container(
                                                      height: 60,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      decoration: BoxDecoration(
                                                        color: const Color
                                                                .fromARGB(
                                                            103, 14, 127, 214),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Center(
                                                        child: CheckboxListTile(
                                                          controlAffinity:
                                                              ListTileControlAffinity
                                                                  .leading,
                                                          value: isBeach,
                                                          onChanged: (val) =>
                                                              setState(() {
                                                            isBeach = val!;
                                                            if (val == true) {
                                                              isDog = false;
                                                              isMessi = false;
                                                              isWeeknd = false;
                                                              isChess=false;
                                                            }
                                                          }),
                                                          title: Center(
                                                              child: Text(
                                                            'Boy in Beach',
                                                            style: GoogleFonts.pressStart2p(
                                                                textStyle: const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        10)),
                                                          )),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 40,
                                                            right: 40),
                                                    child: Container(
                                                      height: 60,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      decoration: BoxDecoration(
                                                        color: const Color
                                                                .fromARGB(
                                                            103, 14, 127, 214),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Center(
                                                        child: CheckboxListTile(
                                                          controlAffinity:
                                                              ListTileControlAffinity
                                                                  .leading,
                                                          value: isMessi,
                                                          onChanged: (val) =>
                                                              setState(() {
                                                            isMessi = val!;
                                                            if (val == true) {
                                                              isDog = false;
                                                              isBeach = false;
                                                              isWeeknd = false;
                                                              isChess=false;
                                                            }
                                                          }),
                                                          title: Center(
                                                              child: Text(
                                                            'Messi',
                                                            style: GoogleFonts.pressStart2p(
                                                                textStyle: const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        10)),
                                                          )),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 40,
                                                            right: 40),
                                                    child: Container(
                                                      height: 60,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      decoration: BoxDecoration(
                                                        color: const Color
                                                                .fromARGB(
                                                            103, 14, 127, 214),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Center(
                                                        child: CheckboxListTile(
                                                          controlAffinity:
                                                              ListTileControlAffinity
                                                                  .leading,
                                                          value: isWeeknd,
                                                          onChanged: (val) =>
                                                              setState(() {
                                                            isWeeknd = val!;
                                                            if (val == true) {
                                                              isDog = false;
                                                              isBeach = false;
                                                              isMessi = false;
                                                              isChess=false;
                                                            }
                                                          }),
                                                          title: Center(
                                                              child: Text(
                                                            'The Weeknd',
                                                            style: GoogleFonts.pressStart2p(
                                                                textStyle: const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        10)),
                                                          )),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 40,
                                                            right: 40),
                                                    child: Container(
                                                      height: 60,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      decoration: BoxDecoration(
                                                        color: const Color
                                                                .fromARGB(
                                                            103, 14, 127, 214),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Center(
                                                        child: CheckboxListTile(
                                                          controlAffinity:
                                                              ListTileControlAffinity
                                                                  .leading,
                                                          value: isChess,
                                                          onChanged: (val) =>
                                                              setState(() {
                                                            isChess = val!;
                                                            if (val == true) {
                                                              isDog = false;
                                                              isMessi = false;
                                                              isWeeknd = false;
                                                              isBeach=false;
                                                            }
                                                          }),
                                                          title: Center(
                                                              child: Text(
                                                            'Chess',
                                                            style: GoogleFonts.pressStart2p(
                                                                textStyle: const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        10)),
                                                          )),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            actions: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 40, right: 40),
                                                child: InkWell(
                                                  onTap: () {
                                                    _password.clear();
                                                    is1 = false;
                                                    is2 = false;
                                                    is3 = false;
                                                    is4 = false;
                                                    is5 = false;
                                                    is6 = false;
                                                    is7 = false;
                                                    is8 = false;
                                                    is9 = false;
                                                    

                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    height: 60,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          const Color.fromARGB(
                                                              103, 14, 214, 87),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Center(
                                                        child: Text(
                                                      'Confirm',
                                                      style: GoogleFonts.pressStart2p(
                                                          textStyle:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      10)),
                                                    )),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    });
                                setState(() {});
                              },
                              child: Container(
                                height: 40,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(103, 14, 127, 214),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      "Select the type of Image",
                                      style: GoogleFonts.pressStart2p(
                                          textStyle: const TextStyle(
                                              color: Colors.white),
                                          fontSize: 10),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          isDog == false &&
                                  isBeach == false &&
                                  isMessi == false &&
                                  isWeeknd == false && isChess==false
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 100),
                                  child: SizedBox(
                                      height: 300,
                                      child: Lottie.asset('assets/images/animations/empty.json')),
                                )
                              : isChess?
                              Padding(padding: const EdgeInsets.all(10),child: Column(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(right:0.0),
                                            child: InkWell(
                                              onTap: (){
                                                setState(() {
                                                  isRookBlack1 = !isRookBlack1;
                                                });
                                              },
                                              child: Stack(
                                                children: [
                                                  Container(
                                                    height: 45,
                                                    width: 45,
                                                    decoration: const BoxDecoration(
                                                      color: Colors.white,
                                                      image: DecorationImage(image: AssetImage('assets/images/chess/rookBlack1.png'))
                                                    ),
                                                  ),
                                                 isRookBlack1? Container(
                                                    height: 45,
                                                    width: 45,
                                                    decoration: const BoxDecoration(
                                                      color: Color.fromARGB(210, 255, 255, 255),
                                                      
                                                    ),
                                                    child:const Icon(Icons.done,color: Colors.white,),
                                                  ):const SizedBox.shrink(),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right:0.0),
                                            child: InkWell(
                                              onTap: (){
                                                setState(() {
                                                  isKnightBlack1 = !isKnightBlack1;
                                                });
                                              },
                                              child: Stack(
                                                children: [
                                                  Container(
                                                    height: 45,
                                                    width: 45,
                                                    decoration: const BoxDecoration(
                                                      color: Color.fromARGB(81, 0, 0, 0),
                                                      image: DecorationImage(image: AssetImage('assets/images/chess/knightBlack1.png'))
                                                    ),
                                                  ),
                                                 isKnightBlack1? Container(
                                                    height: 45,
                                                    width: 45,
                                                    decoration: const BoxDecoration(
                                                      color: Color.fromARGB(210, 255, 255, 255),
                                                      
                                                    ),
                                                    child:const Icon(Icons.done,color: Colors.white,),
                                                  ):const SizedBox.shrink(),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right:0.0),
                                            child: InkWell(
                                              onTap: (){
                                                setState(() {
                                                  isBishopBlack1 = !isBishopBlack1;
                                                });
                                              },
                                              child: Stack(
                                                children: [
                                                  Container(
                                                    height: 45,
                                                    width: 45,
                                                    decoration: const BoxDecoration(
                                                      color: Colors.white,
                                                      image: DecorationImage(image: AssetImage('assets/images/chess/bishopBlack1.png'))
                                                    ),
                                                  ),
                                                 isBishopBlack1? Container(
                                                    height: 45,
                                                    width: 45,
                                                    decoration: const BoxDecoration(
                                                      color: Color.fromARGB(210, 255, 255, 255),
                                                      
                                                    ),
                                                    child:const Icon(Icons.done,color: Colors.white,),
                                                  ):const SizedBox.shrink(),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right:0.0),
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              decoration: const BoxDecoration(
                                                color: Color.fromARGB(81, 0, 0, 0),
                                                image: DecorationImage(image: AssetImage('assets/images/chess/queenBlack.png'))
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right:0.0),
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                image: DecorationImage(image: AssetImage('assets/images/chess/kingBlack.png'))
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right:0.0),
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              decoration: const BoxDecoration(
                                                color: Color.fromARGB(81, 0, 0, 0),
                                                image: DecorationImage(image: AssetImage('assets/images/chess/bishopBlack2.png'))
                                              ),
                                            ),
                                          ),Padding(
                                            padding: const EdgeInsets.only(right:0.0),
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                image: DecorationImage(image: AssetImage('assets/images/chess/knightBlack2.png'))
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right:0.0),
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              decoration: const BoxDecoration(
                                                color: Color.fromARGB(81, 0, 0, 0),
                                                image: DecorationImage(image: AssetImage('assets/images/chess/rookBlack2.png'))
                                              ),
                                            ),
                                          ),
                                          
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(right:0.0),
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              decoration: const BoxDecoration(
                                                color: Color.fromARGB(81, 0, 0, 0),
                                                image: DecorationImage(image: AssetImage('assets/images/chess/pawnBlack.png'))
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right:0.0),
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                image: DecorationImage(image: AssetImage('assets/images/chess/pawnBlack.png'))
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right:0.0),
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              decoration: const BoxDecoration(
                                                color: Color.fromARGB(81, 0, 0, 0),
                                                image: DecorationImage(image: AssetImage('assets/images/chess/pawnBlack.png'))
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right:0.0),
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                image: DecorationImage(image: AssetImage('assets/images/chess/pawnBlack.png'))
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right:0.0),
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              decoration: const BoxDecoration(
                                                color: Color.fromARGB(81, 0, 0, 0),
                                                image: DecorationImage(image: AssetImage('assets/images/chess/pawnBlack.png'))
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right:0.0),
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                image: DecorationImage(image: AssetImage('assets/images/chess/pawnBlack.png'))
                                              ),
                                            ),
                                          ),Padding(
                                            padding: const EdgeInsets.only(right:0.0),
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              decoration: const BoxDecoration(
                                                color: Color.fromARGB(81, 0, 0, 0),
                                                image: DecorationImage(image: AssetImage('assets/images/chess/pawnBlack.png'))
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right:0.0),
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                image: DecorationImage(image: AssetImage('assets/images/chess/pawnBlack.png'))
                                              ),
                                            ),
                                          ),
                                          
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(right:0.0),
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right:0.0),
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              decoration: const BoxDecoration(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right:0.0),
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right:0.0),
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              decoration: const BoxDecoration(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right:0.0),
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right:0.0),
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              decoration: const BoxDecoration(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),Padding(
                                            padding: const EdgeInsets.only(right:0.0),
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right:0.0),
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              decoration: const BoxDecoration(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(right:0.0),
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              decoration: const BoxDecoration(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right:0.0),
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right:0.0),
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              decoration: const BoxDecoration(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right:0.0),
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right:0.0),
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              decoration: const BoxDecoration(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right:0.0),
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),Padding(
                                            padding: const EdgeInsets.only(right:0.0),
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              decoration: const BoxDecoration(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right:0.0),
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(right:0.0),
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right:0.0),
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              decoration: const BoxDecoration(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right:0.0),
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right:0.0),
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              decoration: const BoxDecoration(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right:0.0),
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right:0.0),
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              decoration: const BoxDecoration(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),Padding(
                                            padding: const EdgeInsets.only(right:0.0),
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right:0.0),
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              decoration: const BoxDecoration(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(right:0.0),
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              decoration: const BoxDecoration(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right:0.0),
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right:0.0),
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              decoration: const BoxDecoration(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right:0.0),
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right:0.0),
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              decoration: const BoxDecoration(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right:0.0),
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),Padding(
                                            padding: const EdgeInsets.only(right:0.0),
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              decoration: const BoxDecoration(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right:0.0),
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(right:0.0),
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                image: DecorationImage(image: AssetImage('assets/images/chess/pawnWhite.png'))
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right:0.0),
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              decoration: const BoxDecoration(
                                                color: Colors.black,
                                                image: DecorationImage(image: AssetImage('assets/images/chess/pawnWhite.png'))
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right:0.0),
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                image: DecorationImage(image: AssetImage('assets/images/chess/pawnWhite.png'))
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right:0.0),
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              decoration: const BoxDecoration(
                                                color: Colors.black,
                                                image: DecorationImage(image: AssetImage('assets/images/chess/pawnWhite.png'))
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right:0.0),
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                image: DecorationImage(image: AssetImage('assets/images/chess/pawnWhite.png'))
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right:0.0),
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              decoration: const BoxDecoration(
                                                color: Colors.black,
                                                image: DecorationImage(image: AssetImage('assets/images/chess/pawnWhite.png'))
                                              ),
                                            ),
                                          ),Padding(
                                            padding: const EdgeInsets.only(right:0.0),
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                image: DecorationImage(image: AssetImage('assets/images/chess/pawnWhite.png'))
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right:0.0),
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              decoration: const BoxDecoration(
                                                color: Colors.black,
                                                image: DecorationImage(image: AssetImage('assets/images/chess/pawnWhite.png'))
                                              ),
                                            ),
                                          ),
                                          
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(right:0.0),
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              decoration: const BoxDecoration(
                                                color: Color.fromARGB(81, 0, 0, 0),
                                                image: DecorationImage(image: AssetImage('assets/images/chess/rookWhite1.png'))
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right:0.0),
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                image: DecorationImage(image: AssetImage('assets/images/chess/knightWhite1.png'))
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right:0.0),
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              decoration: const BoxDecoration(
                                                color: Color.fromARGB(81, 0, 0, 0),
                                                image: DecorationImage(image: AssetImage('assets/images/chess/bishopWhite1.png'))
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right:0.0),
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                image: DecorationImage(image: AssetImage('assets/images/chess/queenWhite.png'))
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right:0.0),
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              decoration: const BoxDecoration(
                                                color: Color.fromARGB(81, 0, 0, 0),
                                                image: DecorationImage(image: AssetImage('assets/images/chess/kingWhite.png'))
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right:0.0),
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                image: DecorationImage(image: AssetImage('assets/images/chess/bishopWhite2.png'))
                                              ),
                                            ),
                                          ),Padding(
                                            padding: const EdgeInsets.only(right:0.0),
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              decoration: const  BoxDecoration(
                                                color: Color.fromARGB(81, 0, 0, 0),
                                                image: DecorationImage(image: AssetImage('assets/images/chess/knightWhite2.png'))
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right:0.0),
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              decoration: const  BoxDecoration(
                                                color: Colors.white,
                                                image: DecorationImage(image: AssetImage('assets/images/chess/rookWhite2.png'))
                                              ),
                                            ),
                                          ),
                                          
                                        ],
                                      ),
                                      
                                    ],
                                  ),
                                ],
                              ),): Padding(
                                  padding: const EdgeInsets.only(
                                      top: 0, left: 10, right: 10),
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.width,
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 7),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 7),
                                                child: InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      is1 = !is1;
                                                    });

                                                    _password.contains(0)
                                                        ? _password.remove(0)
                                                        : _password.add(0);
                                                  },
                                                  child: Stack(
                                                    children: [
                                                      SizedBox(
                                                          height: 115,
                                                          width: 115,
                                                          child: isDog
                                                              ? Image.asset(
                                                                  'assets/images/dog/9.png')
                                                              : isBeach
                                                                  ? Image.asset(
                                                                      'assets/images/beach/9.png')
                                                                  : isMessi
                                                                      ? Image.asset(
                                                                          'assets/images/messi/9.png')
                                                                      : Image.asset(
                                                                          'assets/images/weeknd/9.png')),
                                                      is1
                                                          ? Container(
                                                              height: 115,
                                                              width: 115,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                color: Color
                                                                    .fromARGB(
                                                                        91,
                                                                        255,
                                                                        255,
                                                                        255),
                                                              ),
                                                              child: const Icon(
                                                                Icons.done,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            )
                                                          : const SizedBox
                                                              .shrink(),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 7),
                                                child: InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      is2 = !is2;
                                                    });
                                                    _password.contains(1)
                                                        ? _password.remove(1)
                                                        : _password.add(1);
                                                  },
                                                  child: Stack(
                                                    children: [
                                                      SizedBox(
                                                          height: 115,
                                                          width: 115,
                                                          child: isDog
                                                              ? Image.asset(
                                                                  'assets/images/dog/8.png')
                                                              : isBeach
                                                                  ? Image.asset(
                                                                      'assets/images/beach/8.png')
                                                                  : isMessi
                                                                      ? Image.asset(
                                                                          'assets/images/messi/8.png')
                                                                      : Image.asset(
                                                                          'assets/images/weeknd/8.png')),
                                                      is2
                                                          ? Container(
                                                              height: 115,
                                                              width: 115,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                color: Color
                                                                    .fromARGB(
                                                                        91,
                                                                        255,
                                                                        255,
                                                                        255),
                                                              ),
                                                              child: const Icon(
                                                                Icons.done,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            )
                                                          : const SizedBox
                                                              .shrink(),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    is3 = !is3;
                                                  });
                                                  _password.contains(2)
                                                      ? _password.remove(2)
                                                      : _password.add(2);
                                                },
                                                child: Stack(
                                                  children: [
                                                    SizedBox(
                                                        height: 115,
                                                        width: 115,
                                                        child: isDog
                                                            ? Image.asset(
                                                                'assets/images/dog/7.png')
                                                            : isBeach
                                                                ? Image.asset(
                                                                    'assets/images/beach/7.png')
                                                                : isMessi
                                                                    ? Image.asset(
                                                                        'assets/images/messi/7.png')
                                                                    : Image.asset(
                                                                        'assets/images/weeknd/7.png')),
                                                    is3
                                                        ? Container(
                                                            height: 115,
                                                            width: 115,
                                                            decoration:
                                                                const BoxDecoration(
                                                              color: Color
                                                                  .fromARGB(
                                                                      91,
                                                                      255,
                                                                      255,
                                                                      255),
                                                            ),
                                                            child: const Icon(
                                                              Icons.done,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          )
                                                        : const SizedBox
                                                            .shrink(),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 7),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 7.0),
                                                child: InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      is4 = !is4;
                                                    });
                                                    _password.contains(3)
                                                        ? _password.remove(3)
                                                        : _password.add(3);
                                                  },
                                                  child: Stack(
                                                    children: [
                                                      SizedBox(
                                                          height: 115,
                                                          width: 115,
                                                          child: isDog
                                                              ? Image.asset(
                                                                  'assets/images/dog/6.png')
                                                              : isBeach
                                                                  ? Image.asset(
                                                                      'assets/images/beach/6.png')
                                                                  : isMessi
                                                                      ? Image.asset(
                                                                          'assets/images/messi/6.png')
                                                                      : Image.asset(
                                                                          'assets/images/weeknd/6.png')),
                                                      is4
                                                          ? Container(
                                                              height: 115,
                                                              width: 115,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                color: Color
                                                                    .fromARGB(
                                                                        91,
                                                                        255,
                                                                        255,
                                                                        255),
                                                              ),
                                                              child: const Icon(
                                                                Icons.done,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            )
                                                          : const SizedBox
                                                              .shrink(),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 7.0),
                                                child: InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      is5 = !is5;
                                                    });
                                                    _password.contains(4)
                                                        ? _password.remove(4)
                                                        : _password.add(4);
                                                  },
                                                  child: Stack(
                                                    children: [
                                                      SizedBox(
                                                          height: 115,
                                                          width: 115,
                                                          child: isDog
                                                              ? Image.asset(
                                                                  'assets/images/dog/5.png')
                                                              : isBeach
                                                                  ? Image.asset(
                                                                      'assets/images/beach/5.png')
                                                                  : isMessi
                                                                      ? Image.asset(
                                                                          'assets/images/messi/5.png')
                                                                      : Image.asset(
                                                                          'assets/images/weeknd/5.png')),
                                                      is5
                                                          ? Container(
                                                              height: 115,
                                                              width: 115,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                color: Color
                                                                    .fromARGB(
                                                                        91,
                                                                        255,
                                                                        255,
                                                                        255),
                                                              ),
                                                              child: const Icon(
                                                                Icons.done,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            )
                                                          : const SizedBox
                                                              .shrink(),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    is6 = !is6;
                                                  });
                                                  _password.contains(5)
                                                      ? _password.remove(5)
                                                      : _password.add(5);
                                                },
                                                child: Stack(
                                                  children: [
                                                    SizedBox(
                                                        height: 115,
                                                        width: 115,
                                                        child: isDog
                                                            ? Image.asset(
                                                                'assets/images/dog/4.png')
                                                            : isBeach
                                                                ? Image.asset(
                                                                    'assets/images/beach/4.png')
                                                                : isMessi
                                                                    ? Image.asset(
                                                                        'assets/images/messi/4.png')
                                                                    : Image.asset(
                                                                        'assets/images/weeknd/4.png')),
                                                    is6
                                                        ? Container(
                                                            height: 115,
                                                            width: 115,
                                                            decoration:
                                                                const BoxDecoration(
                                                              color: Color
                                                                  .fromARGB(
                                                                      91,
                                                                      255,
                                                                      255,
                                                                      255),
                                                            ),
                                                            child: const Icon(
                                                              Icons.done,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          )
                                                        : const SizedBox
                                                            .shrink(),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 7),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 7.0),
                                                child: InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      is7 = !is7;
                                                    });
                                                    _password.contains(6)
                                                        ? _password.remove(6)
                                                        : _password.add(6);
                                                  },
                                                  child: Stack(
                                                    children: [
                                                      SizedBox(
                                                          height: 115,
                                                          width: 115,
                                                          child: isDog
                                                              ? Image.asset(
                                                                  'assets/images/dog/3.png')
                                                              : isBeach
                                                                  ? Image.asset(
                                                                      'assets/images/beach/3.png')
                                                                  : isMessi
                                                                      ? Image.asset(
                                                                          'assets/images/messi/3.png')
                                                                      : Image.asset(
                                                                          'assets/images/weeknd/3.png')),
                                                      is7
                                                          ? Container(
                                                              height: 115,
                                                              width: 115,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                color: Color
                                                                    .fromARGB(
                                                                        91,
                                                                        255,
                                                                        255,
                                                                        255),
                                                              ),
                                                              child: const Icon(
                                                                Icons.done,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            )
                                                          : const SizedBox
                                                              .shrink(),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 7.0),
                                                child: InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      is8 = !is8;
                                                    });
                                                    _password.contains(7)
                                                        ? _password.remove(7)
                                                        : _password.add(7);
                                                  },
                                                  child: Stack(
                                                    children: [
                                                      SizedBox(
                                                          height: 115,
                                                          width: 115,
                                                          child: isDog
                                                              ? Image.asset(
                                                                  'assets/images/dog/2.png')
                                                              : isBeach
                                                                  ? Image.asset(
                                                                      'assets/images/beach/2.png')
                                                                  : isMessi
                                                                      ? Image.asset(
                                                                          'assets/images/messi/2.png')
                                                                      : Image.asset(
                                                                          'assets/images/weeknd/2.png')),
                                                      is8
                                                          ? Container(
                                                              height: 115,
                                                              width: 115,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                color: Color
                                                                    .fromARGB(
                                                                        91,
                                                                        255,
                                                                        255,
                                                                        255),
                                                              ),
                                                              child: const Icon(
                                                                Icons.done,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            )
                                                          : const SizedBox
                                                              .shrink(),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    is9 = !is9;
                                                  });
                                                  _password.contains(8)
                                                      ? _password.remove(8)
                                                      : _password.add(8);
                                                },
                                                child: Stack(
                                                  children: [
                                                    SizedBox(
                                                        height: 115,
                                                        width: 115,
                                                        child: isDog
                                                            ? Image.asset(
                                                                'assets/images/dog/1.png')
                                                            : isBeach
                                                                ? Image.asset(
                                                                    'assets/images/beach/1.png')
                                                                : isMessi
                                                                    ? Image.asset(
                                                                        'assets/images/messi/1.png')
                                                                    : Image.asset(
                                                                        'assets/images/weeknd/1.png')),
                                                    is9
                                                        ? Container(
                                                            height: 115,
                                                            width: 115,
                                                            decoration:
                                                                const BoxDecoration(
                                                              color: Color
                                                                  .fromARGB(
                                                                      91,
                                                                      255,
                                                                      255,
                                                                      255),
                                                            ),
                                                            child: const Icon(
                                                              Icons.done,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          )
                                                        : const SizedBox
                                                            .shrink(),
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
                          const Spacer(),
                          Center(
                            child: Column(
                              children: [
                                Text(
                                  'Image: ${isDog ? 'Dog With Bat Wings' : isBeach ? 'Boy in Beach' : isMessi ? 'Messi' : isWeeknd? 'The Weeknd':isChess?'Chess': 'Empty'}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                 _password.join("").isEmpty?'Order: Empty': 'Order: ${_password.join("")}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 40,
                              right: 40,
                              top: 40,
                              bottom: 30,
                            ),
                            child: InkWell(
                              onTap: () {
                                final snackBar = SnackBar(
                                  content: Text(
                                   deviceIdentifier.isEmpty?'required:Device ID':_password.join("").length<9? 'Must select all 9 images':deviceIdentifier.isEmpty&&_password.join("").isEmpty?'required:Device ID & Must select all 9 images':'image: ${isDog ? 'Dog With Bat Wings' : isBeach ? 'Boy in Beach' : isMessi ? 'Messi' : isWeeknd? 'The Weeknd':isChess?'Chess': 'Empty'} Order: ${_password.join("")}',
                                    style: TextStyle(color: Colors.red),
                                    textAlign: TextAlign.center,
                                  ),
                                );

                                deviceIdentifier.isNotEmpty&&_password.join("").length==9?signUp(): ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                

                                
                                    
                              },
                              child: Container(
                                height: 40,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: _password.join("").length < 9
                                      ? Colors.grey
                                      : const Color.fromARGB(103, 14, 127, 214),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      "Complete",
                                      style: GoogleFonts.pressStart2p(
                                          textStyle: const TextStyle(
                                              color: Colors.white),
                                          fontSize: 10),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum _SupportState {
  unknown,
  supported,
  unsupported,
}
