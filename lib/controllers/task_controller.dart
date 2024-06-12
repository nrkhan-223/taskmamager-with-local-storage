import 'package:app1/db/db_helper.dart';
import 'package:app1/models/task.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../api/api.dart';
import '../models/task_model.dart';
import '../screens/add_page.dart';
import '../screens/edit_page.dart';
import 'offline_controller.dart';

class TaskController extends GetxController {
  List<Task> task = [];
  bool isLoading = true;
  bool isConnected = true;

  get context => BuildContext;

  @override
  void onInit() {
    super.onInit();
    getTask();
  }

  Future<void> getTask() async {
    isLoading = true;
    final response = await Api.getItem(context);
    task = response;
    _addUsersToDb();
    update();
    isLoading = false;
    update();
  }

  _addUsersToDb() async {
    DBHelper.deleteTable();
    OfflineController().task.clear();
    for (var i in task) {
      await OfflineController().addUser(
          task: TaskOffline(
        title: i.title,
        desc: i.description,
        isCompleted: i.isCompleted.toString(),
        date: i.createdAt,
      ));
    }
  }

  Future<void> deleteTask(id) async {
    await Api.deleteById(id);
    final filterItem = task.where((element) => element.id != id).toList();
    task = filterItem;
    _addUsersToDb();
    update();
  }

  Future<void> taskCompleted(id, title, desc, isCompleted,context) async {
    await Api.taskCompleted(context, id, title, desc, isCompleted);
    update();
    getTask();
  }

  Future<void> navigate() async {
    await Get.to(() => const AddPage());
    isLoading = true;
    getTask();
    update();
  }

  Future<void> navigate2(
    task,
  ) async {
    await Get.to(() => EditPage(task: task));
    isLoading = true;
    getTask();
    update();
  }
}
