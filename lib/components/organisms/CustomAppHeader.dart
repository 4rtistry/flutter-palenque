import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppHeader extends StatelessWidget {
  final TextEditingController searchFormController;

  const CustomAppHeader({
    Key? key,
    required this.searchFormController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          backgroundColor: const Color(0xFFF16B44),
          automaticallyImplyLeading: false,
          title: Center(
            child: SizedBox(
              width: 350,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Welcome to Palenque',
                    style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: SvgPicture.asset(
                          'assets/svg/heart.svg',
                          color: Colors.white,
                          height: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: () {},
                        child: SvgPicture.asset(
                          'assets/svg/cart-2.svg',
                          height: 24,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          color: const Color(0xFFF16B44),
          width: double.infinity,
          child: Center(
            child: SizedBox(
              width: 350,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(top: 5, bottom: 15),
                      child: TextField(
                        controller: searchFormController,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          labelText: 'Search for product',
                          labelStyle: const TextStyle(
                              fontSize: 14.0,
                              fontFamily: 'Poppins',
                              color: Color(0xFFBDBDBD)),
                          prefixIcon: Transform.rotate(
                            angle: 5.0,
                            child: const Icon(
                              LineIcons.search,
                              size: 24,
                              color: Color(0xFF9E9E9E),
                            ),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                        onTap: () {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
