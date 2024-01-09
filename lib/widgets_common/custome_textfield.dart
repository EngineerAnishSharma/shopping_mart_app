import 'package:shopping_mart/consts/consts.dart';

Widget customTextField(String? title,String? hint,controller,isPass){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title!.text.white.size(16).fontFamily(semibold).color(redColor).make(),
      5.heightBox,
      TextFormField(
        obscureText: isPass,
        controller: controller,
        decoration: InputDecoration(
          hintStyle: const TextStyle(
            fontFamily: semibold,
            color:textfieldGrey,
          ),
          hintText: hint,
          isDense: true,
          fillColor: lightGrey,
          filled: true,
          border: InputBorder.none,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: redColor,
            )
          )
        ),
      ),
      5.heightBox,

    ],
  );
}