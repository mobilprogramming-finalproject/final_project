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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Sign in'),
      ),
      body: Form(

        // todo implement key
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset("images/logo.png", width: 120, height: 120,),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(12),
              child:Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(15)
                ),
                child:Padding(padding: EdgeInsets.only(left: 10),

              // todo implement fields
                child:TextFormField(
                // ignore: missing_return
                validator: (input) {
                  if (input.isEmpty) {
                    return 'Lütfen email girişi yapınız';
                    // ignore: missing_return
                  }
                },
                onSaved: (input) => _email = input,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Email",
                  icon: Icon(Icons.email)
                  ),
                 ),
                 ),
                ),
               ),
              Padding(
                padding: const EdgeInsets.all(12),
                child:Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(15)
                ),
                  child:Padding(padding: EdgeInsets.only(left: 10),
                   child:TextFormField(
                // ignore: missing_return
                     validator: (input) {
                     if (input.length < 6) {
                    return 'Lütfen 6 karakterden büyük şifre girişi yapınız';
                    // ignore: missing_return
                    }
                    },
                    onSaved: (input) => _password = input,
                    decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Password",
                    icon: Icon(Icons.lock)
                ),
                obscureText: true,
              ),
                  )
                  ,),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
              child: RaisedButton(
                onPressed: () => signIn(), // () => signIn()
                child: Text('Sign in'),
              ),)
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