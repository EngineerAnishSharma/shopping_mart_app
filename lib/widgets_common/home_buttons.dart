import 'package:shopping_mart/consts/consts.dart';

Widget homeButtons(width,height,icon,String title,onPress){
  return Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(icon,width: 26,),
        5.heightBox,
        title!.text.color(darkFontGrey).fontFamily(semibold).make(),
      ],
    ).box.rounded.shadowSm.size(width, height).white.make(),
  );
}