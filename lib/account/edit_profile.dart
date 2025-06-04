import 'package:flutter/material.dart';
import 'dart:html' as html; // For web file picker
import 'dart:convert'; // For base64 decoding
import 'dart:typed_data'; // For Uint8List

class EditProfileScreen extends StatefulWidget {
  final String? initialName;
  final String? initialEmail;
  final String? initialImage;

  const EditProfileScreen({
    Key? key,
    this.initialName,
    this.initialEmail,
    this.initialImage,
  }) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  final TextEditingController _genderController = TextEditingController(text: "Female");
  final TextEditingController _nationalityController = TextEditingController(text: "USA");
  final TextEditingController _phoneController = TextEditingController(text: "+44 1653 3343556");
  
  String? _selectedImageUrl; // To store the new selected image

  @override
  void initState() {
    super.initState();
    // Initialize controllers with passed data or defaults
    _usernameController = TextEditingController(
      text: widget.initialName ?? "Anna Jennifer"
    );
    _emailController = TextEditingController(
      text: widget.initialEmail ?? "annajennifer@gmail.com"
    );
    _selectedImageUrl = widget.initialImage; // Initialize with current image
  }

  // Helper method to get ImageProvider safely
  ImageProvider _getImageProvider() {
    if (_selectedImageUrl != null && _selectedImageUrl!.isNotEmpty) {
      if (_selectedImageUrl!.startsWith('data:')) {
        try {
          // Extract base64 data from data URL
          final base64Data = _selectedImageUrl!.split(',')[1];
          final bytes = base64Decode(base64Data);
          return MemoryImage(bytes);
        } catch (e) {
          print('Error loading base64 image: $e');
          return NetworkImage('https://picsum.photos/200/200?random=1');
        }
      } else {
        return NetworkImage(_selectedImageUrl!);
      }
    }
    return NetworkImage('https://picsum.photos/200/200?random=1');
  }

  void _pickImage() async {
    // Create file input element
    final html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.accept = 'image/*'; // Only accept image files
    uploadInput.click();

    uploadInput.onChange.listen((event) {
      final files = uploadInput.files;
      if (files!.isNotEmpty) {
        final file = files[0];
        final reader = html.FileReader();
        
        reader.onLoadEnd.listen((event) {
          setState(() {
            _selectedImageUrl = reader.result as String; // Base64 data URL
          });
        });
        
        reader.readAsDataUrl(file);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Container(
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Image Section
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: _getImageProvider(),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: _pickImage, // Add tap functionality
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.add,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 40),
            
            // Form Fields
            _buildTextField("Username", _usernameController),
            SizedBox(height: 24),
            
            _buildTextField("Email", _emailController),
            SizedBox(height: 24),
            
            _buildTextField("Gender", _genderController),
            SizedBox(height: 24),
            
            _buildTextField("Nationality", _nationalityController),
            SizedBox(height: 24),
            
            _buildTextField("Phone Number", _phoneController),
            SizedBox(height: 60),
            
            // Save Button
            Container(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  // Save the changes and return comprehensive data including image
                  Navigator.pop(context, {
                    'name': _usernameController.text,
                    'email': _emailController.text,
                    'gender': _genderController.text,
                    'nationality': _nationalityController.text,
                    'phone': _phoneController.text,
                    'image': _selectedImageUrl, // Return the new image
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Save',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: controller,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 15,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              hintStyle: TextStyle(
                color: Colors.grey[400],
                fontSize: 15,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _genderController.dispose();
    _nationalityController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}