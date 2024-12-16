import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:palenque_application/authentication/auth_service.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchFormController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: SizedBox(
            width: 350,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Temp Text',
                  style: TextStyle(fontSize: 16.0, fontFamily: 'Poppins'),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: SvgPicture.asset(
                        'assets/svg/heart.svg',
                        height: 20,
                        width: 20,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: SvgPicture.asset(
                        'assets/svg/basket-shopping-3.svg',
                        height: 20,
                        width: 20,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      body: Center(
        child: SizedBox(
          width: 350,
          child: Column(
            children: [
              Expanded(
                  child: TextField(
                controller: searchFormController,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  labelText: 'Search for product',
                  labelStyle:
                      const TextStyle(fontSize: 14.0, fontFamily: 'Poppins'),
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                ),
                onTap: () {},
              )),
              TextButton(
                  onPressed: () {
                    AuthService().signOut(context);
                  },
                  child: const Text('Temp Log Out')),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svg/home-2.svg',
              height: 20,
              width: 20,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svg/bell-1.svg',
              height: 20,
              width: 20,
            ),
            label: 'Notification',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svg/message-3-text.svg',
              height: 20,
              width: 20,
            ),
            label: 'Message',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svg/user-4.svg',
              height: 20,
              width: 20,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
