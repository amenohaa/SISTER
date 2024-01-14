import 'package:flutter/material.dart';
import 'package:sister/mahasiswa/mahasiswa.dart';
import 'package:sister/matakuliah/matakuliah.dart';
import 'package:sister/nilai/nilai.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  List<Widget> body = const [
    Icon(Icons.home_filled),
    Icon(Icons.menu_open),
    Icon(Icons.person_2),
  ];

  final screen = [const MahasiswaList(), const MatakuliahList(), NilaiList()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.person_2), label: " Mahasiswa "),
          BottomNavigationBarItem(
              icon: Icon(Icons.menu_open), label: " Matakuliah "),
          BottomNavigationBarItem(
              icon: Icon(Icons.home_filled), label: " Nilai "),
        ],
      ),
    );
  }
}
