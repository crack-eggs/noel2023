import 'package:supabase_flutter/supabase_flutter.dart';

class RealtimeService {
  final SupabaseClient supabaseClient;
  final RealtimeChannelConfig config;

  late RealtimeChannel _channel;

  RealtimeService({required this.supabaseClient, required this.config}){
    connectToChannel('game');
  }


  void connectToChannel(String channelName) {
    _channel = supabaseClient.channel(channelName, opts: config);
    _channel.subscribe();
  }

  void disconnectFromChannel() {
    _channel.unsubscribe();
  }
  RealtimeChannel get channel => _channel;
}
