import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class pref extends StatefulWidget {
  const pref({Key? key}) : super(key: key);

  @override
  State<pref> createState() => _prefState();
}

class _prefState extends State<pref> {
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
  String _user = "";
  String _pass = "";

  @override
  void initState() {
    // TODO: implement initState
    checkData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Texto"),
        centerTitle: true,
        leading: GestureDetector(
          onTap: (){
            deleteData();
          },
          child: Icon(Icons.delete),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              _user,
              style: TextStyle(fontSize: 30, color: Colors.blue),
            ),
            Text(
              _pass,
              style: TextStyle(fontSize: 30, color: Colors.blue),
            ),
            TextField(
              controller: _username,
              decoration: const InputDecoration(hintText: "Nombre de usuario"),
            ),
            SizedBox(
              height: 40,
            ),
            TextField(
              controller: _password,
              decoration: const InputDecoration(hintText: "Contraseña"),
            ),
            SizedBox(
              height: 40,
            ),
            MaterialButton(
              onPressed: () {
                saveData(_username.text, _password.text);
              },
              child: Text("Guardar Datos"),
              color: Colors.redAccent,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> saveData(String user, String pass) async {
    final sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setString("username", user);
    await sharedPref.setString("password", pass);
    setState(() {
      _user = user;
      _pass = pass;
    });
  }

  Future<void> checkData() async {
    final sharedPref = await SharedPreferences.getInstance();
    Object? user = sharedPref.getString("username");
    Object? pass = sharedPref.getString("password");
    print(user.toString());
    print(pass.toString());
    setState(() {
      //_username.text = user.toString();
      //_password.text = pass.toString();
    });
    if (user == null || pass == null) {
      Fluttertoast.showToast(
          msg: "No data found",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "Usuario Logueado",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    setState(() {
      _user = user.toString();
      _pass = pass.toString();
    });
  }

  Future<void> deleteData() async {
    final sharedPref = await SharedPreferences.getInstance();
    if (sharedPref.containsKey("username") &&
        sharedPref.containsKey("password")) {
      sharedPref.remove("username");
      sharedPref.remove("password");
      setState(() {
        _user = "";
        _pass = "";
      });
      Fluttertoast.showToast(
          msg: "Datos eliminados",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
