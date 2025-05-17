import 'package:dev_hub_cubit_session/services/dio_helper.dart';
import 'package:dev_hub_cubit_session/src/app_root.dart';
import 'package:flutter/material.dart';



void main(){



  DioHelper.init();
  runApp(AppRoot());
}

// release apk