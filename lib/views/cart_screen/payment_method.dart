import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shopping_mart/consts/consts.dart';
import 'package:shopping_mart/consts/lists.dart';
import 'package:shopping_mart/consts/loading_indicator.dart';
import 'package:shopping_mart/controller/cart_controller.dart';
import 'package:shopping_mart/views/home_screens/home.dart';

import '../../widgets_common/our_button.dart';

class PaymentMethods extends StatelessWidget {
  const PaymentMethods({super.key});

  @override
  Widget build(BuildContext context) {
    var controller=Get.find<CartController>();
    return Obx(()=>
        Scaffold(
          bottomNavigationBar: SizedBox(
          height: 60,
          child: controller.placingOrder.value ? Center(
            child: loadingIndicator(),
          ):
          ourButton(
              onPress: () async{
                await controller.placeMyOrder(
                    orderPaymentMethod: paymentMethods[controller.paymentIndex.value],
                    totalAmount: controller.totalP.value
                );
                await controller.clearCart();

                VxToast.show(context, msg: "Order placed successfully!");
                
                Get.offAll(const Home());
              },
              color1: redColor,
              textColor: whiteColor,
              title: "Place my order"
          ),
        ),
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: "Choose payment methods".text.fontFamily(semibold).color(darkFontGrey).make(),

        ),
        body:Padding(
          padding: const EdgeInsets.all(12.0),
          child: Obx(()=>
              Column(
              children: List.generate(paymentMethodsImg.length, (index){
                return GestureDetector(
                  onTap:(){
                    controller.changePaymentIndex(index);
                  } ,
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: controller.paymentIndex.value==index?darkFontGrey:Colors.transparent,
                        width: 1,
                      )
                    ),
                    margin: const EdgeInsets.only(bottom: 8.0),
                    child: Stack(
                      alignment: Alignment.topRight,
                      children:[
                        Image.asset(paymentMethodsImg[index],width: double.infinity,height: 120,fit: BoxFit.cover,),
                        controller.paymentIndex.value==index?
                        Transform.scale(
                          scale: 1.3,
                          child: Checkbox(
                            value: true,
                            activeColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            onChanged: (bool? value) {  },

                          ),
                        ):Container(),
                        Positioned(
                          bottom: 10,
                            right: 10,
                            child: paymentMethods[index].text.fontFamily(semibold).white.make()
                        ),
                      ]
                    )
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
