import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/src/widgets/framework.dart';
import 'package:sister/matakuliah/matakuliah_add.dart';
import 'package:sister/matakuliah/matakuliah_update.dart';

class MatakuliahList extends StatefulWidget {
  const MatakuliahList({super.key});

  @override
  State<MatakuliahList> createState() => _MatakuliahList();
}

class _MatakuliahList extends State<MatakuliahList> {
  List matakuliah = [];

  @override
  void initState() {
    getMatakuliah();
    super.initState();
  }

  Future<void> getMatakuliah() async {
    String urlMatakuliah = 'http://127.0.0.1:8081/api/v1/matakuliah';
    try {
      var response = await http.get(Uri.parse(urlMatakuliah));
      matakuliah = jsonDecode(response.body);
      setState(() {
        matakuliah = jsonDecode(response.body);
      });
    } catch (exc) {
      print(exc);
    }
  }

  Future<void> deleteMatakuliah(int id) async {
    String urlMatakuliah = "http://127.0.0.1:8081/api/v1/matakuliah/${id}";
    try {
      await http.delete(Uri.parse(urlMatakuliah));
      setState(() {
        getMatakuliah();
      });
    } catch (exc) {
      print(exc);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => MatakuliahInsert(),
          ));
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text(
          "Matakuliah",
          style: TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        leading: const Icon(CupertinoIcons.book, size: 24, color: Colors.white),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
          itemCount: matakuliah.length,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.blue.shade50,
              margin: EdgeInsets.all(10),
              child: ListTile(
                leading: Icon(
                  Icons.person,
                  color: Colors.blue.shade500,
                  size: 24,
                ),
                title: Text(
                  matakuliah[index]["nama"]?.toString() ?? "",
                  style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "${matakuliah[index]["kode"]?.toString() ?? ""}\n${matakuliah[index]["sks"]?.toString() ?? ""}",
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.normal),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        tooltip: "Edit Data",
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) {
                              return MatakuliahUpdate(
                                id: matakuliah[index]["id"],
                                nama: matakuliah[index]["nama"],
                                kode: matakuliah[index]["kode"],
                                sks: matakuliah[index]["sks"].toString(),
                              );
                            }),
                          ).then((value) => getMatakuliah());
                        },
                        icon: Icon(
                          CupertinoIcons.reply,
                          color: Colors.green,
                          size: 30,
                        )),
                    IconButton(
                        tooltip: "Hapus Data",
                        onPressed: () {
                          deleteMatakuliah(matakuliah[index]["id"]);
                        },
                        icon: Icon(
                          CupertinoIcons.delete,
                          color: Colors.red,
                          size: 24,
                        )),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
