import 'dart:ffi';

import 'package:get/get.dart';
import 'package:shopping_mart/consts/consts.dart';
import 'package:shopping_mart/consts/lists.dart';
import 'package:shopping_mart/controller/product_controller.dart';
import 'package:shopping_mart/views/chat_screen/chat_screen.dart';
import 'package:shopping_mart/widgets_common/our_button.dart';
class ItemDetails extends StatelessWidget {
  final String? title;
  final dynamic data;
  const ItemDetails({super.key,required this.title,this.data});

  @override
  Widget build(BuildContext context) {

    // var controller=Get.find<ProductController>();
    var controller=Get.put(ProductController());
    return WillPopScope(
      onWillPop: () async{
        controller.resetValues();
        return true;
      },

      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          leading: IconButton(
            onPressed: (){
              controller.resetValues();
              Get.back();
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: title!.text.fontFamily(bold).color(darkFontGrey).make(),
          actions: [
            IconButton(onPressed: (){}, icon: const Icon(Icons.share,)),
            Obx(()=>
                IconButton(onPressed: (){
                if(controller.isFav.value){
                  controller.removeFromWishlist(data.id,context);
                  // controller.isFav(false);
                }else{
                  controller.addToWishlist(data.id,context);
                  // controller.isFav(true);
                }
              }, icon:  Icon(
                Icons.favorite_outlined,
                color: controller.isFav.value? redColor:darkFontGrey,
                )
              ),
            )
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      VxSwiper.builder(
                        autoPlay: true,
                        height: 350,
                        itemCount: data['p_imgs'].length,
                        aspectRatio: 16/9,
                        viewportFraction: 0.9,
                        itemBuilder: (context,index){
                          return Image.network(
                            data['p_imgs'][index],
                            width: double.infinity,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                      10.heightBox,
                      title!.text.size(16).fontFamily(semibold).color(darkFontGrey).make(),
                      10.heightBox,
                      VxRating(
                        isSelectable: false,
                        value: double.parse(data['p_rating']),
                        onRatingUpdate: (value){},
                        normalColor: textfieldGrey,
                        selectionColor: golden,
                        count: 5,
                        size: 25,
                        stepInt: false,
                        maxRating: 5,
                      ),
                      10.heightBox,
                      "${data['p_price']}".text.color(redColor).size(18).fontFamily(bold).make(),
                      10.heightBox,
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "Seller".text.white.fontFamily(semibold).make(),
                                5.heightBox,
                                "${data['p_seller']}".text.fontFamily(bold).color(darkFontGrey).make(),
                              ],
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            child: const Icon(Icons.message_rounded,color: darkFontGrey,).onTap(() {
                              Get.to(const ChatScreen(),arguments: [data['p_seller'],data['vendor_id']]);
                            }),
                          )
                        ],
                      ).box.color(textfieldGrey).height(60).padding(EdgeInsets.symmetric(horizontal: 16)).make(),

                      //color section
                      20.heightBox,
                      Obx(()=> Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: "Color: ".text.color(textfieldGrey).make(),
                                ),
                                Row(
                                  children: List.generate(
                                      data['p_colors'].length, (index) => Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          VxBox()
                                          .size(40, 40).
                                          roundedFull
                                          .color(Color(data['p_colors'][index]).withOpacity(1.0))
                                          .margin(const EdgeInsets.symmetric(horizontal: 4)).
                                          make().onTap(() {
                                            controller.changeColorIndex(index);
                                          }),

                                          Visibility(
                                            visible: index == controller.colorIndex.value,
                                              child: const Icon(Icons.done,color: Colors.white,)
                                          ),
                                        ],
                                      ),
                                  ),
                                )
                              ],
                            ).box.padding(const EdgeInsets.all(8)).make(),
                            // Qauntity
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: "Quantity: ".text.color(textfieldGrey).make(),
                                ),

                                Obx(()=> Row(
                                    children: [
                                      IconButton(onPressed: (){
                                        controller.decreaseQuantity();
                                        controller.calculateTotalPrice(int.parse(data['p_price']));
                                      }, icon: const Icon(Icons.remove)),
                                      controller.quantity.value.text.size(16).fontFamily(bold).color(darkFontGrey).make(),
                                      IconButton(onPressed: (){
                                        controller.increaseQuantity(int.parse(data['p_quantity']));
                                        controller.calculateTotalPrice(int.parse(data['p_price']));
                                      }, icon: const Icon(Icons.add)),
                                      10.widthBox,
                                      "${data['p_quantity']} available".text.size(16).fontFamily(bold).color(textfieldGrey).make(),
                                    ],
                                  ),
                                )
                              ],
                            ).box.padding(EdgeInsets.all(8)).make(),

                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: "Total: ".text.color(textfieldGrey).make(),
                                ),
                                "${controller.totalPrice.value}".text.size(16).fontFamily(bold).color(redColor).make(),
                              ],

                            ).box.padding(EdgeInsets.all(8)).make(),
                          ],
                        ).box.shadowSm.white.make(),
                      ),
                      //Description
                      10.heightBox,
                      "Description".text.color(darkFontGrey).fontFamily(semibold).make(),
                      10.heightBox,

                      "${data['p_desc']}".text.color(darkFontGrey).make(),

                      //Button section
                      10.heightBox,
                      ListView(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        children: List.generate(itemDetailsButtonList.length, (index) => ListTile(
                          title: itemDetailsButtonList[index].text.fontFamily(semibold).color(darkFontGrey).make(),
                          trailing: const Icon(Icons.arrow_forward),
                        )),
                      ),
                      //may also like
                      20.heightBox,
                      productyoumayalsoike.text.fontFamily(bold).color(darkFontGrey).size(16).make(),

                      //copied from homescreen
                      10.heightBox,
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(6, (index) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(imgP1,width: 150,fit: BoxFit.cover,),
                              10.heightBox,
                              "Laptop 4GB/64GB".text.fontFamily(semibold).color(darkFontGrey).make(),
                              10.heightBox,
                              "\$600".text.color(redColor).fontFamily(bold).size(16).make(),
                            ],
                          ).box.white.margin(const EdgeInsets.symmetric(horizontal: 4)).padding(const EdgeInsets.all(8)).roundedSM.make()),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ourButton(color1: redColor,onPress: (){
                if(controller.quantity.value>0){
                  controller.addToCart(
                      color: data['p_colors'][controller.colorIndex.value],
                      context: context,
                      vendorID: data['vendor_id'],
                      img: data['p_imgs'][0],
                      qty: controller.quantity.value,
                      sellername: data['p_seller'],
                      title: data['p_name'],
                      tprice: controller.totalPrice.value
                  );
                  VxToast.show(context, msg: "Added to cart");
                }else{
                  VxToast.show(context, msg: "Minimum 1 product is required");
                }

              },textColor: whiteColor,title: "Add to Cart"),
            ),

          ],
        ),
      ),
    );
  }
}
