import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shopping_mart/consts/consts.dart';
import 'package:shopping_mart/views/categories_screen/categories_details.dart';

Widget featuredButton({String? title,icon}){
  return Row(
    children: [
      Image.asset(icon,width: 60,fit: BoxFit.fill,),
      10.widthBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make(),
    ],
  ).box.width(200).
  margin(const EdgeInsets.symmetric(horizontal: 4)).
  white.roundedSM.padding(const EdgeInsets.all(4)).outerShadowSm.make().onTap(() {
    Get.to(CategoriesDetails(title: title));
  });

}