
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shopping_mart/consts/consts.dart';

class AuthController extends GetxController{
  var isLoading=false.obs;

  var emailController=TextEditingController();
  var passwordController=TextEditingController();

  //login method ? means return type can be null
  Future<UserCredential?> loginMethod({context}) async{
    UserCredential? userCredential;
    try{
      userCredential=await auth.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
    }on FirebaseAuthException catch(e){
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  //Signup method
  Future<UserCredential?> signupMethod({email,password,context}) async{
    UserCredential? userCredential;
    try{
      userCredential=await auth.createUserWithEmailAndPassword(email: email, password: password);
    }on FirebaseAuthException catch(e){
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  //Storing data
  storeUserData({name,password,email}) async {
    DocumentReference store= await firestore.collection(userCollection).doc(currentUser!.uid);
    store.set({
      'name':name,
      'password':password,
      'email':email,
      'imgUrl':"",
      'id':currentUser!.uid,
      'cart_count':"00",
      'order_count':"00",
      'wishlist_count':"00",
    });
  }

  //signout method
  signoutMethod(context) async{
    try{
      await auth.signOut();
    }catch(e){
      VxToast.show(context, msg: e.toString());
    }
  }
}



