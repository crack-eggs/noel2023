// lib/constants.dart
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_sign_in_platform_interface/google_sign_in_platform_interface.dart';
import 'package:google_sign_in_web/google_sign_in_web.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/foundation.dart';

final isWebMobile = kIsWeb &&
    (defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.android);

// Supabase Constants
final supabase = SupabaseClient(
  'https://urdghqpqgkdhmcoecmyb.supabase.co',
  'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVyZGdocXBxZ2tkaG1jb2VjbXliIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDExMzUyMTMsImV4cCI6MjAxNjcxMTIxM30.cZM2G8RvkA0CzznAAZNi7sGc0QDDviCQ7jjWRHpAUeU',
);

final GoogleSignInPlugin googleSignIn =
    GoogleSignInPlatform.instance as GoogleSignInPlugin;

const Color primaryColor = Color(0xFFBD0F72);

String colorToastError = 'linear-gradient(to right, #BD0F72, #BD0F72)';

final wishLists = [
  "Merry Christmas and joyful cheer!",
  "Wishing you festive joy!",
  "Peace, love, and Christmas delight!",
  "Season's greetings and happiness!",
  "Celebrate with joy and warmth!",
  "Merry Christmas to all!",
  "Cheers to holiday happiness!",
  "Warmest wishes for Christmas!",
  "Jingle all the way!",
  "Sending festive joy your way!"
];

final eggPaths = [
  'assets/home/egg_center_1.png',
  'assets/home/egg_center_2.png',
  'assets/home/egg_center_3.png',
  'assets/home/egg_center_4.png',
  'assets/home/egg_center_5.png',
];

String randomEggPath() {
  return eggPaths[Random().nextInt(eggPaths.length)];
}
