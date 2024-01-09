import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shopping_mart/consts/consts.dart';
import 'package:shopping_mart/consts/loading_indicator.dart';
import 'package:shopping_mart/controller/home_controller.dart';
import 'package:shopping_mart/services/firestore_services.dart';
import 'package:shopping_mart/views/categories_screen/items_details.dart';
import 'package:shopping_mart/views/home_screens/components/featured_button.dart';
import 'package:shopping_mart/views/home_screens/search_screen.dart';
import 'package:shopping_mart/widgets_common/home_buttons.dart';

import '../../consts/lists.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    var controller=Get.find<HomeController>();
    return Container(
      padding: const EdgeInsets.all(12),
      color: lightGrey,
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: 60,
              color: lightGrey,
              child: TextFormField(
                controller: controller.searchController,
                decoration: InputDecoration(
                  border: InputBorder.none,

                  suffixIcon: const Icon(Icons.search).onTap(() {
                    if(controller.searchController.text.isNotEmptyAndNotNull){
                      Get.to(SearchScreen(title: controller.searchController.text,));
                    }
                  }),
                  filled: true,
                  fillColor: whiteColor,
                  hintText: searchanything,
                  hintStyle: const TextStyle(color: textfieldGrey),
                ),
              ),
            ),
            10.heightBox,
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    //Swiper brands
                    VxSwiper.builder(
                        height: 150,
                        aspectRatio: 16/9,
                        autoPlay: true,
                        enlargeCenterPage: true,

                        itemCount: sliderList.length,
                        itemBuilder: (context,index){
                          return Image.asset(
                            sliderList[index],
                            fit: BoxFit.fill,
                          ).box.rounded.clip(Clip.antiAlias).shadowSm.margin(const EdgeInsets.symmetric(horizontal: 8)).make();
                        }
                    ),
                    10.heightBox,
                    // Deal buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children:
                      List.generate(2,
                              (index) => homeButtons(
                              context.screenWidth/2.5,
                              context.screenHeight*0.15,
                              index==0? icTodaysDeal:icFlashDeal,
                              index==0? todaysDeal:flashSale,
                                  (){}
                          )
                      ),
                    ),
                    10.heightBox,
                    // brand swiper
                    VxSwiper.builder(
                        height: 150,
                        aspectRatio: 16/9,
                        autoPlay: true,
                        enlargeCenterPage: true,

                        itemCount: secondSliderList.length,
                        itemBuilder: (context,index){
                          return Image.asset(
                            secondSliderList[index],
                            fit: BoxFit.fill,
                          ).box.rounded.clip(Clip.antiAlias).shadowSm.margin(const EdgeInsets.symmetric(horizontal: 8)).make();
                        }
                    ),
                    10.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children:
                      List.generate(3,
                              (index) => homeButtons(
                              context.screenWidth/3.5,
                              context.screenHeight*0.15,
                              index==0? icTopCategories:index==1? icBrands:icTopSeller,
                              index==0? topCategories:index==1? brand:topSellers,
                                  (){}
                          )
                      ),
                    ),
                    20.heightBox,
                    //Feature categories
                    Align(
                        alignment: Alignment.centerLeft,
                        child: featureCategories.text.size(18).color(darkFontGrey).fontFamily(bold).make()
                    ),
                    20.heightBox,
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,

                      child: Row(
                        children: List.generate(3,
                                (index) => Column(
                                  children: [
                                    featuredButton(icon: featuredImages1[index],title: featuredTitles1[index]),
                                    10.heightBox,
                                    featuredButton(icon: featuredImages2[index],title: featuredTitles2[index]),
                                  ],
                                )
                        ).toList(),
                      ),
                    ),
                    20.heightBox,
                    // featured product
                    Container(
                      padding: const EdgeInsets.all(12),
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: redColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          featuredProduct.text.size(18).fontFamily(bold).white.make(),
                          10.heightBox,
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: FutureBuilder(
                              future: FirestoreServices.getFeaturedProducts(),
                              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                if(!snapshot.hasData){
                                  return Center(
                                    child: loadingIndicator(),
                                  );
                                }
                                else if(snapshot.data!.docs.isEmpty){
                                  return "No features products".text.white.makeCentered();
                                }
                                else{
                                  var featuredData=snapshot.data!.docs;
                                  return Row(
                                    children: List.generate(featuredData.length, (index) => Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Image.network(featuredData[index]['p_imgs'][0],height:130,width: 150,fit: BoxFit.cover,),
                                        10.heightBox,
                                        "${featuredData[index]['p_name']}".text.fontFamily(semibold).color(darkFontGrey).make(),
                                        10.heightBox,
                                        "${featuredData[index]['p_price']}".numCurrency.text.color(redColor).fontFamily(bold).size(16).make(),
                                      ],
                                    ).box.white.
                                    margin(const EdgeInsets.symmetric(horizontal: 2)).
                                    padding(const EdgeInsets.all(8)).
                                    roundedSM.make().onTap(() {
                                      Get.to(ItemDetails(title: "${featuredData[index]['p_name']}",data: featuredData[index],));
                                    })
                                    ),
                                  );
                                }
                              },

                            ),
                          )
                        ],
                      ),
                    ),
                    // third swiper
                    20.heightBox,
                    VxSwiper.builder(
                        height: 150,
                        aspectRatio: 16/9,
                        autoPlay: true,
                        enlargeCenterPage: true,

                        itemCount: secondSliderList.length,
                        itemBuilder: (context,index){
                          return Image.asset(
                            secondSliderList[index],
                            fit: BoxFit.fill,
                          ).box.rounded.clip(Clip.antiAlias).shadowSm.margin(const EdgeInsets.symmetric(horizontal: 8)).make();
                        }
                    ),
                    20.heightBox,

                    //All products
                    Align(
                        alignment: Alignment.centerLeft,
                        child: "All products".text.size(18).color(darkFontGrey).fontFamily(bold).make()
                    ),
                    20.heightBox,

                    StreamBuilder(
                      stream: FirestoreServices.allProducts(),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if(!snapshot.hasData){
                          return "No products".text.makeCentered();
                        }
                        else{
                          var allProductData=snapshot.data!.docs;
                          return GridView.builder(
                              shrinkWrap: true,
                              itemCount: allProductData.length,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 8,
                                  crossAxisSpacing: 8,
                                  mainAxisExtent: 300
                              ),
                              itemBuilder: (context,index){
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(allProductData[index]['p_imgs'][0],width: 200,height:200,fit: BoxFit.cover,),
                                    const Spacer(),
                                    "${allProductData[index]['p_name']}".text.fontFamily(semibold).color(darkFontGrey).make(),
                                    10.heightBox,
                                    "${allProductData[index]['p_price']}".numCurrency.text.color(redColor).fontFamily(bold).size(16).make(),
                                  ],
                                ).box.white.
                                margin(const EdgeInsets.symmetric(horizontal: 1)).
                                padding(const EdgeInsets.all(12)).
                                roundedSM.make().onTap(() {
                                  Get.to(ItemDetails(title: "${allProductData[index]['p_name']}",data: allProductData[index],));
                                });
                              }
                          );
                        }
                      },

                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
