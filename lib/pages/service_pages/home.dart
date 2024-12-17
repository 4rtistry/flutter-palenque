import 'package:flutter/material.dart';
import 'package:palenque_application/authentication/auth_service.dart';
import 'package:palenque_application/components/atoms/CustomTextButton.dart';
import 'package:palenque_application/components/organisms/CustomAppHeader.dart';
import 'package:palenque_application/components/organisms/CustomBottomNavBar.dart';
import 'package:palenque_application/pages/service_pages/crud/vendor_listing.dart';
// import 'package:carousel_slider/carousel_slider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchFormController = TextEditingController();

  int currentIndex = 0;

  void onNavBarItemTapped(int index) {
    setState(() {
      currentIndex = index; // Update the selected index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          CustomAppHeader(
            searchFormController: searchFormController,
          ),
          Container(
            margin: const EdgeInsets.only(top: 250),
            child: Center(
              child: SizedBox(
                width: 350,
                child: Column(
                  children: [
                    // Text(
                    //   'Product Categories',
                    //   style: TextStyle(
                    //       fontSize: 18,
                    //       fontFamily: 'Poppins',
                    //       fontWeight: FontWeight.w600),
                    // ),
                    CustomTextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => VendorListing()));
                      },
                      text: 'Become a Partner',
                      width: double.infinity,
                      variant: ButtonVariant.filled,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextButton(
                      onPressed: () {
                        AuthService().signOut(context);
                      },
                      text: 'Sign Out (Temporary)',
                      width: double.infinity,
                      variant: ButtonVariant.outlined,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: currentIndex,
        onTap:
            onNavBarItemTapped, // Pass the callback function to update the index
      ),
    );
  }
}
