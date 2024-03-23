import 'package:agrihub/Common/NavBar.dart';
import 'package:flutter/material.dart';

class Admindashboard extends StatelessWidget {
  const Admindashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dashboard"),),
      drawer: AdminNavBar(),
    body: Text("Admin Page"),);
  }
}
