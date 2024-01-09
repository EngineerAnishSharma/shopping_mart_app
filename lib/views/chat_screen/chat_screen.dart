import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_mart/consts/consts.dart';
import 'package:shopping_mart/consts/loading_indicator.dart';
import 'package:shopping_mart/controller/chat_controller.dart';
import 'package:shopping_mart/services/firestore_services.dart';
import 'package:shopping_mart/views/chat_screen/components/sender_bubble.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {


    var controller=Get.put(ChatController());
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "${controller.friendName}".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Obx(()=> controller.isLoading.value? Center(
              child: loadingIndicator(),
            ):
                Expanded(
                  child:StreamBuilder(
                    stream: FirestoreServices.getChatMessages(controller.chatDocId.toString()),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if(!snapshot.hasData){
                        return Center(
                          child: loadingIndicator(),
                        );
                      }
                      else if(snapshot.data!.docs.isEmpty){
                        return Center(
                          child: "Send a message...".text.color(darkFontGrey).make(),
                        );
                      }
                      else{
                        return Center(
                          child:  ListView(
                            children: snapshot.data!.docs.mapIndexed((currentValue, index){

                              var data=snapshot.data!.docs[index];
                              return Align(
                                alignment:data['uid']==currentUser!.uid? Alignment.centerRight:Alignment.centerLeft,
                                  child: senderBubble(data),
                              );
                            }).toList(),
                          ),
                        );
                      }
                    },

                  )
              ),
            ),

            Row(
              children: [
                Expanded(
                    child: TextFormField(
                      controller: controller.msgController,

                      decoration:const InputDecoration(
                        hintText: "Type your message...",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: textfieldGrey
                          )
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: textfieldGrey,
                          )
                        )
                      ),
                    )
                ),
                IconButton(onPressed: (){
                  controller.sendMsg(controller.msgController.text);
                  controller.msgController.clear();
                }, icon: const Icon(Icons.send,color: redColor,)),
              ],
            ).box.margin(EdgeInsets.only(bottom: 5.0)).height(80).make(),
          ],
        )
      ),
    );
  }
}
