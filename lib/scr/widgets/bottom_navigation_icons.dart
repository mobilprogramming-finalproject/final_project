import 'package:final_project/scr/widgets/custom_text.dart';
import 'package:flutter/material.dart';


class BottomNavIcon extends StatelessWidget {
  final String image;
  final String name;
  final Function onTap;

  const BottomNavIcon({Key key, this.image, this.name, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap ?? null,
        child: Column(
          children: <Widget>[
            Image.asset("images/$image",width: 20,height: 20,),
            SizedBox(height: 2,),
            CustomText(text: name,)
          ],
        ),
      ),
    );
  }
}
