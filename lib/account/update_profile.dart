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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        backgroundColor: colorScheme.background,
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
            color: colorScheme.onBackground,
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
                      Container(
                        height: 300,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 20,
                              top: 40,
                              child: _buildGeometricShape(
                                color: Colors.blue[400]!.withOpacity(0.8),
                                size: 30,
                              ),
                            ),
                            Positioned(
                              left: 40,
                              top: 80,
                              child: _buildGeometricShape(
                                color: Colors.blue[300]!.withOpacity(0.6),
                                size: 20,
                              ),
                            ),
                            Positioned(
                              left: 60,
                              top: 50,
                              child: _buildGeometricShape(
                                color: Colors.blue[200]!.withOpacity(0.7),
                                size: 25,
                              ),
                            ),
                            Center(
                              child: Container(
                                width: 250,
                                height: 200,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      right: 60,
                                      top: 20,
                                      child: Container(
                                        width: 100,
                                        height: 140,
                                        decoration: BoxDecoration(
                                          color: colorScheme.surface,
                                          borderRadius: BorderRadius.circular(12),
                                          border: Border.all(
                                            color: Colors.blue[400]!,
                                            width: 3,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.blue[400]!.withOpacity(0.2),
                                              blurRadius: 10,
                                              offset: Offset(0, 5),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 60,
                                              height: 8,
                                              decoration: BoxDecoration(
                                                color: Colors.blue[400],
                                                borderRadius: BorderRadius.circular(4),
                                              ),
                                            ),
                                            SizedBox(height: 8),
                                            Container(
                                              width: 40,
                                              height: 6,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[600],
                                                borderRadius: BorderRadius.circular(3),
                                              ),
                                            ),
                                            SizedBox(height: 6),
                                            Container(
                                              width: 50,
                                              height: 6,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[600],
                                                borderRadius: BorderRadius.circular(3),
                                              ),
                                            ),
                                            SizedBox(height: 12),
                                            Container(
                                              width: 35,
                                              height: 15,
                                              decoration: BoxDecoration(
                                                color: Colors.green[600],
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
                                    Positioned(
                                      left: 0,
                                      bottom: 0,
                                      child: _buildPersonShape(isFemale: false),
                                    ),
                                    Positioned(
                                      right: 0,
                                      bottom: 0,
                                      child: _buildPersonShape(isFemale: true),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              right: 30,
                              bottom: 80,
                              child: _buildGeometricShape(
                                color: Colors.purple[300]!.withOpacity(0.6),
                                size: 15,
                              ),
                            ),
                            Positioned(
                              right: 10,
                              bottom: 100,
                              child: _buildGeometricShape(
                                color: Colors.pink[300]!.withOpacity(0.5),
                                size: 12,
                              ),
                            ),
                            Positioned(
                              left: 10,
                              bottom: 20,
                              child: Container(
                                width: 40,
                                height: 30,
                                child: CustomPaint(painter: PlantPainter()),
                              ),
                            ),
                            Positioned(
                              right: 20,
                              bottom: 10,
                              child: Container(
                                width: 35,
                                height: 25,
                                child: CustomPaint(painter: PlantPainter()),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 40),
                      Text(
                        'Time to Update',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onBackground,
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'We added lot of new features and fix some bug to make your experience as smooth as possible',
                          style: TextStyle(
                            fontSize: 16,
                            color: colorScheme.onBackground.withOpacity(0.7),
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _isUpdating ? null : _handleUpdate,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
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
                                      color: colorScheme.onPrimary,
                                      strokeWidth: 2,
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Text(
                                    'Updating...',
                                    style: TextStyle(
                                      color: colorScheme.onPrimary,
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
                    TextButton(
                      onPressed: _isUpdating ? null : () => Navigator.pop(context),
                      child: Text(
                        'Not Now',
                        style: TextStyle(
                          color: colorScheme.onBackground.withOpacity(0.6),
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

  Widget _buildPersonShape({required bool isFemale}) {
    return Container(
      width: isFemale ? 50 : 60,
      child: Column(
        children: [
          Container(
            width: isFemale ? 22 : 25,
            height: isFemale ? 22 : 25,
            decoration: BoxDecoration(
              color: Color(0xFFFFDBB5),
              shape: BoxShape.circle,
            ),
          ),
          Container(
            width: isFemale ? 30 : 35,
            height: isFemale ? 45 : 50,
            decoration: BoxDecoration(
              color: Colors.blue[400],
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          Container(
            width: isFemale ? 35 : 30,
            height: isFemale ? 20 : 25,
            decoration: BoxDecoration(
              color: Colors.blue[600],
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ],
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

    await Future.delayed(Duration(seconds: 3));

    setState(() {
      _isUpdating = false;
    });

    _showUpdateSuccessDialog();
  }

  void _showUpdateSuccessDialog() {
    final colorScheme = Theme.of(context).colorScheme;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: colorScheme.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 28),
              SizedBox(width: 8),
              Text('Update Complete!', style: TextStyle(color: colorScheme.onSurface)),
            ],
          ),
          content: Text(
            'Your app has been successfully updated with the latest features and improvements.',
            style: TextStyle(color: colorScheme.onSurface.withOpacity(0.9)),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text('Great!', style: TextStyle(color: colorScheme.onPrimary)),
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

class PlantPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green[600]!
      ..style = PaintingStyle.fill;

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

    paint.style = PaintingStyle.fill;
    canvas.drawCircle(Offset(size.width * 0.1, size.height * 0.5), 6, paint);
    canvas.drawCircle(Offset(size.width * 0.9, size.height * 0.4), 5, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
