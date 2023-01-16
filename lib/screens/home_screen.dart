import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gpass/providers/user_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            height: 400,
            width: MediaQuery.of(context).size.width,
            decoration:  BoxDecoration(
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
                    child: Icon(Icons.face,color: Colors.black,size: 40,),
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.tealAccent,
                      borderRadius: BorderRadius.circular(30),
                                          ),
                    child:  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(child:  Text('Name: ${user.user.name}',style: const TextStyle(color: Colors.black),)),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.tealAccent,
                      borderRadius: BorderRadius.circular(30),
                                          ),
                    child:  Padding(
                      padding:const  EdgeInsets.all(8.0),
                      child: Center(child:  Text('Hashed Password: ${user.user.password}',style: const TextStyle(color: Colors.black),)),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.tealAccent,
                      borderRadius: BorderRadius.circular(30),
                                          ),
                    child:const  Padding(
                      padding:  EdgeInsets.all(8.0),
                      child: Center(child:  Text('CSE 6C',style: TextStyle(color: Colors.black),)),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.tealAccent,
                      borderRadius: BorderRadius.circular(30),
                                          ),
                    child:const  Padding(
                      padding:  EdgeInsets.all(8.0),
                      child: Center(child:  Text('Hindustan University',style: TextStyle(color: Colors.black),)),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.tealAccent,
                      borderRadius: BorderRadius.circular(30),
                                          ),
                    child:  Padding(
                      padding:const  EdgeInsets.all(8.0),
                      child: Center(child:  Text('Device Id: ${user.user.deviceId}',style: const TextStyle(color: Colors.black),)),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.tealAccent,
                      borderRadius: BorderRadius.circular(30),
                                          ),
                    child:  Padding(
                      padding:const  EdgeInsets.all(8.0),
                      child: Center(child:  Text(user.user.deviceDetails,style: const TextStyle(color: Colors.black),)),
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
}