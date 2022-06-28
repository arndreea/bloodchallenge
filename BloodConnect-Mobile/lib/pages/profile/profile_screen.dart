import 'package:blood_connect_mobile/pages/profile/info_card.dart';
import 'package:blood_connect_mobile/pages/profile/profile_widget.dart';
import 'package:blood_connect_mobile/pages/model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';




class MyProfileScreenApp extends StatelessWidget {
  final User user;
  const MyProfileScreenApp({Key? key, required this.user}) : super(key: key);
  //const HomeScreen({Key? key, required this.accesstoken}) : super(key:key);
  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      // Theme mode depends on device settings at the beginning
      home:  ProfileScreen(user: user),
    );
  }
}


class ProfileScreen extends StatefulWidget {
  final User user;
  const ProfileScreen({Key? key, required this.user}) : super(key: key);
  @override
  State<StatefulWidget> createState() => new _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final form = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {

    final icon = CupertinoIcons.moon_stars;

    final currentUser = widget.user;
    print(currentUser.rh);

    //saves correctly in bd, but app recognizes 0 as positive instead of negative, so we have to switch values
    /**/
    if(currentUser.rh == 'positive')
      currentUser.rh = 'negative';
    else
      currentUser.rh = 'positive';

    final String donorEligibility;

    if(currentUser.isPotentialDonor == "true"){
      donorEligibility = "Sunteți apt pentru donare!";
    } else {
      donorEligibility = "Nu sunteți apt pentru donare!";
    }

    return Scaffold(
      appBar: AppBar(
          leading: BackButton(
            color: Colors.black,
          ),
          backgroundColor: Colors.transparent,

        elevation: 0,
        actions: [
          IconButton(
        icon: Icon(icon, color: Colors.black,),
        onPressed:   () {

              Get.isDarkMode
                  ? Get.changeTheme(ThemeData.light())
                  : Get.changeTheme(ThemeData.dark());
           },
          )],
    ),  //IconButton(onPressed: (){}, icon: Icon(Icons.wb_sunny_outlined))

      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          ProfileWidget(
              imagePath: 'https://images.unsplash.com/photo-1627498290041-a4851897dcda?ixlib=rb-1.2.1&raw_url=true&q=80&fm=jpg&crop=entropy&cs=tinysrgb&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=875',
              onClicked: () async{}),
          const SizedBox(height: 24),
          buildName(currentUser),
          const SizedBox(height:24),

         // InfoCard(text: "phone", icon: Icons.phone),
          InfoCard(text: currentUser.birthdate, icon: Icons.calendar_today_sharp),
          InfoCard(text: currentUser.height.toString() + "cm", icon: Icons.height),
          InfoCard(text: currentUser.kilograms  + "kg", icon: Icons.keyboard_arrow_right),
          InfoCard(text: "Tensiunea: " + currentUser.bloodPressure, icon: Icons.keyboard_arrow_right),
          InfoCard(text: currentUser.bloodType, icon: Icons.bloodtype),
          InfoCard(text: "RH: " + currentUser.rh, icon: Icons.bloodtype_rounded),
          InfoCard(text: donorEligibility, icon: Icons.health_and_safety_outlined),

        ],
      ),

    );
  }

  Widget buildName(User user) => Column(
    children: [
      Text(
        user.firstName + " " + user.lastName,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      ),
      const SizedBox(height: 4),
      Text(
        user.email,
        style: TextStyle(color: Colors.grey),
      )
    ],
  );


}