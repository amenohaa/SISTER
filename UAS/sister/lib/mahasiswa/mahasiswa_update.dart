import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MahasiswaUpdate extends StatefulWidget {
  final int id;
  final String nama;
  final String email;
  final DateTime tgllahir;

  const MahasiswaUpdate({
    Key? key,
    required this.id,
    required this.nama,
    required this.email,
    required this.tgllahir,
  }) : super(key: key);

  @override
  _MahasiswaUpdateState createState() => _MahasiswaUpdateState();
}

class _MahasiswaUpdateState extends State<MahasiswaUpdate> {
  late int id;
  final TextEditingController _nama = TextEditingController();
  final TextEditingController _email = TextEditingController();
  late DateTime tgllahir;

  @override
  void initState() {
    super.initState();
    id = widget.id;
    _nama.text = widget.nama;
    _email.text = widget.email;
    tgllahir = widget.tgllahir;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? kalender = await showDatePicker(
      context: context,
      initialDate: tgllahir,
      firstDate: DateTime(1950),
      lastDate: DateTime(2030),
    );

    if (kalender != null && kalender != tgllahir) {
      setState(() {
        tgllahir = kalender;
      });
    }
  }

  Future<void> updateMahasiswa() async {
    String urlUpdate =
        "http://127.0.0.1:8083/api/v1/mahasiswa/${id}?nama=${_nama.text}&&email=${_email.text}&&tgllahir=${"${tgllahir.toLocal()}".split(" ")[0]}";

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
          "Update Mahasiswa",
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
                  controller: TextEditingController(
                      text: "${tgllahir.toLocal()}".split(" ")[0]),
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
                width: 250,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    updateMahasiswa();
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
                    "Update Mahasiswa",
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
