import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class NetworkController extends GetxController{
  final Connectivity connectivity=Connectivity();
  bool isConnected = true;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    connectivity.onConnectivityChanged.listen(status);
  }

  void status(List<ConnectivityResult> result){
    log(result.toString());
    if(result.contains(ConnectivityResult.none)){
      isConnected = false;

      Get.rawSnackbar(
          messageText: "no network".text.make(),
          duration: const Duration(seconds: 30)
      );
      update();
    } else {
      isConnected = true;
      if(Get.isSnackbarOpen){
        Get.closeCurrentSnackbar().then((onValue){
          Get.rawSnackbar(
              messageText: "network back".text.make(),
              duration: const Duration(seconds: 3)
          );
        });
      }
      update();
    }

  }
}