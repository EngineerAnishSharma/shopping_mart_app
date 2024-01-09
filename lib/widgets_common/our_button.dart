import 'package:shopping_mart/consts/consts.dart';

Widget ourButton({onPress,color1,textColor,title}){
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: color1,
      padding: EdgeInsets.all(12),
    ), onPressed: onPress,
    child: Text(
      title,
      style: TextStyle(
        fontFamily:bold,
        color: textColor,
      ),

    ),
  );
}