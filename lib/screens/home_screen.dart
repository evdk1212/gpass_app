import 'dart:convert';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gpass/providers/user_provider.dart';
import 'package:gpass/services/auth/controller/auth_controller.dart';
import 'package:gpass/utils.dart';
import 'package:local_auth/local_auth.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:scan/scan.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final LocalAuthentication auth = LocalAuthentication();
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  _SupportState supportState = _SupportState.unknown;
  ScanController controller = ScanController();
  bool authenticated = false;
  bool isScanMode=false;
  String _authorized = 'Not Authorized';
  String _authorizedSignup = 'Not Authorized';
  bool _isAuthenticatingLogin = false;
  bool isAuthenticatingSignup = false;
  String deviceIdentifier = "";
  String newDeviceIdentifier = '';
  String _platformVersion = 'Unknown';

  void addNewDevice() {
    ref.read(authControllerProvider).addNewDevice(context, deviceIdentifier, newDeviceIdentifier, ref);
  }
  
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }
  Future<void> initPlatformState() async {
    String platformVersion;
    try {
      platformVersion = await Scan.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }
  Future<void> _authenticateWithBiometricsHomeScreen() async {
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
        //AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        setState(() {
          deviceIdentifier = iosInfo.identifierForVendor.toString();

          //deviceIdentifier = androidInfo.id.toString();
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

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userRepositoryProvider);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color.fromARGB(105, 0, 0, 0),
        title: const Text('Gpass Home'),
        centerTitle: true,
      ),
      body:isScanMode?SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ScanView(
                controller: controller,
                scanAreaScale: .7,
                scanLineColor: Colors.green,
                onCapture: (data) async{
                 setState(() {
                   newDeviceIdentifier=data;
                 });
                 deviceIdentifier.isNotEmpty&&newDeviceIdentifier.isNotEmpty ?addNewDevice():null;
                 setState(() {
                   isScanMode=false;
                 });

                
                 
                },
              ),
      ): Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(19, 255, 255, 255),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.tealAccent,
                        child: Icon(
                          Icons.face,
                          color: Colors.black,
                          size: 40,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.tealAccent,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                              child: Text(
                            'Name: ${user.user.name}',
                            style: const TextStyle(color: Colors.black),
                          )),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.tealAccent,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                              child: Text(
                            'Hashed Password: ${user.user.password}',
                            style: const TextStyle(color: Colors.black),
                          )),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.tealAccent,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                              child: Text(
                            'CSE 6C',
                            style: TextStyle(color: Colors.black),
                          )),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.tealAccent,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                              child: Text(
                            'Hindustan University',
                            style: TextStyle(color: Colors.black),
                          )),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.tealAccent,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                              child: Text(
                            'Device Id: ${user.user.deviceId}',
                            style: const TextStyle(color: Colors.black),
                          )),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.tealAccent,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                              child: Text(
                            user.user.deviceDetails,
                            style: const TextStyle(color: Colors.black),
                          )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () async {
                    await _authenticateWithBiometricsHomeScreen().then((value) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return StatefulBuilder(
                              builder: (BuildContext context, setState) {
                                return AlertDialog(
                                  content: Container(
                                    height: 300,
                                    width: 500,
                                    decoration: const BoxDecoration(
                                      color: Colors.transparent,
                                    ),
                                    child: QrImage(
                                      data: deviceIdentifier,
                                      version: QrVersions.auto,
                                      size: 200.0,
                                    ),
                                  ),
                                );
                              },
                            );
                          });
                    });
                  },
                  child: Column(
                    children: const [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.tealAccent,
                        child: Icon(
                          Icons.qr_code,
                          color: Colors.black,
                          size: 40,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "My DeviceId",
                        style: TextStyle(color: Colors.teal),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                InkWell(
                  onTap: ()async {

                     IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        //AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        setState(() {
          deviceIdentifier = iosInfo.identifierForVendor.toString();
          isScanMode=true;
          });
                  


                 
                    
                  },
                  child: Column(
                    children: const [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.tealAccent,
                        child: Icon(
                          Icons.add,
                          color: Colors.black,
                          size: 40,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Add New Device",
                        style: TextStyle(color: Colors.teal),
                      )
                    ],
                  ),
                ),
              ],
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
