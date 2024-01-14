import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MatakuliahUpdate extends StatefulWidget {
  final int id;
  final String nama;
  final String kode;
  final String sks;

  const MatakuliahUpdate({
    Key? key,
    required this.id,
    required this.nama,
    required this.kode,
    required this.sks,
  }) : super(key: key);

  @override
  _MatakuliahUpdateState createState() => _MatakuliahUpdateState();
}

class _MatakuliahUpdateState extends State<MatakuliahUpdate> {
  late int id;
  final TextEditingController _nama = TextEditingController();
  final TextEditingController _kode = TextEditingController();
  final TextEditingController _sks = TextEditingController();

  @override
  void initState() {
    super.initState();
    id = widget.id;
    _nama.text = widget.nama;
    _kode.text = widget.kode;
    _sks.text = widget.sks.toString();
  }

  Future<void> updateMatakuliah() async {
    String urlUpdate =
        "http://127.0.0.1:8081/api/v1/matakuliah/${id}?nama=${_nama.text}&&kode=${_kode.text}&&sks=${_sks.text}";
    try {
      var response = await http.put(
        Uri.parse(urlUpdate),
      );

      if (response.statusCode == 200) {
        Navigator.pop(context);
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Update Matakuliah",
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
                  decoration: const InputDecoration(
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
                width: 250,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    updateMatakuliah();
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
                    "Update Matakuliah",
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
