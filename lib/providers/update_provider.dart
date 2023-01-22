import 'package:gpass/models/updateDevice.dart';
import 'package:gpass/models/user.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final UpdateProvider = Provider((ref) => UpdateProvider1());

class UpdateProvider1 extends ChangeNotifier {
  UpdateModel _newid= UpdateModel(
    
    deviceId: '',
    newDeviceId: '',
    
  );
  UpdateModel get newid => _newid;

  void setUpdate(String newId) {
    _newid = UpdateModel.fromJson(newId);
  }

  void setUserFromModel() {
    _newid = newid;
    notifyListeners();
  }
}
