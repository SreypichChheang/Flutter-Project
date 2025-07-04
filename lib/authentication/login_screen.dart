import 'package:app/authentication/forget_password.dart';
import 'package:app/dashboard/home_page.dart';
import 'package:app/authentication/auth_service.dart'; // ✅ Add this import
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> _launchUrlSafe(String url) async {
  final Uri uri = Uri.parse(url);
  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    throw 'Could not launch $url';
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();

    _emailFocusNode.addListener(() => setState(() {}));
    _passwordFocusNode.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    setState(() => _isLoading = true);
    try {
      final user = await _authService.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const Controller()),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(-0.8, -1),
            end: Alignment(0.8, 1),
            colors: [Color(0xFFE5E5E5), Color(0xFFB0B0B0), Color(0xFF3A3A3A), Colors.black],
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: Image.asset('assets/images/light-bulb.png'),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'SMART EY SMART\nYANG NIS',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),

                  _buildTextField('Email', _emailController, _emailFocusNode, false),
                  const SizedBox(height: 15),
                  _buildTextField('Password', _passwordController, _passwordFocusNode, true),
                  const SizedBox(height: 25),

                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        elevation: 4,
                      ),
                      child: _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text('Log In'),
                    ),
                  ),
                  const SizedBox(height: 15),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => ForgetPasswordPage()));
                      },
                      child: const Text(
                        'Forget Password?',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),
                  Row(
                    children: const [
                      Expanded(child: Divider(color: Colors.black26)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text('or Continue with:', style: TextStyle(color: Colors.black54)),
                      ),
                      Expanded(child: Divider(color: Colors.black26)),
                    ],
                  ),
                  const SizedBox(height: 15),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _SocialIconButton(
                        asset: 'assets/images/google.png',
                        onTap: () => _launchUrlSafe('https://accounts.google.com/signin'),
                      ),
                      _SocialIconButton(
                        asset: 'assets/images/facebook.png',
                        onTap: () => _launchUrlSafe('https://www.facebook.com/login.php'),
                      ),
                      _SocialIconButton(
                        asset: 'assets/images/tiktok.png',
                        onTap: () => _launchUrlSafe('https://www.tiktok.com/login'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, TextEditingController controller, FocusNode focusNode, bool obscure) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: focusNode.hasFocus ? Colors.black : Colors.grey,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        focusNode: focusNode,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }
}

class _SocialIconButton extends StatefulWidget {
  final String asset;
  final VoidCallback onTap;

  const _SocialIconButton({required this.asset, required this.onTap});

  @override
  State<_SocialIconButton> createState() => _SocialIconButtonState();
}

class _SocialIconButtonState extends State<_SocialIconButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: _isHovered ? Colors.black : Colors.grey.shade400),
          ),
          child: Image.asset(widget.asset, width: 32, height: 32),
        ),
      ),
    );
  }
}
