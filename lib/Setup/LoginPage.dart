import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:final_project/Pages/Home.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sigin'),
      ),
      body: Form(
        // todo implement key
          key: _formKey,
          child: Column(
            children: <Widget>[
              // todo implement fields
              TextFormField(
                // ignore: missing_return
                validator: (input) {
                  if (input.isEmpty) {
                    return 'Lütfen email girişi yapınız';
                    // ignore: missing_return
                  }
                },
                onSaved: (input) => _email = input,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextFormField(
                // ignore: missing_return
                validator: (input) {
                  if (input.length < 6) {
                    return 'Lütfen 6 karakterden büyük şifre girişi yapınız';
                    // ignore: missing_return
                  }
                },
                onSaved: (input) => _password = input,
                decoration: InputDecoration(labelText: 'Şifre'),
                obscureText: true,
              ),
              RaisedButton(
                onPressed: () => signIn(), // () => signIn()
                child: Text('Sign in'),
              )
            ],
          )),
    );
  }

  // metodu asenkron çalışacak şekilde ayarladık  async-await paterni
  Future<void> signIn() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      // todo login to firebase
      formState.save();
      try {
        // Firebase ile iletişim noktası

        UserCredential user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home(user: user)));
      } catch (e) {
        print(e.toString());
      }
    }
  }
}