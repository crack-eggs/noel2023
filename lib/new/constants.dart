// lib/constants.dart
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Google Sign-In Constants
final GoogleSignIn googleSignIn = GoogleSignIn(
  clientId:
  '611515699584-rh1qbc05q7df5beuajssulpqk7qjgqik.apps.googleusercontent.com',
  scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

// Supabase Constants
final supabase = SupabaseClient(
  'https://urdghqpqgkdhmcoecmyb.supabase.co',
  'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVyZGdocXBxZ2tkaG1jb2VjbXliIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDExMzUyMTMsImV4cCI6MjAxNjcxMTIxM30.cZM2G8RvkA0CzznAAZNi7sGc0QDDviCQ7jjWRHpAUeU',
);

// Supabase Realtime Channel
final gameChannel = supabase.channel('game',
    opts: const RealtimeChannelConfig(self: true, ack: true));
