import 'package:flutter/material.dart';
import 'employeeBloc.dart';
import 'employee.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final EmployeeBloc _employeeBloc = EmployeeBloc();

  @override
  void dispose() {
    _employeeBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Employee Bloc"),
      ),
      body: StreamBuilder<List<Employee>>(
        stream: _employeeBloc.employeeListStream,
        builder:
            (BuildContext context, AsyncSnapshot<List<Employee>> snapshot) {
          return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          "${snapshot.data![index].id}",
                          style: const TextStyle(fontSize: 20.0),
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                snapshot.data![index].name,
                                style: const TextStyle(fontSize: 18.0),
                              ),
                              Text(
                                "${snapshot.data![index].salary}",
                                style: const TextStyle(fontSize: 18.0),
                              ),
                            ],
                          )),
                      IconButton(
                          onPressed: () {
                            _employeeBloc.employeeSalaryIncreament
                                .add(snapshot.data![index]);
                          },
                          icon: const Icon(
                            Icons.thumb_up,
                            color: Colors.green,
                          )),
                      IconButton(
                          onPressed: () {
                            _employeeBloc.employeeSalaryDecreament
                                .add(snapshot.data![index]);
                          },
                          icon: const Icon(
                            Icons.thumb_down,
                            color: Colors.red,
                          ))
                    ],
                  ),
                );
              });
        },
      ),
    );
  }
}
