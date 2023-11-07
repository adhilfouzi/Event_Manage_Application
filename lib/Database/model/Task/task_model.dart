class TaskModel {
  int? id;
  final String taskname;
  final String category;
  final String? note;
  final bool status;
  final String date;
  final int? eventid;
  final List<Subtaskmodel>? subtask;

  TaskModel({
    required this.taskname,
    required this.category,
    required this.status,
    required this.date,
    this.eventid,
    this.note,
    this.subtask,
    this.id,
  });

  static TaskModel fromMap(Map<String, Object?> map) {
    final id = map['id'] as int?;
    final taskname = map['taskname'] as String;
    final category = map['category'] as String;
    final note = map['note'] as String?;
    final status =
        map['status'] is int ? map['status'] == 1 : map['status'] as bool;
    final date = map['date'] as String;
    final eventid = map['eventid'] is int
        ? map['eventid'] as int
        : (map['eventid'] == null
            ? null
            : int.tryParse(map['eventid'].toString()));

    // final eventid = map['eventid'] as int?;
    final subtask = map['clientname'] as List<Subtaskmodel>?;
    return TaskModel(
        id: id,
        eventid: eventid,
        note: note,
        subtask: subtask,
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
  final bool subtaskstatus;

  Subtaskmodel({
    required this.subtaskname,
    required this.subtaskstatus,
    this.id,
    this.subtasknote,
  });

  static Subtaskmodel fromMap(Map<String, Object?> map) {
    return Subtaskmodel(
      id: map['id'] as String,
      subtaskname: map['subtaskname'] as String,
      subtasknote: map['subtasknote'] as String?,
      subtaskstatus: map['subtaskstatus'] as bool,
    );
  }
}
