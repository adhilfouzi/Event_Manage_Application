// import 'package:flutter/material.dart';
// import 'package:project_event/Database/functions/fn_guestmodel.dart';
// import 'package:project_event/Database/model/Task/task_model.dart';
// import 'package:project_event/screen/Body/widget/Scaffold/app_bar.dart';
// import 'package:project_event/screen/Body/widget/sub/status.dart';
// import 'package:project_event/screen/Body/widget/box/textfield_blue.dart';

// class AddSubTask extends StatefulWidget {
//   const AddSubTask({
//     super.key,
//   });

//   @override
//   State<AddSubTask> createState() => _AddSubTaskState();
// }

// class _AddSubTaskState extends State<AddSubTask> {
//   final _formKey = GlobalKey<FormState>();
//   ValueNotifier<List<Subtaskmodel>>? subtasksNotifier;

//   @override
//   void initState() {
//     super.initState();
//     //subtasksNotifier = ValueNotifier<List<Subtaskmodel>>(widget.subtasks);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(
//         actions: [
//           AppAction(
//               icon: Icons.done,
//               onPressed: () {
//                 addsubTaskclick(context);
//               }),
//         ],
//         titleText: 'Add SubTask',
//       ),
//       body: Form(
//         key: _formKey,
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(10),
//           child: Column(children: [
//             TextFieldBlue(
//               textcontent: 'Name',
//               controller: _nameController,
//               validator: (value) {
//                 if (value!.isEmpty) {
//                   return 'Task name is required';
//                 }
//                 return null; // Return null if the input is valid
//               },
//             ),
//             TextFieldBlue(textcontent: 'Note', controller: _noteController),
//             StatusBar(
//               textcontent1: 'Pending',
//               textcontent2: 'Completed',
//               onStatusChange: (bool status) {
//                 _statusController = status;
//               },
//             ),
//           ]),
//         ),
//       ),
//     );
//   }

//   final _nameController = TextEditingController();
//   bool _statusController = false;
//   final _noteController = TextEditingController();

//   Future<void> addsubTaskclick(BuildContext mtx) async {
//     if (_formKey.currentState != null && _formKey.currentState!.validate()) {
//       final subtaskname = _nameController.text.toUpperCase();
//       final sbcategory = _noteController.text;
//       final sbtask = Subtaskmodel(
//           subtasknote: sbcategory,
//           subtaskname: subtaskname,
//           subtaskstatus: _statusController);

//       await addSubTask(sbtask);

//       setState(() {
//         subtasksNotifier!.value.add(sbtask);
//         _statusController = false;
//         _nameController.clear();
//         _noteController.clear();
//       });

//       // ScaffoldMessenger.of(mtx).showSnackBar(
//       //   const SnackBar(
//       //     content: Text("Successfully added"),
//       //     behavior: SnackBarBehavior.floating,
//       //     margin: EdgeInsets.all(10),
//       //     backgroundColor: Colors.greenAccent,
//       //     duration: Duration(seconds: 2),
//       //   ),
//       // );
//       Navigator.of(mtx).pop();
//     } else {
//       ScaffoldMessenger.of(mtx).showSnackBar(
//         const SnackBar(
//           content: Text("Fill the Task Name"),
//           behavior: SnackBarBehavior.floating,
//           margin: EdgeInsets.all(10),
//           backgroundColor: Colors.red,
//           duration: Duration(seconds: 2),
//         ),
//       );
//     }
//   }
// }
