import 'package:shopping_mart/consts/consts.dart';

Widget orderPlaceDetails({data,title1,title2,d1,d2}){

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "$title1".text.fontFamily(semibold).make(),
            "$d1".text.fontFamily(semibold).color(redColor).make()
          ],
        ),
        SizedBox(
          width: 120,
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              "$title2".text.fontFamily(semibold).make(),
              "$d2".text.make()
            ],
          ),
        )
      ],
    ),
  );

}