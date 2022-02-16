import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travellers/TicketDatabase/TicketDataBase.dart';
//import 'package:travellers/code/theme_provider.dart';
import 'package:travellers/components/components.dart';
import 'package:travellers/constants/constants.dart';
import 'package:travellers/modules/profile_screen.dart';
import 'package:travellers/providers/theme_provider.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:travellers/modules/pick_destination.dart';
import 'package:travellers/providers/theme_provider.dart';
import 'package:travellers/styles/colors.dart';

import '../Ticket.dart';
import 'DetailsData.dart';
import 'DetailsScreen.dart';
import 'about_us.dart';
import 'login_screen.dart';

class TicketsScreen extends StatelessWidget {

  const TicketsScreen({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Tickets",
        ),
        actions: [
          Consumer<ThemeProvider>(
            builder: (context, myProv, _) => IconButton(
              onPressed: () {
                myProv.changeAppMode();
              },
              icon: const Icon(Icons.brightness_4_outlined),
              color: Colors.white,
            ),
          ),
          Theme(

            data: Theme.of(context).copyWith(
              iconTheme: const IconThemeData(color: Colors.white),
              dividerColor: Colors.white,
            ),
            child: PopupMenuButton<int>(
                color: Provider.of<ThemeProvider>(context).isDark ? HexColor('333739') : defaultColor,
                onSelected: (item) => selected(context, item),
                itemBuilder: (context) => [
                  PopupMenuItem<int>(
                      value: 0,
                      child: Row(
                        children: const [
                          Icon(Icons.person, color: Colors.white),
                          Text(
                            "Profile",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      )),
                  PopupMenuItem<int>(
                      value: 1,
                      child: Row(
                        children: const [
                          Icon(Icons.group_outlined, color: Colors.white),
                          Text(
                            "About Us",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      )),
                  const PopupMenuDivider(),
                  PopupMenuItem<int>(
                    value: 2,
                    child: Row(
                      children: const [
                        Icon(Icons.logout, color: Colors.white),
                        SizedBox(width: 7),
                        Text(
                          "Log Out",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ]),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: DetailsData.tickets.length,
          itemBuilder: (context, index) {
            return Card(

              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.5)
                ),

                onTap: (){
                  DetailsData.ticket=DetailsData.tickets[index];
                  DetailsData.quantity=DetailsData.ticket!.available;
                  navigateTo(context, DetailsScreen());
                },
                title: Text("From:- "+DetailsData.tickets[index].from,style:TextStyle (color: Colors.white),),
                minVerticalPadding: 30,
                subtitle: Text("To:- "+DetailsData.tickets[index].to,style:TextStyle (color: Colors.white),),
                tileColor: Colors.deepOrange,
                leading: Icon( IconData(DetailsData.tickets[index].typeId, fontFamily: DetailsData.tickets[index].type,),size: 59,),

              ),

            );
          }

        ),
      ),
    );
  }
  void selected(BuildContext context, int selected_item) {
    switch (selected_item) {
      case 0:
      //Will go to Profile page
        navigateTo(context, ProfileScreen());
        break;
      case 1:
      //Will go to The History Page
        navigateTo(context, About()); //Only for testing
        break;
      case 2:
      //Return to login page and delete the stack of pages
        NavigateAndFinish(context, LoginScreen());
        break;
    }
  }

}
