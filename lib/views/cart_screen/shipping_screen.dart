import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shopping_mart/consts/consts.dart';
import 'package:shopping_mart/controller/cart_controller.dart';
import 'package:shopping_mart/views/cart_screen/cart_screen.dart';
import 'package:shopping_mart/views/cart_screen/payment_method.dart';
import 'package:shopping_mart/widgets_common/custome_textfield.dart';
import 'package:shopping_mart/widgets_common/our_button.dart';

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var controller=Get.find<CartController>();
    return  Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Shopping Info".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: ourButton(
          onPress: (){
            if(controller.addressController.text.length>10){
              Get.to(PaymentMethods());
            }else{
              VxToast.show(context, msg: "Pls fill the form");
            }
          },
          color1: redColor,
          textColor: whiteColor,
          title: "Continue"
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            customTextField("Address", "address", controller.addressController, false),
            customTextField("City", "city", controller.cityController, false),
            customTextField("State", "state", controller.stateController, false),
            customTextField("Postal code", "postal code", controller.postalCodeController, false),
            customTextField("Phone", "phone", controller.phoneController, false),
          ],
        ),
      ),
    );
  }
}
