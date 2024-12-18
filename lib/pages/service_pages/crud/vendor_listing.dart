import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:palenque_application/components/atoms/CustomCrudButton.dart';
import 'package:palenque_application/components/atoms/CustomTextFormField.dart';
import 'package:palenque_application/components/molecules/CustomCrudButtonIcon.dart';
import 'package:palenque_application/components/organisms/CustomAppHeader.dart';
import 'package:palenque_application/components/organisms/CustomBottomNavBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:palenque_application/pages/service_pages/crud/vendor_edit.dart';

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

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool _isSubmitted = false;
  String? _docId;

  bool _isLoading = true; // Loading state to manage UI

  int currentIndex = 0;

  void onNavBarItemTapped(int index) {
    setState(() {
      currentIndex = index; // Update the selected index
    });
  }

  Future<void> _checkIfVendorExists() async {
    try {
      String uid = _firebaseAuth.currentUser!.uid;

      QuerySnapshot snapshot = await _firestore
          .collection("users")
          .doc(uid)
          .collection("vendors")
          .get();

      if (snapshot.docs.isNotEmpty) {
        var firstDoc = snapshot.docs.first;

        nameController.text = firstDoc["name"] ?? "";
        locationController.text = firstDoc["location"] ?? "";
        phoneController.text = firstDoc["phone"] ?? "";
        _docId = firstDoc.id;

        setState(() {
          _isSubmitted = true;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    } finally {
      // Mark loading as false, regardless of success or error
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> vendorData = {
        "name": nameController.text.trim(),
        "location": locationController.text.trim(),
        "phone": phoneController.text.trim(),
        "email": _firebaseAuth.currentUser!.email,
        "createdAt": FieldValue.serverTimestamp(),
      };

      try {
        String uid = _firebaseAuth.currentUser!.uid;

        CollectionReference vendorsCollectionRef =
            _firestore.collection("users").doc(uid).collection("vendors");

        // Add the vendor and get the document reference
        var docRef = await vendorsCollectionRef.add(vendorData);

        // Update the _docId after the document is added
        setState(() {
          _docId = docRef.id;
          _isSubmitted = true; // Mark the form as submitted
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Vendor information saved successfully!')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _checkIfVendorExists();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: _isLoading
          ? Center(child: CircularProgressIndicator()) // Loading spinner
          : Column(
              children: [
                CustomAppHeader(
                  searchFormController: searchFormController,
                ),
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
                              _isSubmitted
                                  ? CustomCrudButtonIcon(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => VendorEdit(
                                              docId:
                                                  _docId!, // Pass the vendor document ID
                                              userId: FirebaseAuth
                                                  .instance
                                                  .currentUser!
                                                  .uid, // Current logged-in user ID
                                            ),
                                          ),
                                        );
                                      },
                                      label: 'Edit',
                                      icon: Icons.edit,
                                    )
                                  : SizedBox.shrink(),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                CustomTextFormField(
                                  controller: nameController,
                                  labelText: 'Vendor Name',
                                  enabled: !_isSubmitted,
                                  validator: (value) =>
                                      value == null || value.trim().isEmpty
                                          ? 'Please enter vendor name'
                                          : null,
                                ),
                                const SizedBox(height: 20),
                                CustomTextFormField(
                                  controller: locationController,
                                  labelText: 'Location',
                                  enabled: !_isSubmitted,
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
                                  enabled: !_isSubmitted,
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
                                          await _submitForm();
                                        },
                                  text: _isSubmitted ? 'Registered' : 'Submit',
                                  width: double.infinity,
                                ),
                                // if (_docId != null) ...[
                                //   const SizedBox(height: 20),
                                //   Text('Document ID: $_docId',
                                //       style: TextStyle(color: Colors.green)),
                                // ],
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
        onTap: onNavBarItemTapped,
      ),
    );
  }
}
