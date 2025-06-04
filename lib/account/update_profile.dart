import 'package:flutter/material.dart';

class UpdateScreen extends StatefulWidget {
  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  
  bool _isUpdating = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack,
    ));
    
    _animationController.forward();
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
          'Update',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Custom Illustration
                      Container(
                        height: 300,
                        child: Stack(
                          children: [
                            // Background geometric shapes
                            Positioned(
                              left: 20,
                              top: 40,
                              child: _buildGeometricShape(
                                color: Color(0xFF3F51B5).withOpacity(0.8),
                                size: 30,
                              ),
                            ),
                            Positioned(
                              left: 40,
                              top: 80,
                              child: _buildGeometricShape(
                                color: Color(0xFF5C6BC0).withOpacity(0.6),
                                size: 20,
                              ),
                            ),
                            Positioned(
                              left: 60,
                              top: 50,
                              child: _buildGeometricShape(
                                color: Color(0xFF7986CB).withOpacity(0.7),
                                size: 25,
                              ),
                            ),
                            
                            // Main illustration - People and screen
                            Center(
                              child: Container(
                                width: 250,
                                height: 200,
                                child: Stack(
                                  children: [
                                    // Mobile screen/tablet in center
                                    Positioned(
                                      right: 60,
                                      top: 20,
                                      child: Container(
                                        width: 100,
                                        height: 140,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(12),
                                          border: Border.all(
                                            color: Color(0xFF3F51B5),
                                            width: 3,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0xFF3F51B5).withOpacity(0.2),
                                              blurRadius: 10,
                                              offset: Offset(0, 5),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            // Screen content
                                            Container(
                                              width: 60,
                                              height: 8,
                                              decoration: BoxDecoration(
                                                color: Color(0xFF3F51B5),
                                                borderRadius: BorderRadius.circular(4),
                                              ),
                                            ),
                                            SizedBox(height: 8),
                                            Container(
                                              width: 40,
                                              height: 6,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[300],
                                                borderRadius: BorderRadius.circular(3),
                                              ),
                                            ),
                                            SizedBox(height: 6),
                                            Container(
                                              width: 50,
                                              height: 6,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[300],
                                                borderRadius: BorderRadius.circular(3),
                                              ),
                                            ),
                                            SizedBox(height: 12),
                                            // Update button on screen
                                            Container(
                                              width: 35,
                                              height: 15,
                                              decoration: BoxDecoration(
                                                color: Color(0xFF4CAF50),
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              child: Icon(
                                                Icons.refresh,
                                                color: Colors.white,
                                                size: 10,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    
                                    // Left person (male with briefcase)
                                    Positioned(
                                      left: 0,
                                      bottom: 0,
                                      child: Container(
                                        width: 60,
                                        child: Column(
                                          children: [
                                            // Head
                                            Container(
                                              width: 25,
                                              height: 25,
                                              decoration: BoxDecoration(
                                                color: Color(0xFFFFDBB5),
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            // Body
                                            Container(
                                              width: 35,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                color: Color(0xFF3F51B5),
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                            ),
                                            // Legs
                                            Container(
                                              width: 30,
                                              height: 25,
                                              decoration: BoxDecoration(
                                                color: Color(0xFF2C387E),
                                                borderRadius: BorderRadius.circular(6),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    
                                    // Right person (female)
                                    Positioned(
                                      right: 0,
                                      bottom: 0,
                                      child: Container(
                                        width: 50,
                                        child: Column(
                                          children: [
                                            // Head
                                            Container(
                                              width: 22,
                                              height: 22,
                                              decoration: BoxDecoration(
                                                color: Color(0xFFFFDBB5),
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            // Body
                                            Container(
                                              width: 30,
                                              height: 45,
                                              decoration: BoxDecoration(
                                                color: Color(0xFF3F51B5),
                                                borderRadius: BorderRadius.circular(6),
                                              ),
                                            ),
                                            // Skirt/legs
                                            Container(
                                              width: 35,
                                              height: 20,
                                              decoration: BoxDecoration(
                                                color: Color(0xFF2C387E),
                                                borderRadius: BorderRadius.circular(6),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            
                            // Decorative elements
                            Positioned(
                              right: 30,
                              bottom: 80,
                              child: _buildGeometricShape(
                                color: Color(0xFF9C27B0).withOpacity(0.6),
                                size: 15,
                              ),
                            ),
                            Positioned(
                              right: 10,
                              bottom: 100,
                              child: _buildGeometricShape(
                                color: Color(0xFFE91E63).withOpacity(0.5),
                                size: 12,
                              ),
                            ),
                            
                            // Plants/decorative elements
                            Positioned(
                              left: 10,
                              bottom: 20,
                              child: Container(
                                width: 40,
                                height: 30,
                                child: CustomPaint(
                                  painter: PlantPainter(),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 20,
                              bottom: 10,
                              child: Container(
                                width: 35,
                                height: 25,
                                child: CustomPaint(
                                  painter: PlantPainter(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      SizedBox(height: 40),
                      
                      // Title
                      Text(
                        'Time to Update',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      
                      SizedBox(height: 20),
                      
                      // Description
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'We added lot of new features and fix some bug to make your experience as smooth as possible',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Buttons
                Column(
                  children: [
                    // Update App Button
                    Container(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _isUpdating ? null : _handleUpdate,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 0,
                        ),
                        child: _isUpdating
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Text(
                                    'Updating...',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              )
                            : Text(
                                'Update App',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    ),
                    
                    SizedBox(height: 16),
                    
                    // Not Now Button
                    TextButton(
                      onPressed: _isUpdating ? null : () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Not Now',
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGeometricShape({required Color color, required double size}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }

  void _handleUpdate() async {
    setState(() {
      _isUpdating = true;
    });
    
    // Simulate update process
    await Future.delayed(Duration(seconds: 3));
    
    setState(() {
      _isUpdating = false;
    });
    
    // Show success dialog
    _showUpdateSuccessDialog();
  }

  void _showUpdateSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 28),
              SizedBox(width: 8),
              Text('Update Complete!'),
            ],
          ),
          content: Text(
            'Your app has been successfully updated with the latest features and improvements.',
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                Navigator.of(context).pop(); // Go back to profile
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text('Great!', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

// Custom painter for plant decorations
class PlantPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xFF4CAF50)
      ..style = PaintingStyle.fill;
    
    // Draw simple plant stems
    final path = Path();
    path.moveTo(size.width * 0.5, size.height);
    path.lineTo(size.width * 0.3, size.height * 0.7);
    path.lineTo(size.width * 0.1, size.height * 0.5);
    
    path.moveTo(size.width * 0.5, size.height);
    path.lineTo(size.width * 0.7, size.height * 0.6);
    path.lineTo(size.width * 0.9, size.height * 0.4);
    
    paint.strokeWidth = 3;
    paint.style = PaintingStyle.stroke;
    canvas.drawPath(path, paint);
    
    // Draw leaves
    paint.style = PaintingStyle.fill;
    canvas.drawCircle(Offset(size.width * 0.1, size.height * 0.5), 6, paint);
    canvas.drawCircle(Offset(size.width * 0.9, size.height * 0.4), 5, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}