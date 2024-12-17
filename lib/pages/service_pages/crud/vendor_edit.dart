import 'package:flutter/material.dart';
import 'package:palenque_application/authentication/auth_service.dart';
import 'package:palenque_application/components/atoms/CustomTextButton.dart';
import 'package:palenque_application/components/atoms/CustomTextFormField.dart';
import 'package:palenque_application/components/organisms/CustomAppHeader.dart';
import 'package:palenque_application/components/organisms/CustomBottomNavBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:palenque_application/pages/service_pages/crud/vendor_listing.dart';

class VendorEdit extends StatefulWidget {
  VendorEdit({super.key});

  @override
  State<VendorEdit> createState() => _VendorEditState();
}

class _VendorEditState extends State<VendorEdit> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController searchFormController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool _isSubmitted = false;
  String? _docId;

  int currentIndex = 0;

  void onNavBarItemTapped(int index) {
    setState(() {
      currentIndex = index; // Update the selected index
    });
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Prepare data
      Map<String, dynamic> vendorData = {
        "name": nameController.text.trim(),
        "location": locationController.text.trim(),
        "phone": phoneController.text.trim(),
        "email": "sample@email.com", // Replace with dynamic email if needed
        "createdAt": FieldValue.serverTimestamp(), // Firestore server timestamp
      };

      try {
        // Add a new document to the "Vendors" collection
        DocumentReference docRef =
            await _firestore.collection("vendors").add(vendorData);

        setState(() {
          _isSubmitted = true; // Mark form as submitted
          _docId = docRef.id; // Save the document ID
        });

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Vendor added successfully! Document ID: $_docId')),
        );
      } catch (e) {
        // Handle errors
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          CustomAppHeader(
            searchFormController:
                searchFormController, // Pass the controller for the search bar
          ),
          // Your other contents here
          Container(
            margin: const EdgeInsets.only(top: 15),
            child: Center(
              child: SizedBox(
                width: 350,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Vendor Edit',
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => VendorListing()));
                            },
                            child: Text('Back')),
                      ],
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          CustomTextFormField(
                            controller: nameController,
                            labelText: 'Vendor Name',
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter vendor name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          CustomTextFormField(
                            controller: locationController,
                            labelText: 'Location',
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter location';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          CustomTextFormField(
                            controller: phoneController,
                            labelText: 'Phone',
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter phone number';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 30),
                          Container(
                            child: CustomTextButton(
                              onPressed: _submitForm,
                              text: 'Save Changes',
                              width: double.infinity,
                            ),
                          ),
                          const SizedBox(height: 20),
                          CustomTextButton(
                            onPressed: () {},
                            text: 'Delete Vendor Account',
                            width: double.infinity,
                          ),
                        ],
                      ),
                    )
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
