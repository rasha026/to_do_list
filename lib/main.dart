import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/providers/checkProvider.dart';
import 'package:to_do_list/providers/TasksProvider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => check()),
        ChangeNotifierProvider(create: (_) => Tasks()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: Home(),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = new TextEditingController();

    bool isSelected = false;
    List _list = [];

    return Scaffold(
      appBar: AppBar(
        title: Text("To Do App"),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: Icon(Icons.add));
          },
        ),
      ),
      body: Column(children: [
        Container(
          color: Colors.blue,
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                flex: 1,
                child: Container(
                    child: Consumer<Tasks>(builder: (context, ob2, child2) {
                      return GestureDetector(
                        child: Text(
                          "All tasks",
                          style: TextStyle(fontSize: 18),
                        ),
                        onTap: () {
                          _list = ob2.getTasks();
                        },
                      );
                    })),
              ),
              Flexible(
                flex: 2,
                child: Container(
                    child: Consumer<Tasks>(builder: (context, ob2, child2) {
                      return GestureDetector(
                        child: Text(
                          "UnCompleted tasks",
                          style: TextStyle(fontSize: 18),
                        ),
                        onTap: () {
                          _list = ob2.getUnCompletedTasks();
                        },
                      );
                    })),
              ),
              Flexible(
                flex: 2,
                child: Container(
                    child: Consumer<Tasks>(builder: (context, ob2, child2) {
                      return GestureDetector(
                        child: Text(
                          "Completed tasks",
                          style: TextStyle(fontSize: 18),
                        ),
                        onTap: () {
                          _list = ob2.getCompletedTasks();
                        },
                      );
                    })),
              ),
            ],
          ),
        ),
        Flexible(
          flex: 1,
          child: Container(
            child: Consumer<Tasks>(
              builder: (context, ob2, child2) {
                return ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: _list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(

                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.blue,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text('${_list[index]}'),
                      );
                    });
              },
            ),
          ),
        ),
      ]),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Add Task',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'task'),
            ),
            Row(
              children: [
                Text("completed?"),
                Consumer<check>(
                  builder: (context, ob, child) {
                    return Checkbox(
                        value: ob.val,
                        onChanged: (value) {
                          ob.clicked();
                          isSelected = ob.val;
                        });
                  },
                )
              ],
            ),
            Consumer<Tasks>(
              builder: (context, ob2, child2) {
                return ElevatedButton(
                  child: Text("Add Task"),
                  onPressed: () {
                    ob2.setNewTask(_controller.text, isSelected);
                    _list = ob2.getTasks();
                    _controller.text = "";
                    Navigator.pop(context);
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
