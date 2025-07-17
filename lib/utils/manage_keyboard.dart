import 'package:flutter/cupertino.dart';

class ManageKeyboard{
  /// Ager keyboard open hai tu band kar du
  static void hideKeyboard(BuildContext context){
    FocusScopeNode currentFocus=FocusScope.of(context);
    if(!currentFocus.hasPrimaryFocus){
      currentFocus.unfocus();
    }
  }
}