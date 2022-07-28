import 'package:get/get.dart';

import '../../controller/controllers.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.put<LoginController>(LoginController());
  }
}
