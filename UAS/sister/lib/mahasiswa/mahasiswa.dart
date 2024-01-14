import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sister/mahasiswa/mahasiswa_add.dart';
import 'package:sister/mahasiswa/mahasiswa_update.dart';
import 'package:sister/nilai/nilai_list.dart';

class MahasiswaList extends StatefulWidget {
  const MahasiswaList({super.key});

  @override
  State<MahasiswaList> createState() => _MahasiswaList();
}

class _MahasiswaList extends State<MahasiswaList> {
  List mahasiswa = [];

  @override
  void initState() {
    getMahasiswa();
    super.initState();
  }

  Future<void> getMahasiswa() async {
    String urlMahasiswa = "http://127.0.0.1:8083/api/v1/mahasiswa";
    try {
      var response = await http.get(Uri.parse(urlMahasiswa));
      mahasiswa = jsonDecode(response.body);
      setState(() {
        mahasiswa = jsonDecode(response.body);
      });
    } catch (exc) {
      print(exc);
    }
  }

  Future<void> deleteMahasiwa(int id) async {
    String urlMahasiswa = "http://127.0.0.1:8083/api/v1/mahasiswa/${id}";
    try {
      await http.delete(Uri.parse(urlMahasiswa));
      setState(() {
        getMahasiswa();
      });
    } catch (exc) {
      print(exc);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const MahasiswaInsert()));
        },
        child: Icon(
          Icons.add,
        ),
      ),
      appBar: AppBar(
        title: const Text(
          "Mahasiswa",
          style: TextStyle(
              fontSize: 24, color: Colors.white, fontWeight: FontWeight.w500),
        ),
        leading: const Icon(CupertinoIcons.person_2_alt,
            size: 24, color: Colors.white),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
          itemCount: mahasiswa.length,
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
                  mahasiswa[index]["nama"]?.toString() ?? "",
                  style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "${mahasiswa[index]["email"]?.toString() ?? ""}\n${mahasiswa[index]["tgllahir"]?.toString() ?? ""}",
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
                              return MahasiswaUpdate(
                                id: mahasiswa[index]["id"],
                                nama: mahasiswa[index]["nama"],
                                email: mahasiswa[index]["email"],
                                tgllahir: DateTime.parse(
                                    mahasiswa[index]["tgllahir"]),
                              );
                            }),
                          ).then((value) => getMahasiswa());
                        },
                        icon: Icon(
                          CupertinoIcons.reply,
                          color: Colors.green,
                          size: 30,
                        )),
                    IconButton(
                        tooltip: "Hapus Data",
                        onPressed: () {
                          deleteMahasiwa(mahasiswa[index]["id"]);
                        },
                        icon: Icon(
                          CupertinoIcons.delete,
                          color: Colors.red,
                          size: 24,
                        )),
                    IconButton(
                        tooltip: "Lihat Nilai",
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ListNilai(mahasiswa[index]["id"])));
                        },
                        icon: Icon(
                          CupertinoIcons.eye,
                          color: Colors.blue.shade300,
                          size: 28,
                        )),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
