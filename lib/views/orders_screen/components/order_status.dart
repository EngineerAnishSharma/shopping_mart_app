import 'package:shopping_mart/consts/consts.dart';

Widget orderStatus(icon,color,title,showDone){
  return ListTile(
    // tileColor: lightGrey,
    leading: Icon(
      icon,
      color: color,
    ).box.border(color:color).roundedSM.padding(const EdgeInsets.all(4.0)).make(),
    trailing: SizedBox(
      height: 100,
      width: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          "${title}".text.color(darkFontGrey).make(),
          showDone? const Icon(
            Icons.done,
            color: redColor,
          ):Container()
        ],
      ),
    ),
  );
}