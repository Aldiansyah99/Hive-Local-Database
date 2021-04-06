import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_local_database/model/student.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _nimController = TextEditingController();
  TextEditingController _nameEditController = TextEditingController();
  TextEditingController _nimEditController = TextEditingController();
  Box<dynamic> studentsBox;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => AddStudentPage()));
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nama',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                            hintText: 'Masukkan nama',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8))),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        'Nim',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _nimController,
                        decoration: InputDecoration(
                            hintText: 'Masukkan nim',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8))),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () {
                                int nim = int.parse(_nimController.text.trim());
                                studentsBox.add(
                                    Student(_nameController.text.trim(), nim));
                                _nameController.clear();
                                _nimController.clear();
                                Navigator.pop(context);
                              },
                              child: Text('Simpan')))
                    ],
                  ),
                );
              });
        },
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16),
          child: FutureBuilder(
            future: Hive.openBox('students'),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error),
                  );
                } else {
                  studentsBox = Hive.box('students');
                  if (studentsBox.length == 0) {
                    studentsBox.add(Student('Aldi', 123));
                    studentsBox.add(Student('Iccank', 121));
                  }
                  return ValueListenableBuilder(
                    valueListenable: studentsBox.listenable(),
                    builder: (context, value, child) {
                      return ListView.builder(
                          itemCount: studentsBox.length,
                          itemBuilder: (context, index) {
                            Student student = studentsBox.getAt(index);
                            return Container(
                                padding: EdgeInsets.all(16),
                                margin: EdgeInsets.only(bottom: 16),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 7,
                                        offset: Offset(0, 2),
                                      )
                                    ]),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Nama : ' + student.name),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Text('Nim : ' + student.nim.toString()),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            studentsBox.delete(index);
                                          },
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    content: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Nama',
                                                          style: TextStyle(
                                                              fontSize: 16),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        TextFormField(
                                                          controller:
                                                              _nameEditController
                                                                ..text = student
                                                                    .name,
                                                          decoration: InputDecoration(
                                                              hintText:
                                                                  'Masukkan nama',
                                                              border: OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8))),
                                                        ),
                                                        SizedBox(
                                                          height: 16,
                                                        ),
                                                        Text(
                                                          'Nim',
                                                          style: TextStyle(
                                                              fontSize: 16),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        TextFormField(
                                                          controller:
                                                              _nimEditController
                                                                ..text = student
                                                                    .nim
                                                                    .toString(),
                                                          decoration: InputDecoration(
                                                              hintText:
                                                                  'Masukkan nim',
                                                              border: OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8))),
                                                        ),
                                                        SizedBox(
                                                          height: 16,
                                                        ),
                                                        Container(
                                                            width:
                                                                double.infinity,
                                                            child:
                                                                ElevatedButton(
                                                                    onPressed:
                                                                        () {
                                                                      int nim = int.parse(_nimEditController
                                                                          .text
                                                                          .trim());
                                                                      studentsBox.putAt(
                                                                          index,
                                                                          Student(
                                                                              _nameEditController.text.trim(),
                                                                              nim));
                                                                      _nameEditController
                                                                          .clear();
                                                                      _nimEditController
                                                                          .clear();
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child: Text(
                                                                        'Ubah')))
                                                      ],
                                                    ),
                                                  );
                                                });
                                          },
                                          child: Icon(
                                            Icons.edit,
                                            color: Colors.blue,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ));
                          });
                    },
                  );
                }
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
