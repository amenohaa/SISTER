import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// ignore: must_be_immutable
class ListNilai extends StatefulWidget {
  int idAll;
  ListNilai(this.idAll);

  @override
  State<ListNilai> createState() => _ListNilaiState();
}

class _ListNilaiState extends State<ListNilai> {
  List nilaimhs = [];
  int id = 0;

  @override
  void initState() {
    id = widget.idAll;
    nilaiMahasiswa();
    super.initState();
  }

  Future<void> nilaiMahasiswa() async {
    String urlnilaiMhs = "http://127.0.0.1:8082/api/v1/nilai/$id";
    try {
      var response = await http.get(Uri.parse(urlnilaiMhs));
      List<dynamic> data = jsonDecode(response.body);
      setState(() {
        nilaimhs = List.from(data);
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
          "Data Nilai Mahasiswa",
          style: TextStyle(
              fontSize: 24,
              color: Color.fromARGB(255, 1, 241, 165),
              fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: nilaimhs.isEmpty
          ? Center(
              child: Text(
                'Tidak ada data',
                style: TextStyle(fontSize: 20),
              ),
            )
          : ListView.builder(
              itemCount: nilaimhs.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    leading: Icon(
                      Icons.assignment_ind_rounded,
                      color: Colors.blue.shade300,
                      size: 24,
                    ),
                    title: Text(
                      nilaimhs[index]["mahasiswa"]["nama"],
                      style: TextStyle(
                          color: Colors.blue.shade300,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "Matakuliah : ${nilaimhs[index]["matakuliah"]["nama"]} \nNilai : ${nilaimhs[index]["nilai"]["nilai"]}",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                );
              }),
    );
  }
}
