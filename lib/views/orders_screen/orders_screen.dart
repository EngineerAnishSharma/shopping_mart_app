import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shopping_mart/consts/consts.dart';
import 'package:shopping_mart/consts/loading_indicator.dart';
import 'package:shopping_mart/services/firestore_services.dart';
import 'package:shopping_mart/views/orders_screen/order_details.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "My orders".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getAllOrders(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(!snapshot.hasData){
            return Center(
              child: loadingIndicator(),
            );
          }
          else if(snapshot.data!.docs.isEmpty){
            return "No orders".text.color(darkFontGrey).makeCentered();
          }
          else{
            var data=snapshot.data!.docs;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  tileColor: lightGrey,
                  leading: "${index+1}".text.fontFamily(bold).color(darkFontGrey).xl.make(),
                  title: data[index]['order_code'].toString().text.color(redColor).fontFamily(semibold).make(),
                  subtitle: data[index]['total_amount'].toString().numCurrency.text.fontFamily(bold).make(),
                  trailing: IconButton(
                    onPressed: (){
                      Get.to( OrderDetails(data: data[index],));
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: darkFontGrey,
                    ),
                  ),
                );
              },
            );
          }
        },

      ),
    );
  }
}
