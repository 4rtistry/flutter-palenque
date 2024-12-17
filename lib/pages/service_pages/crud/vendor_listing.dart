import 'package:flutter/material.dart';
import 'package:palenque_application/authentication/auth_service.dart';
import 'package:palenque_application/components/atoms/CustomCrudButton.dart';
import 'package:palenque_application/components/atoms/CustomTextFormField.dart';
import 'package:palenque_application/components/molecules/CustomCrudButtonIcon.dart';
import 'package:palenque_application/components/organisms/CustomAppHeader.dart';
import 'package:palenque_application/components/organisms/CustomBottomNavBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:palenque_application/pages/service_pages/crud/vendor_edit.dart';
import 'package:palenque_application/pages/service_pages/crud/vendor_listing.dart';

class VendorListing extends StatefulWidget {
  VendorListing({super.key});

  @override
  State<VendorListing> createState() => _VendorListingState();
}

class _VendorListingState extends State<VendorListing> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController searchFormController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool _isSubmitted = false;
  String? _docId;

  bool _isDataLoaded = false;

  int currentIndex = 0;

  void onNavBarItemTapped(int index) {
    setState(() {
      currentIndex = index; // Update the selected index
    });
  }

  Future<void> _checkIfVendorExists() async {
    try {
      // Query the Firestore collection to check if any documents exist
      QuerySnapshot snapshot = await _firestore.collection("vendors").get();

      if (snapshot.docs.isNotEmpty) {
        // If a document exists, get the first one
        var doc = snapshot.docs.first;

        // Populate the fields with data from the document
        nameController.text = doc["name"];
        locationController.text = doc["location"];
        phoneController.text = doc["phone"];
        _docId = doc.id; // Store the document ID

        setState(() {
          _isSubmitted = true; // Mark as submitted (disable fields)
          _isDataLoaded = true; // Data is loaded
        });
      } else {
        // No vendor document found
        setState(() {
          _isDataLoaded = true; // No data, but still finish loading
        });
      }
    } catch (e) {
      // Handle any errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
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
        // Add a new document to the "vendors" collection or update an existing one
        DocumentReference docRef;
        if (_docId == null) {
          // If no docId, it's a new document
          docRef = await _firestore.collection("vendors").add(vendorData);
        } else {
          // If docId exists, update the existing document
          docRef = _firestore.collection("vendors").doc(_docId);
          await docRef.update(vendorData);
        }

        setState(() {
          _isSubmitted = true; // Mark form as submitted
          _docId = docRef.id; // Save the document ID
        });

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Vendor added/updated successfully! Document ID: $_docId')),
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
                          'Register Your Vendor',
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600),
                        ),
                        CustomCrudButtonIcon(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => VendorEdit()));
                            },
                            label: 'Edit',
                            icon: Icons.edit)
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          CustomTextFormField(
                            controller: nameController,
                            labelText: 'Vendor Name',
                            enabled: !_isSubmitted, // Disable after submission
                            validator: (value) =>
                                value == null || value.trim().isEmpty
                                    ? 'Please enter vendor name'
                                    : null,
                          ),
                          const SizedBox(height: 20),
                          CustomTextFormField(
                            controller: locationController,
                            labelText: 'Location',
                            enabled: !_isSubmitted, // Disable after submission
                            validator: (value) =>
                                value == null || value.trim().isEmpty
                                    ? 'Please enter location'
                                    : null,
                          ),
                          const SizedBox(height: 20),
                          CustomTextFormField(
                            controller: phoneController,
                            labelText: 'Phone',
                            keyboardType: TextInputType.phone,
                            enabled: !_isSubmitted, // Disable after submission
                            validator: (value) =>
                                value == null || value.trim().isEmpty
                                    ? 'Please enter phone number'
                                    : null,
                          ),
                          const SizedBox(height: 30),
                          CustomCrudButton(
                            onPressed: _isSubmitted
                                ? null
                                : () async {
                                    // Wrap the async function here
                                    await _submitForm();
                                  },
                            text: _isSubmitted ? 'Submitted' : 'Submit',
                            width: double.infinity,
                          ),
                          if (_docId != null) ...[
                            const SizedBox(height: 20),
                            Text('Document ID: $_docId',
                                style: TextStyle(color: Colors.green)),
                          ],
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
