import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart';
import '../controllers/offline_controller.dart';

class Offlinedatashow extends StatelessWidget {
  const Offlinedatashow({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Offline data show".text.make(),
      ),
      body: GetBuilder<OfflineController>(
          init: OfflineController(),
          builder: (controller) {
            if (controller.task.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(),
                    20.heightBox,
                    "no data has been added yet".text.make(),
                  ],
                ),
              );
            } else {
              return ListView.builder(
                  itemCount: controller.task.length,
                  itemBuilder: (context, index) {
                    final task = controller.task[index];
                    String? title = task.title;
                    String? desc = task.desc;
                    String? date = task.date;
                    String? isComplete=task.isCompleted;
                    DateTime dateTime = DateTime.parse(date!);
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(dateTime);
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.black87,
                        child: '${index + 1}'.text.size(20).make(),
                      ),
                      title: title?.text.white.make(),
                      subtitle: desc?.text.white.make(),
                      trailing: Column(
                        children: [
                          formattedDate.text.make(),
                          if (isComplete=='true')
                            const Icon(Icons.done_all)
                        ],
                      ),
                    );
                  });
            }
          }),
    );
  }
}
