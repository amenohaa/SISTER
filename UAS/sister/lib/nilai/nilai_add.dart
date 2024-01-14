import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/src/widgets/framework.dart';

class NilaiInsert extends StatefulWidget {
  const NilaiInsert({super.key});

  @override
  State<NilaiInsert> createState() => _NilaiInsertState();
}

class _NilaiInsertState extends State<NilaiInsert> {
  List<Map<String, dynamic>> namaMahasiswa = [];
  List<Map<String, dynamic>> namaMatakuliah = [];
  int? idmahasiswa;
  int? idmatakuliah;
  final nilai = TextEditingController();

  bool isNumeric(String str) {
    // ignore: unnecessary_null_comparison
    if (str == null || str.isEmpty) {
      return false;
    }
    final format = RegExp(r'^[0-9]+(\.[0-9]+)?$');
    return format.hasMatch(str);
  }

  Future<void> insertMatakuliah() async {
    if (isNumeric(nilai.text)) {
      String urlInsert = "http://127.0.0.1:8082/api/v1/nilai";
      final Map<String, dynamic> data = {
        "idmahasiswa": idmahasiswa,
        "idmatakuliah": idmatakuliah,
        "nilai": int.parse(nilai.text)
      };

      try {
        var response = await http.post(Uri.parse(urlInsert),
            body: jsonEncode(data),
            headers: {'Content-Type': 'application/json'});

        if (response.statusCode == 200) {
          Navigator.pop(context, "berhasil");
        } else {
          print("Gagal");
        }
      } catch (e) {
        print(e);
      }
    } else {
      print("Bukan Angka Desimal");
    }
  }

  @override
  void initState() {
    super.initState();
    getMahasiswa();
    getMatakuliah();
  }

  Future<void> getMahasiswa() async {
    String urlMahasiswa = "http://127.0.0.1:8083/api/v1/mahasiswa";
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
    String urlMatakuliah = "http://127.0.0.1:8081/api/v1/matakuliah";
    try {
      var response = await http.get(Uri.parse(urlMatakuliah));
      final List<dynamic> dataMk = jsonDecode(response.body);
      setState(() {
        namaMatakuliah = List.from(dataMk);
      });
    } catch (exc) {
      print(exc);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Create Nilai",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Center(
          child: Container(
              margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
              width: 800,
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  DropdownButtonFormField(
                    value: null,
                    onChanged: (value) {
                      setState(() {
                        idmahasiswa = int.parse(value.toString());
                      });
                    },
                    items: namaMahasiswa.map((item) {
                      return DropdownMenuItem(
                          value: item["id"].toString(),
                          child: Text(item["nama"]));
                    }).toList(),
                    decoration: InputDecoration(
                      hintText: "mahasiswa",
                      prefixIcon: Icon(Icons.person_2_outlined),
                      fillColor: Colors.blue.shade200,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  DropdownButtonFormField(
                    value: null,
                    onChanged: (value) {
                      setState(() {
                        idmatakuliah = int.parse(value.toString());
                      });
                    },
                    items: namaMatakuliah.map((item) {
                      return DropdownMenuItem(
                          value: item["id"].toString(),
                          child: Text(item["nama"].toString()));
                    }).toList(),
                    decoration: InputDecoration(
                      hintText: "Matakuliah",
                      prefixIcon: Icon(Icons.book_online_outlined),
                      fillColor: Colors.blue.shade200,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: nilai,
                    decoration: InputDecoration(
                      labelText: "Nilai",
                      hintText: "Masukkan Nilai",
                      prefixIcon: Icon(Icons.numbers_outlined),
                      fillColor: Colors.blue.shade200,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 50,
                    width: 200,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blue.shade400,
                      ),
                      onPressed: () {
                        insertMatakuliah();
                      },
                      child: Text(
                        "simpan",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ))),
    );
  }
}
