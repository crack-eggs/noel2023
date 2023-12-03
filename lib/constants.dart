// lib/constants.dart
import 'package:google_sign_in_platform_interface/google_sign_in_platform_interface.dart';
import 'package:google_sign_in_web/google_sign_in_web.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


// Supabase Constants
final supabase = SupabaseClient(
  'https://urdghqpqgkdhmcoecmyb.supabase.co',
  'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVyZGdocXBxZ2tkaG1jb2VjbXliIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDExMzUyMTMsImV4cCI6MjAxNjcxMTIxM30.cZM2G8RvkA0CzznAAZNi7sGc0QDDviCQ7jjWRHpAUeU',
);

// Supabase Realtime Channel
final gameChannel = supabase.channel('game',
    opts: const RealtimeChannelConfig(self: true, ack: true));

final GoogleSignInPlugin googleSignIn =
GoogleSignInPlatform.instance as GoogleSignInPlugin;