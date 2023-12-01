
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../di/injection.dart';
import 'base_view_model.dart';

mixin VMState<T extends BaseViewModel, X extends StatefulWidget> on State<X> {
  T viewModel = sl<T>();
  bool isReady = false;

  void onVMReady(T viewModel, BuildContext context);

  void onVMDispose(T viewModel) {}

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<T>('viewmodel', viewModel))
      ..add(DiagnosticsProperty<void Function(T, BuildContext)>(
          'onReady', onVMReady));
  }

  @override
  void didChangeDependencies() {
    viewModel.navigatorService.context = context;
    if (!isReady) {
      onVMReady(viewModel, context);
      isReady = true;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    onVMDispose(viewModel);
    super.dispose();
    viewModel.navigatorService.context = null;
  }

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider<T>.value(
      value: viewModel, child: createWidget(context, viewModel));

  void unfocus() {
    final FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
  }

  Widget createWidget(BuildContext context, T viewModel);

  Widget consumer(
          {required Widget Function(
            BuildContext context,
            T value,
            Widget? child,
          )
              builder,
          Widget? child}) =>
      Consumer<T>(
        builder: builder,
        child: child,
      );
}
