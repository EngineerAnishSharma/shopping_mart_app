import 'package:get/get.dart';
import 'package:shopping_mart/consts/consts.dart';
import 'package:shopping_mart/controller/home_controller.dart';
import 'package:shopping_mart/views/cart_screen/cart_screen.dart';
import 'package:shopping_mart/views/categories_screen/categories_screen.dart';
import 'package:shopping_mart/views/home_screens/home_screen.dart';
import 'package:shopping_mart/views/profile_screen/profile_screen.dart';
import 'package:shopping_mart/widgets_common/exit_dailog.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    // init home-controller
    var controller=Get.put(HomeController());

    var navbarItem=[
      BottomNavigationBarItem(icon: Image.asset(icHome,width: 26,),label: home),
      BottomNavigationBarItem(icon: Image.asset(icCategories,width: 26,),label: categories),
      BottomNavigationBarItem(icon: Image.asset(icCart,width: 26,),label: cart),
      BottomNavigationBarItem(icon: Image.asset(icProfile,width: 26,),label: account)
    ];

    var navbarBody=[
      const HomeScreen(),
      const CategoriesScreen(),
      const CartScreen(),
      const ProfileScreen()
    ];
    return WillPopScope(
      onWillPop: () async{
        showDialog(
          barrierDismissible: false,
            context: context, builder: (context)=>exitDialog(context)
        );
        return false;
      },
      child: Scaffold(
        body: Column(
          children: [
            Obx(() =>
                Expanded(
                    child:navbarBody.elementAt(controller.currentNavindex.value)
                )
            ),
          ],
        ),
        bottomNavigationBar:Obx(()=>
            BottomNavigationBar(
              currentIndex: controller.currentNavindex.value,
              selectedItemColor: redColor,
              selectedLabelStyle: const TextStyle(fontFamily: semibold),
              type: BottomNavigationBarType.fixed,
              backgroundColor: whiteColor,
              items: navbarItem,
              onTap: (value){
                controller.currentNavindex.value=value;
              },
            ),

        )

      ),
    );
  }
}
