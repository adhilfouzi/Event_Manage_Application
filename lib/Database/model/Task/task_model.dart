class TaskModel {
  int? id;
  final String taskname;
  final String category;
  final String? note;
  int status;
  final String date;
  final int eventid;

  TaskModel({
    required this.taskname,
    required this.category,
    required this.status,
    required this.date,
    required this.eventid,
    this.note,
    this.id,
  });

  static TaskModel fromMap(Map<String, Object?> map) {
    final id = map['id'] as int?;
    final taskname = map['taskname'] as String;
    final category = map['category'] as String;
    final note = map['note'] as String?;
    //final status = map['status'] as int;
    final status = map['status'] is int
        ? map['status'] as int
        : (map['status'] is String
            ? int.tryParse(map['status'] as String) ?? 0
            : 0);
    final date = map['date'] as String;
    //final eventid = map['eventid'] as int;
    final eventid = map['eventid'] is int
        ? map['eventid'] as int
        : (map['eventid'] is String
            ? int.tryParse(map['eventid'] as String) ?? 0
            : 0);
    return TaskModel(
        id: id,
        eventid: eventid,
        note: note,
        taskname: taskname,
        category: category,
        status: status,
        date: date);
  }
}

class Subtaskmodel {
  String? id;
  final String subtaskname;
  final String? subtasknote;
  final int? subtaskstatus;

  Subtaskmodel({
    required this.subtaskname,
    this.subtaskstatus,
    this.id,
    this.subtasknote,
  });

  static Subtaskmodel fromMap(Map<String, Object?> map) {
    return Subtaskmodel(
      id: map['id'] as String,
      subtaskname: map['subtaskname'] as String,
      subtasknote: map['subtasknote'] as String?,
      subtaskstatus: map['subtaskstatus'] as int?,
    );
  }
}
