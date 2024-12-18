import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:palenque_application/components/atoms/CustomTextButton.dart';
import 'package:palenque_application/components/atoms/CustomTextFormField.dart';
import 'package:palenque_application/components/molecules/CustomCrudButtonIcon.dart';
import 'package:palenque_application/components/organisms/CustomAppHeader.dart';
import 'package:palenque_application/components/organisms/CustomBottomNavBar.dart';
import 'package:palenque_application/pages/service_pages/crud/vendor_listing.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:palenque_application/pages/service_pages/home.dart';

class VendorEdit extends StatefulWidget {
  final String docId; // Pass this from previous page
  final String userId; // Logged-in user's ID

  VendorEdit({super.key, required this.docId, required this.userId});

  @override
  State<VendorEdit> createState() => _VendorEditState();
}

class _VendorEditState extends State<VendorEdit> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool _isLoading = true; // For loading state

  @override
  void initState() {
    super.initState();
    _fetchVendorData();
  }

  // Fetch vendor data from Firestore
  Future<void> _fetchVendorData() async {
    try {
      DocumentSnapshot doc = await _firestore
          .collection('users')
          .doc(widget.userId)
          .collection('vendors')
          .doc(widget.docId)
          .get();

      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        setState(() {
          nameController.text = data['name'] ?? '';
          locationController.text = data['location'] ?? '';
          phoneController.text = data['phone'] ?? '';
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  // Save updated data to Firestore
  Future<void> _saveVendorData() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        await _firestore
            .collection('users')
            .doc(widget.userId)
            .collection('vendors')
            .doc(widget.docId)
            .update({
          'name': nameController.text.trim(),
          'location': locationController.text.trim(),
          'phone': phoneController.text.trim(),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Vendor details updated successfully')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => VendorListing()),
        );
      } catch (e) {
        print('Error updating vendor: $e');
      }
    }
  }

  Future<bool> _showDeleteConfirmationDialog() async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Delete Vendor Account'),
            content: const Text(
                'Are you sure you want to delete this vendor account? This action cannot be undone.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false), // Cancel
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true), // Confirm
                child: const Text('Delete'),
              ),
            ],
          ),
        ) ??
        false; // Return false if dialog is dismissed
  }

  Future<void> _deleteVendorData() async {
    try {
      await _firestore
          .collection('users')
          .doc(widget.userId)
          .collection('vendors')
          .doc(widget.docId)
          .delete();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vendor account deleted successfully')),
      );

      // Navigate back to VendorListing
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    } catch (e) {
      print('Error deleting vendor: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to delete vendor account')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator()) // Loading state
          : SingleChildScrollView(
              child: Column(
                children: [
                  CustomAppHeader(
                    searchFormController: TextEditingController(),
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
                                  'Manage Vendor Details',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600),
                                ),
                                CustomCrudButtonIcon(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                VendorListing()));
                                  },
                                  label: 'Go Back',
                                  icon: Icons.arrow_back,
                                )
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
                                    validator: (value) => value!.isEmpty
                                        ? 'Enter vendor name'
                                        : null,
                                  ),
                                  const SizedBox(height: 20),
                                  CustomTextFormField(
                                    controller: locationController,
                                    labelText: 'Location',
                                    validator: (value) => value!.isEmpty
                                        ? 'Enter location'
                                        : null,
                                  ),
                                  const SizedBox(height: 20),
                                  CustomTextFormField(
                                    controller: phoneController,
                                    labelText: 'Phone',
                                    validator: (value) => value!.isEmpty
                                        ? 'Enter phone number'
                                        : null,
                                  ),
                                  const SizedBox(height: 30),
                                  CustomTextButton(
                                    onPressed: _saveVendorData,
                                    text: 'Save Changes',
                                    width: double.infinity,
                                  ),
                                  const SizedBox(height: 20),
                                  CustomTextButton(
                                    onPressed: () async {
                                      bool confirmDelete =
                                          await _showDeleteConfirmationDialog();
                                      if (confirmDelete) {
                                        await _deleteVendorData();
                                      }
                                    },
                                    text: 'Remove Vendor Account',
                                    width: double.infinity,
                                    variant: ButtonVariant.outlined,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
