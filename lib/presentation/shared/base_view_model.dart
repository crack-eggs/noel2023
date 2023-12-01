import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../enums.dart';
import '../../service/navigator_service.dart';

abstract class BaseViewModel extends ChangeNotifier {
  BaseViewModel(this.supabase, this.navigatorService);

  ViewState _state = ViewState.idle;

  ViewState get state => _state;

  /// Change state notify to view for rebuild component.
  void setState(ViewState viewState) {
    if (state != ViewState.dispose) {
      _state = viewState;
      notifyListeners();
    }
  }

  final SupabaseClient supabase;
  final NavigationService navigatorService;
}
