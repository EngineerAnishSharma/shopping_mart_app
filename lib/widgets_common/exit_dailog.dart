
import 'package:flutter/services.dart';
import 'package:shopping_mart/consts/consts.dart';
import 'package:shopping_mart/widgets_common/our_button.dart';

Widget exitDialog(context){
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "Confirm".text.color(darkFontGrey).fontFamily(bold).size(18).make(),
        const Divider(),
        10.heightBox,
        "Are you sure to exit?".text.color(darkFontGrey).size(16).make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ourButton(color1: redColor,onPress: (){
              SystemNavigator.pop();
            },textColor: whiteColor,title: "Yes"),
            ourButton(color1: redColor,onPress: (){
              Navigator.pop(context);
            },textColor: whiteColor,title: "No"),
          ],
        )
      ],
    ).box.roundedSM.color(lightGrey).padding(const EdgeInsets.all(12.0)).make(),
  );
}