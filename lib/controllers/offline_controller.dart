import 'package:app1/models/task.dart';
import 'package:get/get.dart';
import '../db/db_helper.dart';

class OfflineController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getTasks();
  }

  List<TaskOffline> task = [];

  Future<int> addUser({TaskOffline? task}) async {
    return await DBHelper.insert(task);
  }

  void getTasks() async {
    List<Map<String, dynamic>> tasks = await DBHelper.query();
    task.assignAll(
        tasks.map((data) => new TaskOffline.fromJson(data)).toList());
    update();
  }
}
