class TaskOffline {
  int? id;
  String? title;
  String? desc;
  String? isCompleted;
  String? date;

  TaskOffline({
    this.id,
    this.title,
    this.desc,
    this.isCompleted,
    this.date,
  });

  TaskOffline.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'].toString();
    desc = json['desc'].toString();
    isCompleted = json['isCompleted'].toString();
    date = json['date'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['desc'] = desc;
    data['isCompleted'] = isCompleted;
    data['date'] = date;
    return data;
  }
}
