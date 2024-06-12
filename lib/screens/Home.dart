import 'package:app1/screens/widget/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:app1/controllers/task_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import '../controllers/network_controller.dart';
import '../models/task_model.dart';
import 'offlineDataShow.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var controller = Get.put(TaskController());

  var controller2 = Get.put(NetworkController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Task Management".text.make(),
        elevation: 2.0,
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              controller.getTask();
              setState(() {});
            },
            child: "Refresh".text.size(9).make(),
          ),
          15.widthBox,
          FloatingActionButton(
            onPressed: () {
              controller.navigate();
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
      body: GetBuilder<TaskController>(
          init: TaskController(),
          builder: (controllers) {
            return Visibility(
              visible: controllers.isLoading,
              replacement: Visibility(
                visible: controllers.task.isNotEmpty,
                replacement: Center(
                  child: "No TODO Item".text.white.semiBold.size(20).make(),
                ),
                child: ListView.builder(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                    itemCount: controllers.task.length,
                    itemBuilder: (context, index) {
                      final tasks = controllers.task[index];
                      var title = tasks.title;
                      DateTime dateTime = DateTime.parse(tasks.createdAt);
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(dateTime);
                      return Card(
                        color: const Color.fromARGB(255, 43, 43, 43),
                        shape:
                            const Border.symmetric(vertical: BorderSide.none),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.black87,
                            child: '${index + 1}'.text.size(20).make(),
                          ),
                          title: title.text.make(),
                          subtitle: tasks.description.text
                              .size(13)
                              .maxLines(2)
                              .make(),
                          trailing: Column(
                            children: [
                              formattedDate.text.make(),
                              if (tasks.isCompleted) const Icon(Icons.done_all)
                            ],
                          ),
                        ),
                      ).onTap(() {
                        _showBottomSheet(context, tasks, controllers);
                      });
                    }),
              ),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (controller2.isConnected)
                      const CircularProgressIndicator(),
                    if (!controller2.isConnected) "No Internet".text.make(),
                    20.heightBox,
                    if (!controller2.isConnected)
                      ElevatedButton(
                          onPressed: () {
                            Get.to(() => const Offlinedatashow());
                          },
                          child: "offline".text.make()),
                  ],
                ),
              ),
            );
          }),
    );
  }

  _showBottomSheet(BuildContext context, Task task, controller) {
    Get.bottomSheet(Container(
      width: context.screenWidth,
      padding: const EdgeInsets.only(top: 2),
      height: task.isCompleted == true
          ? context.screenHeight * 0.25
          : context.screenHeight * 0.40,
      color: Colors.black38,
      child: Column(
        children: [
          Container(
            width: 100,
            height: 5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: CupertinoColors.systemGrey5,
            ),
          ),
          25.heightBox,
          Visibility(
            visible: task.isCompleted == true ? false : true,
            child: commonButton(
              onPress: () {
                controller.taskCompleted(
                    task.id, task.title, task.description, true, context);
                Get.back();
              },
              color: Colors.blue,
              title: "Task Completed",
              textColor: Colors.white,
            ),
          ),
          10.heightBox,
          Visibility(
            visible: task.isCompleted == true ? false : true,
            child: commonButton(
              onPress: () {
                controller.navigate2(task);
              },
              color: Colors.green,
              title: "Edit Task",
              textColor: Colors.white,
            ),
          ),
          10.heightBox,
          commonButton(
            onPress: () {
              controller.deleteTask(task.id);
              Get.back();
              VxToast.show(context, msg: "Task hasten deleted");
            },
            color: Colors.red,
            title: "Delete Task",
            textColor: Colors.white,
          ),
          const Spacer(),
          commonButton(
            onPress: () {
              Get.back();
            },
            color: Colors.white38,
            title: "Close",
            textColor: Colors.white,
          ),
          20.heightBox
        ],
      ),
    ));
  }
}
