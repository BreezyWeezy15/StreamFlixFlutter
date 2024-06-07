import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/utils.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5),(){
      Get.offNamed(Utils.homeRoute);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Image.asset("assets/images/logo.png",filterQuality: FilterQuality.high,height: 250,width: 250,),
        ),
      ),
    );
  }
}
