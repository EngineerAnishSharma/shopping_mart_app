import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shopping_mart/consts/consts.dart';
import 'package:shopping_mart/consts/loading_indicator.dart';
import 'package:shopping_mart/controller/product_controller.dart';
import 'package:shopping_mart/services/firestore_services.dart';
import 'package:shopping_mart/views/categories_screen/items_details.dart';
import 'package:shopping_mart/widgets_common/bg_widget.dart';
class CategoriesDetails extends StatefulWidget {
  final String title;
  const CategoriesDetails({super.key,required this.title});

  @override
  State<CategoriesDetails> createState() => _CategoriesDetailsState();
}

class _CategoriesDetailsState extends State<CategoriesDetails> {

  @override
  void initState() {
    switchCategory(widget.title);
    // TODO: implement initState
    super.initState();

  }

  switchCategory(title){
    if(controller.subCat.contains(title)){
      productMethod=FirestoreServices.getSubCategoryProducts(title);
    }
    else{
      productMethod=FirestoreServices.getProducts(title);
    }
  }

  var controller=Get.put(ProductController());
  dynamic productMethod;
  @override
  Widget build(BuildContext context) {

    return bgWidget(
      Scaffold(
        appBar: AppBar(
          title: widget.title!.text.white.fontFamily(bold).make(),
        ),
        body: Column(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                    controller.subCat.length, (index) => "${controller.subCat[index]}".text.
                size(12).
                fontFamily(semibold).
                color(darkFontGrey).
                makeCentered().
                box.white.rounded.size(120, 60).
                margin(const EdgeInsets.symmetric(horizontal: 4)).make().onTap(() {
                  switchCategory("${controller.subCat[index]}");
                  setState(() {});
                })
                ),
              ),
            ),
            20.heightBox,
            StreamBuilder(
              stream: productMethod,
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if(!snapshot.hasData){
                  return Expanded(
                    child: Center(
                      child: loadingIndicator(),
                    ),
                  );
                }
                else if(snapshot.data!.docs.isEmpty){
                  return Expanded(
                    child: Center(
                      child: "Products are not found!".text.color(darkFontGrey).make(),
                    )
                  );
                }
                else{
                  var data=snapshot.data!.docs;
                  return Expanded(
                          child: GridView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: data.length,
                              shrinkWrap: true,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisExtent: 250,
                                  mainAxisSpacing: 8,
                                  crossAxisSpacing: 8
                              ),
                              itemBuilder: (context,index){
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(data[index]['p_imgs'][0],width: 200,height:150,fit: BoxFit.cover,),
                                    "${data[index]['p_name']}".text.fontFamily(semibold).color(darkFontGrey).make(),
                                    10.heightBox,
                                    "Rs.${data[index]['p_price']}".text.color(redColor).fontFamily(bold).size(16).make(),
                                  ],
                                ).box.white.outerShadowSm.margin(const EdgeInsets.symmetric(horizontal: 4)).padding(const EdgeInsets.all(12)).roundedSM
                                    .make().onTap(() {
                                      controller.checkIfFav(data[index]);
                                  Get.to(()=>ItemDetails(title:"${data[index]['p_name']}",data: data[index],));
                                });
                              }
                          )
                      );
                }
              },

            ),
          ],
        )
      )
    );
  }
}

// Container(
// padding: const EdgeInsets.all(12),
// child: Column(
// children: [
// SingleChildScrollView(
// physics: const BouncingScrollPhysics(),
// scrollDirection: Axis.horizontal,
// child: Row(
// children: List.generate(
// controller.subCat.length, (index) => "${controller.subCat[index]}".text.
// size(12).
// fontFamily(semibold).
// color(darkFontGrey).
// makeCentered().
// box.white.rounded.size(120, 60).
// margin(const EdgeInsets.symmetric(horizontal: 4)).make()
// ),
// ),
// ),
// //items selection
// 20.heightBox,
// Expanded(
// child: GridView.builder(
// physics: const BouncingScrollPhysics(),
// itemCount: 6,
// shrinkWrap: true,
// gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// crossAxisCount: 2,
// mainAxisExtent: 250,
// mainAxisSpacing: 8,
// crossAxisSpacing: 8
// ),
// itemBuilder: (context,index){
// return Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Image.asset(imgP5,width: 200,height:150,fit: BoxFit.cover,),
// "Laptop 4GB/64GB".text.fontFamily(semibold).color(darkFontGrey).make(),
// 10.heightBox,
// "\$600".text.color(redColor).fontFamily(bold).size(16).make(),
// ],
// ).box.white.outerShadowSm.margin(EdgeInsets.symmetric(horizontal: 4)).padding(EdgeInsets.all(12)).roundedSM
//     .make().onTap(() {
// Get.to(()=>ItemDetails(title:"Dummy items"));
// });
// }
// )
// )
// ],
// ),
// ),