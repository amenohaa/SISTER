import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/src/widgets/framework.dart';
import 'package:sister/nilai/nilai_add.dart';

class NilaiList extends StatefulWidget {
  const NilaiList({super.key});

  @override
  State<NilaiList> createState() => _NilaiList();
}

class _NilaiList extends State<NilaiList> {
  List nilai = [];
  List<Map<String, dynamic>> namaMahasiswa = [];
  List<Map<String, dynamic>> namaMatakuliah = [];

  @override
  void initState() {
    getNilai();
    getMahasiswa();
    getMatakuliah();
    super.initState();
  }

  Future<void> getMahasiswa() async {
    String urlMahasiswa = 'http://127.0.0.1:8083/api/v1/mahasiswa';
    try {
      var response = await http.get(Uri.parse(urlMahasiswa));
      final List<dynamic> dataMhs = jsonDecode(response.body);

      setState(() {
        namaMahasiswa = List.from(dataMhs);
      });
    } catch (exc) {
      print(exc);
    }
  }

  Future<void> getMatakuliah() async {
    String urlMatakuliah = 'http://127.0.0.1:8081/api/v1/matakuliah';
    try {
      var response = await http.get(Uri.parse(urlMatakuliah));
      final List<dynamic> dataMatkul = jsonDecode(response.body);

      setState(() {
        namaMatakuliah = List.from(dataMatkul);
      });
    } catch (exc) {
      print(exc);
    }
  }

  Future<void> getNilai() async {
    String urlNilai = 'http://127.0.0.1:8082/api/v1/nilai';
    try {
      var response = await http.get(Uri.parse(urlNilai));
      nilai = jsonDecode(response.body);
      setState(() {
        nilai = jsonDecode(response.body);
      });
    } catch (exc) {
      print(exc);
    }
  }

  Future<void> deleteMahasiwa(int id) async {
    String urlNilai = "http://127.0.0.1:8082/api/v1/nilai/${id}";
    try {
      await http.delete(Uri.parse(urlNilai));
      setState(() {
        getNilai();
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
          Navigator.of(context)
              .push(MaterialPageRoute(
                builder: (context) => NilaiInsert(),
              ))
              .then((value) => getNilai());
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text(
          "Nilai",
          style: TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        leading:
            const Icon(CupertinoIcons.number, size: 24, color: Colors.white),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
          itemCount: nilai.length,
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
                  "${namaMahasiswa.firstWhere((mahasiswa) => mahasiswa["id"] == nilai[index]["idmahasiswa"], orElse: () => {})["nama"] ?? ""}",
                  style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "Matakuliah: ${namaMatakuliah.firstWhere((matakuliah) => matakuliah["id"] == nilai[index]["idmatakuliah"], orElse: () => {})["nama"] ?? ""}\nNilai: ${nilai[index]["nilai"]}",
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.normal),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        tooltip: "Hapus Data",
                        onPressed: () {
                          deleteMahasiwa(nilai[index]["id"]);
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
