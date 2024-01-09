import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shopping_mart/consts/consts.dart';
import 'package:shopping_mart/consts/lists.dart';
import 'package:shopping_mart/controller/product_controller.dart';
import 'package:shopping_mart/views/categories_screen/categories_details.dart';
import 'package:shopping_mart/widgets_common/bg_widget.dart';
class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller=Get.put(ProductController());
    return bgWidget(
        Scaffold(
          appBar: AppBar(
            title: categories.text.fontFamily(bold).white.make(),
          ),
          body: Center(
            child: Container(

              padding: const EdgeInsets.all(12),
              child: GridView.builder(
                itemCount: 9,
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                mainAxisExtent: 210,
              ), itemBuilder: (context,index){
                return Column(
                  children: [
                    Image.asset(categoriesImages[index],height: 120,width: 200,fit: BoxFit.cover,),
                    20.heightBox,
                    categoriesList[index].text.color(darkFontGrey).align(TextAlign.center).make(),
                  ],
                ).box.white.rounded.clip(Clip.antiAlias).outerShadowSm.make().onTap(() {
                  controller.getSubCategory(categoriesList[index]);
                  Get.to(()=>CategoriesDetails(title: categoriesList[index]));
                });
              }),
            ),
          ),
        )
    );
  }
}
