import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/src/widgets/framework.dart';
import 'package:sister/matakuliah/matakuliah.dart';

class MatakuliahInsert extends StatefulWidget {
  const MatakuliahInsert({super.key});

  @override
  State<MatakuliahInsert> createState() => _MatakuliahInsertState();
}

class _MatakuliahInsertState extends State<MatakuliahInsert> {
  final TextEditingController _nama = TextEditingController();
  final TextEditingController _kode = TextEditingController();
  final TextEditingController _sks = TextEditingController();

  Future<void> insertMatakuliah() async {
    String urlInsert = "http://127.0.0.1:8081/api/v1/matakuliah";
    final Map<String, dynamic> data = {
      "nama": _nama.text.toString(),
      "kode": _kode.text.toString(),
      "sks": _sks.text.toString(),
    };

    try {
      var response = await http.post(
        Uri.parse(urlInsert),
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        kirim();
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  void kirim() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MatakuliahList()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Create Matakuliah",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 80, 20, 20),
                child: TextField(
                  controller: _nama,
                  decoration: const InputDecoration(
                    hintText: "Nama",
                    hintStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                    prefixIcon: Align(
                        widthFactor: 1.0,
                        heightFactor: 1.0,
                        child: Icon(
                          Icons.face_rounded,
                          color: Colors.blue,
                        )),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2,
                          style: BorderStyle.solid,
                          color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
                child: TextField(
                  controller: _kode,
                  decoration: const InputDecoration(
                    hintText: "Kode",
                    hintStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                    prefixIcon: Align(
                        widthFactor: 1.0,
                        heightFactor: 1.0,
                        child: Icon(
                          Icons.email,
                          color: Colors.blue,
                        )),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2,
                          style: BorderStyle.solid,
                          color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
                child: TextField(
                  controller: _sks,
                  decoration: InputDecoration(
                    hintText: "SKS",
                    hintStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    prefixIcon: Align(
                        widthFactor: 1.0,
                        heightFactor: 1.0,
                        child: Icon(
                          Icons.book_outlined,
                          color: Colors.blue,
                        )),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2,
                          style: BorderStyle.solid,
                          color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 200,
                height: 60,
                child: ElevatedButton(
                  onPressed: () async {
                    await insertMatakuliah();
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => MatakuliahList()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                            width: 2,
                            style: BorderStyle.solid,
                            color: Colors.white),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25)),
                      )),
                  child: Text(
                    "Create Matakuliah",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
