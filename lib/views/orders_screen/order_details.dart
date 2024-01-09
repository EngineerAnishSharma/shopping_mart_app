import 'package:flutter/material.dart';
import 'package:shopping_mart/consts/colors.dart';
import 'package:shopping_mart/consts/consts.dart';
import 'package:shopping_mart/views/orders_screen/components/order_place_details.dart';
import 'package:shopping_mart/views/orders_screen/components/order_status.dart';
import 'package:intl/intl.dart' as intl;

class OrderDetails extends StatelessWidget {
  final dynamic data;
  const OrderDetails({super.key,this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Order Details".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            orderStatus(Icons.done, redColor, "Placed", data['order_placed']),
            orderStatus(Icons.thumb_up, Colors.blue, "Confirmed", data['order_confirmed']),
            orderStatus(Icons.car_crash, Colors.yellow, "On Delivery", data['order_on_delivery']),
            orderStatus(Icons.done_all_rounded, Colors.purple, "Delivered", data['order_delivered']),

            // const Divider(),
            20.heightBox,

            Column(
              children: [
                orderPlaceDetails(
                    d1: data['order_code'],
                    d2: data['shipping_method'],
                    title1: "Order Code",
                    title2: "Shipping Method"
                ),
                orderPlaceDetails(
                    d1: intl.DateFormat().add_yMd().format((data['order_date'].toDate())),
                    d2: data['payment_method'],
                    title1: "Order Date",
                    title2: "Payment Method"
                ),
                orderPlaceDetails(
                    d1: "unpaid",
                    d2: "Order placed",
                    title1: "Payment Status",
                    title2: "Delivery Status"
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          "Shipping Address".text.fontFamily(semibold).make(),
                          "${data['order_by_name']}".text.make(),
                          "${data['order_by_email']}".text.make(),
                          "${data['order_by_address']}".text.make(),
                          "${data['order_by_city']}".text.make(),
                          "${data['order_by_state']}".text.make(),
                          "${data['order_by_phone']}".text.make(),
                          "${data['order_by_postalcode']}".text.make(),
                        ],
                      ),
                      SizedBox(
                        width: 120,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Total Amount".text.fontFamily(semibold).make(),
                            "${data['total_amount']}".text.fontFamily(bold).color(redColor).make(),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ).box.outerShadowMd.white.make(),
            // const Divider(),
            20.heightBox,

            "Ordered Product".text.fontFamily(semibold).color(darkFontGrey).size(16).makeCentered(),
            ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: List.generate(data['orders'].length, (index){
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    orderPlaceDetails(
                      title1: data['orders'][index]['title'],
                      title2: data['orders'][index]['tprice'],
                      d1: "${data['orders'][index]['qty']}x",
                      d2: "Refundable"
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        height: 15,
                        width: 30,
                        color: Color(data['orders'][index]['color']),
                      ),
                    ),
                    const Divider(),
                  ],
                );
              }).toList(),
            ).box.shadowMd.white.margin(const EdgeInsets.only(top: 8)).make()
          ],

        ),
      ),
    );
  }
}
