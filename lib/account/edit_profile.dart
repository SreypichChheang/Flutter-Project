import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';

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

  String? _selectedImageUrl;
  File? _selectedImageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: widget.initialName ?? "Anna Jennifer");
    _emailController = TextEditingController(text: widget.initialEmail ?? "annajennifer@gmail.com");
    _selectedImageUrl = widget.initialImage;
  }

  ImageProvider _getImageProvider() {
    // If we have a selected file, use it
    if (_selectedImageFile != null) {
      return FileImage(_selectedImageFile!);
    }
    
    // If we have a URL (including base64), use it
    if (_selectedImageUrl != null && _selectedImageUrl!.isNotEmpty) {
      if (_selectedImageUrl!.startsWith('data:')) {
        try {
          final base64Data = _selectedImageUrl!.split(',')[1];
          final bytes = base64Decode(base64Data);
          return MemoryImage(bytes);
        } catch (e) {
          print('Error loading base64 image: $e');
        }
      } else {
        return NetworkImage(_selectedImageUrl!);
      }
    }
    return const NetworkImage('https://picsum.photos/200/200?random=1');
  }

  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Image Source'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImageFromGallery();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImageFromCamera();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 80,
      );
      
      if (image != null) {
        final File imageFile = File(image.path);
        final Uint8List imageBytes = await imageFile.readAsBytes();
        final String base64String = base64Encode(imageBytes);
        
        setState(() {
          _selectedImageFile = imageFile;
          _selectedImageUrl = 'data:image/jpeg;base64,$base64String';
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
  }

  Future<void> _pickImageFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 80,
      );
      
      if (image != null) {
        final File imageFile = File(image.path);
        final Uint8List imageBytes = await imageFile.readAsBytes();
        final String base64String = base64Encode(imageBytes);
        
        setState(() {
          _selectedImageFile = imageFile;
          _selectedImageUrl = 'data:image/jpeg;base64,$base64String';
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error taking photo: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        backgroundColor: colorScheme.background,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: colorScheme.primary,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: colorScheme.onPrimary),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: Text(
          'Edit Profile',
          style: TextStyle(
            color: colorScheme.onBackground,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Image
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
                      onTap: _showImageSourceDialog,
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: colorScheme.surface,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.add,
                          color: colorScheme.onSurface,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            _buildTextField(context, "Username", _usernameController),
            const SizedBox(height: 24),
            _buildTextField(context, "Email", _emailController),
            const SizedBox(height: 24),
            _buildTextField(context, "Gender", _genderController),
            const SizedBox(height: 24),
            _buildTextField(context, "Nationality", _nationalityController),
            const SizedBox(height: 24),
            _buildTextField(context, "Phone Number", _phoneController),
            const SizedBox(height: 60),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, {
                    'name': _usernameController.text,
                    'email': _emailController.text,
                    'gender': _genderController.text,
                    'nationality': _nationalityController.text,
                    'phone': _phoneController.text,
                    'image': _selectedImageUrl,
                    'imageFile': _selectedImageFile,
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Save',
                  style: TextStyle(
                    color: colorScheme.onPrimary,
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

  Widget _buildTextField(BuildContext context, String label, TextEditingController controller) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: colorScheme.onBackground,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: colorScheme.surfaceVariant,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: controller,
            style: TextStyle(
              color: colorScheme.onSurface,
              fontSize: 15,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              hintStyle: TextStyle(
                color: colorScheme.onSurface.withOpacity(0.4),
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