import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shopping_mart/consts/consts.dart';
import 'package:shopping_mart/consts/loading_indicator.dart';
import 'package:shopping_mart/services/firestore_services.dart';

import '../categories_screen/items_details.dart';
class SearchScreen extends StatelessWidget {

  final String? title;
  const SearchScreen({super.key,this.title});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: title!.text.color(darkFontGrey).make(),
      ),
      body: FutureBuilder(
        future: FirestoreServices.searchProducts(title),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(!snapshot.hasData){
            return Center(
              child: loadingIndicator(),
            );
          }
          else if(snapshot.data!.docs.isEmpty){
            return "No products found".text.color(redColor).makeCentered();
          }
          else{

            var data=snapshot.data!.docs;
            var filtered=data.where(
                  (element) => element['p_name'].toString().toLowerCase().contains(title!.toLowerCase()),
            ).toList();


            return GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    mainAxisExtent: 300
                ),
              children: filtered.mapIndexed((currentValue, index) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(filtered[index]['p_imgs'][0],width: 200,height:200,fit: BoxFit.cover,),
                  const Spacer(),
                  "${filtered[index]['p_name']}".text.fontFamily(semibold).color(darkFontGrey).make(),
                  10.heightBox,
                  "${filtered[index]['p_price']}".numCurrency.text.color(redColor).fontFamily(bold).size(16).make(),
                ],
              ).box.white.outerShadowMd.
              margin(const EdgeInsets.symmetric(horizontal: 1)).
              padding(const EdgeInsets.all(12)).
              roundedSM.make().onTap(() {
                Get.to(ItemDetails(title: "${filtered[index]['p_name']}",data: filtered[index],));
              })).toList(),
            );
          }

        },

      ),
    );
  }
}
