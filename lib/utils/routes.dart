import 'package:adv_exam/screen/home/view/home_screen.dart';
import 'package:adv_exam/screen/liked/liked_screen.dart';
import 'package:adv_exam/screen/splash/splash_screen.dart';
import 'package:flutter/material.dart';

Map<String,WidgetBuilder> app_routes={
  '/':(context)=> const SplashScreen(),
  'home':(context)=> const HomeScreen(),
  'like':(context)=> const LikedScreen(),
};