import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shopping_mart/consts/consts.dart';
import 'package:shopping_mart/consts/loading_indicator.dart';
import 'package:shopping_mart/controller/cart_controller.dart';
import 'package:shopping_mart/services/firestore_services.dart';
import 'package:shopping_mart/views/cart_screen/shipping_screen.dart';
import 'package:shopping_mart/widgets_common/our_button.dart';
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller=Get.put(CartController());
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 60,
        child: ourButton(
            color1: redColor,
            onPress: (){
              Get.to(ShippingDetails());
            },
            textColor: whiteColor,
            title: "Processed to shipping"
        ),
      ),

      backgroundColor: whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: "Shopping cart".text.color(darkFontGrey).fontFamily(semibold).make(),

      ),
      body: StreamBuilder(
        stream: FirestoreServices.getCart(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(!snapshot.hasData){
            return Center(
              child: loadingIndicator(),
            );
          }
          else if(snapshot.data!.docs.isEmpty){
            return Center(
              child: "Cart is empty".text.color(darkFontGrey).make(),
            );
          }
          else{
            var data=snapshot.data!.docs;
            controller.calculate(data);
            controller.productSnapshot=data;

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            leading: Image.network("${data[index]['img']}",width: 80,fit: BoxFit.cover,),
                            title: "${data[index]['title']} (x${data[index]['qty']})".text.fontFamily(semibold).size(16).make(),
                            subtitle: "${data[index]['tprice']}".numCurrency.text.color(redColor).fontFamily(semibold).make(),
                            trailing: const Icon(Icons.delete,color: redColor,).onTap(() {
                              FirestoreServices.deleteDocument(data[index].id);
                            }),
                          );
                        },
                      )
                  ),
                  5.heightBox,

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "Total price: ".text.color(darkFontGrey).fontFamily(semibold).make(),

                      Obx(
                            () => "${controller.totalP.value}".numCurrency.text.color(redColor).fontFamily(semibold).make(),
                      )
                    ],
                  ).box.roundedSM.padding(const EdgeInsets.all(12.0)).color(lightgolden).make(),
                  10.heightBox,
                  // SizedBox(
                  //   width: context.screenWidth-18,
                  //   child: ourButton(
                  //       color1: redColor,
                  //       onPress: (){},
                  //       textColor: whiteColor,
                  //       title: "Processed to shipping"
                  //   ),
                  // )
                ],
              ),
            );
          }
        },

      )
    );
  }
}
