import 'package:flutter/material.dart';
import 'package:final_project/scr/helpers/screen_navigation.dart';
import 'package:final_project/scr/helpers/style.dart';

import 'package:final_project/scr/providers/category.dart';
import 'package:final_project/scr/providers/product.dart';
import 'package:final_project/scr/providers/restaurant.dart';
import 'package:final_project/scr/providers/user.dart';

import 'package:final_project/scr/screens/login.dart';

import 'package:final_project/scr/widgets/custom_text.dart';

import 'package:final_project/scr/widgets/loading.dart';

import 'package:flutter/cupertino.dart';

import 'package:flutter/rendering.dart';

import 'package:provider/provider.dart';

import 'home.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context);
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final restaurantProvider = Provider.of<RestaurantProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      key: _key,
      backgroundColor: white,
      body: authProvider.status == Status.Authenticating
          ? Loading()
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 100,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        "images/Logo.jpg"
                        "",
                        width: 100,
                        height: 100,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: grey),
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: TextFormField(
                          controller: authProvider.name,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Kullanıcı Adı",
                              icon: Icon(Icons.person)),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: grey),
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: TextFormField(
                          controller: authProvider.email,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Emails",
                              icon: Icon(Icons.email)),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: grey),
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: TextFormField(
                          controller: authProvider.password,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Şifre",
                              icon: Icon(Icons.lock)),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: GestureDetector(
                      onTap: () async {
                        print("Butona tıklandı!!!!");

                        if (!await authProvider.signUp()) {
                          _key.currentState.showSnackBar(
                              SnackBar(content: Text("Kayıt başarısız!")));
                          return;
                        }
                        categoryProvider.loadCategories();
                        restaurantProvider.loadSingleRestaurant();
                        productProvider.loadProducts();
                        authProvider.clearController();
                        changeScreenReplacement(context, Home());
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.greenAccent,
                            border: Border.all(color: grey),
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              CustomText(
                                text: "Kayıt ol",

                                size: 22,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(10),
                      child: GestureDetector(
                        onTap: () {
                          changeScreen(context, LoginScreen());
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.greenAccent,
                              border: Border.all(color: grey),
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                CustomText(
                                  text: "Giriş yap",
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ))
                ],
              ),
            ),
    );
  }
}
