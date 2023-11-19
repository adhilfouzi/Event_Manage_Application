import 'package:flutter/material.dart';
import 'package:project_event/Core/Color/font.dart';
import 'package:project_event/Database/functions/fn_budgetmodel.dart';
import 'package:project_event/Database/model/Budget_Model/budget_model.dart';
import 'package:project_event/screen/Body/Screen/Edit/edit_budget.dart';

class BudgetSearch extends StatefulWidget {
  const BudgetSearch({super.key});

  @override
  State<BudgetSearch> createState() => _BudgetSearchState();
}

class _BudgetSearchState extends State<BudgetSearch> {
  List<BudgetModel> finduser = [];

  @override
  void initState() {
    super.initState();
    finduser = budgetlist.value;
    // Initialize with the current student list
  }

  void _runFilter(String enteredKeyword) {
    List<BudgetModel> result = [];
    if (enteredKeyword.isEmpty) {
      result = budgetlist.value;
    } else {
      result = budgetlist.value
          .where((student) =>
              student.name
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              student.category
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      finduser = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color.fromRGBO(255, 200, 200, 1),
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: TextField(
              autofocus: true,
              onChanged: (value) => _runFilter(value),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Search',
                suffixIcon: Icon(Icons.search),
              ),
            ),
          )),
      body: SafeArea(
        child: ValueListenableBuilder<List<BudgetModel>>(
            valueListenable: budgetlist,
            builder: (context, value, child) {
              return Padding(
                padding: const EdgeInsets.all(12),
                child: finduser.isEmpty
                    ? const Center(
                        child: Text(
                          'No Data Available',
                          style: TextStyle(fontSize: 18),
                        ),
                      )
                    : ListView.builder(
                        itemCount: finduser.length,
                        itemBuilder: (context, index) {
                          final finduserItem = finduser[index];
                          return Card(
                            color: Colors.blue[100],
                            elevation: 4,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: ListTile(
                              title: Text(
                                finduserItem.name,
                                style: raleway(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                              subtitle: Text(
                                finduserItem.category,
                              ),
                              trailing: IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    dodeletebudget(context, finduserItem);
                                  }),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctr) =>
                                      EditBudget(budgetdata: finduserItem),
                                ));
                              },
                            ),
                          );
                        }),
              );
            }),
      ),
    );
  }
}

void dodeletebudget(rtx, BudgetModel student) {
  try {
    showDialog(
      context: rtx,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete'),
          content: Text('Do You Want delete  ${student.name} ?'),
          actions: [
            TextButton(
                onPressed: () {
                  delectYes(context, student);
                },
                child: const Text('Yes')),
            TextButton(
                onPressed: () {
                  Navigator.pop(rtx);
                },
                child: const Text('No'))
          ],
        );
      },
    );
  } catch (e) {
    print('Error deleting data: $e');
  }
}

void delectYes(ctx, BudgetModel student) {
  deleteBudget(student.id, student.eventid);

  ScaffoldMessenger.of(ctx).showSnackBar(
    const SnackBar(
      content: Text("Successfully Deleted"),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(10),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ),
  );
  Navigator.of(ctx).pop();
  Navigator.of(ctx).pop();
}
