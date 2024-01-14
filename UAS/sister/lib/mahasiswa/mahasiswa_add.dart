import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sister/mahasiswa/mahasiswa.dart';

class MahasiswaInsert extends StatefulWidget {
  const MahasiswaInsert({Key? key}) : super(key: key);

  @override
  _MahasiswaInsertState createState() => _MahasiswaInsertState();
}

class _MahasiswaInsertState extends State<MahasiswaInsert> {
  final TextEditingController _nama = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _tglLahir = TextEditingController();

  DateTime tglLahir = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? kalender = await showDatePicker(
        context: context,
        initialDate: tglLahir,
        firstDate: DateTime(1950),
        lastDate: DateTime(2030));

    if (kalender != null && kalender != tglLahir) {
      setState(() {
        tglLahir = kalender;
        _tglLahir.text = "${kalender.day}/${kalender.month}/${kalender.year}";
      });
    }
  }

  Future<void> insertMahasiswa() async {
    String urlInsert = "http://127.0.0.1:8083/api/v1/mahasiswa";
    final Map<String, dynamic> data = {
      "nama": _nama.text.toString(),
      "email": _email.text.toString(),
      "tgllahir": '${tglLahir.toLocal()}'.split(' ')[0]
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
      MaterialPageRoute(builder: (context) => const MahasiswaList()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Create Mahasiswa",
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
                  controller: _email,
                  decoration: const InputDecoration(
                    hintText: "Email",
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
                  controller: _tglLahir,
                  readOnly: true,
                  onTap: () => _selectDate(context),
                  decoration: InputDecoration(
                    hintText: "Tanggal Lahir",
                    hintStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    prefixIcon: Align(
                        widthFactor: 1.0,
                        heightFactor: 1.0,
                        child: Icon(
                          Icons.date_range_rounded,
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
                    await insertMahasiswa();
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => MahasiswaList()),
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
                    "Create Mahasiswa",
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
