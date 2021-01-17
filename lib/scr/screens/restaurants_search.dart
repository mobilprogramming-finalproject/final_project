import 'package:flutter/material.dart';
import 'package:final_project/scr/helpers/screen_navigation.dart';
import 'package:final_project/scr/helpers/style.dart';
import 'package:final_project/scr/providers/app.dart';

import 'package:final_project/scr/providers/product.dart';
import 'package:final_project/scr/providers/restaurant.dart';

import 'package:final_project/scr/screens/restaurant.dart';

import 'package:final_project/scr/widgets/custom_text.dart';

import 'package:final_project/scr/widgets/loading.dart';
import 'package:final_project/scr/widgets/restaurant.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/rendering.dart';

import 'package:provider/provider.dart';


class RestaurantsSearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final restaurantProvider = Provider.of<RestaurantProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    final app = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        backgroundColor: white,
        leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: CustomText(
          text: "Restaurants",
          size: 20,
        ),
        elevation: 0.0,
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {})
        ],
      ),
      body: app.isLoading
          ? Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[Loading()],
              ),
            )
          : restaurantProvider.searchedRestaurants.length < 1
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.search,
                          color: grey,
                          size: 30,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CustomText(
                          text: "Restoran bulunamadı!",
                          color: grey,
                          weight: FontWeight.w300,
                          size: 22,
                        ),
                      ],
                    )
                  ],
                )
              : ListView.builder(
                  itemCount: restaurantProvider.searchedRestaurants.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () async {
                          app.changeLoading();
                          await productProvider.loadProductsByRestaurant(
                              restaurantId: restaurantProvider
                                  .searchedRestaurants[index].id);
                          app.changeLoading();

                          changeScreen(
                              context,
                              RestaurantScreen(
                                restaurantModel: restaurantProvider
                                    .searchedRestaurants[index],
                              ));
                        },
                        child: RestaurantWidget(
                            restaurant:
                                restaurantProvider.searchedRestaurants[index]));
                  }),
    );
  }
}
