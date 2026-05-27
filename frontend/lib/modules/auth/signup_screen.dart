import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // Form input controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Obscurity toggle states
  bool _obscurePassword = true;
  String _selectedCountryCode = '+1';
  bool _isLoading = false;

  @override
  void dispose() {
    // Memory safety: clean controllers immediately to purge plain-text entries
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Input validations & sanitization
  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your full name';
    }
    if (value.trim().length < 2) {
      return 'Name must be at least 2 characters';
    }
    // Simple sanitization check
    final RegExp nameRegExp = RegExp(r"^[a-zA-Z\s\-']+$");
    if (!nameRegExp.hasMatch(value.trim())) {
      return 'Name contains invalid characters';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your email address';
    }
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your phone number';
    }
    final phoneRegex = RegExp(r'^\d{7,15}$');
    if (!phoneRegex.hasMatch(value.trim())) {
      return 'Please enter a valid phone number (7-15 digits)';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a secure password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    // Check for complexity
    if (!value.contains(RegExp(r'[A-Za-z]')) || !value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain both letters and numbers';
    }
    return null;
  }

  Future<void> _handleSignup() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulate API signup authentication call
    await Future.delayed(const Duration(milliseconds: 1500));

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
      
      // Success feedback
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Account created successfully for ${_nameController.text.trim()}!',
            style: GoogleFonts.inter(color: Colors.white),
          ),
          backgroundColor: AppColors.primary,
          duration: const Duration(seconds: 3),
        ),
      );

      // Navigate to Login Screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 600;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop ? 24.0 : 16.0,
                vertical: 24.0,
              ),
              child: Container(
                width: double.infinity,
                constraints: const BoxConstraints(maxWidth: 500),
                decoration: BoxDecoration(
                  color: AppColors.mintGreenContainer, // CSS bg-[#f0fdf4] mapping
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.outlineVariant, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: isDesktop ? 36.0 : 20.0,
                  vertical: 36.0,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Form Title
                      Text(
                        'Join our Community',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.onSurface,
                            ),
                      ),
                      const SizedBox(height: 12),
                      // Subtitle
                      Text(
                        'Start your journey to holistic wellness today with curated herbal remedies and expert care.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.onSurfaceVariant,
                            ),
                      ),
                      const SizedBox(height: 28),

                      // Progress Indicator (CSS step-indicator mapping)
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 6,
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Container(
                              height: 6,
                              decoration: BoxDecoration(
                                color: AppColors.surfaceContainerHighest,
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Container(
                              height: 6,
                              decoration: BoxDecoration(
                                color: AppColors.surfaceContainerHighest,
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 28),

                      // FULL NAME INPUT
                      _buildLabel('Full Name'),
                      TextFormField(
                        controller: _nameController,
                        keyboardType: TextInputType.name,
                        validator: _validateName,
                        autofillHints: const [AutofillHints.name],
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          hintText: 'sajid Ahmad',
                          prefixIcon: Icon(
                            Icons.person_outline_rounded,
                            color: AppColors.outline,
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),

                      // EMAIL ADDRESS INPUT
                      _buildLabel('Email Address'),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: _validateEmail,
                        autofillHints: const [AutofillHints.email],
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          hintText: 'sajid@example.com',
                          prefixIcon: Icon(
                            Icons.mail_outline_rounded,
                            color: AppColors.outline,
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),

                      // PHONE NUMBER INPUT
                      _buildLabel('Phone Number'),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Country Code Select Box
                          Container(
                            width: 90,
                            height: 48,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceContainerLowest,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: AppColors.outlineVariant,
                              ),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: _selectedCountryCode,
                                icon: const Icon(
                                  Icons.expand_more_rounded,
                                  color: AppColors.outline,
                                ),
                                elevation: 2,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: AppColors.onSurface,
                                      fontWeight: FontWeight.w500,
                                    ),
                                onChanged: (String? newValue) {
                                  if (newValue != null) {
                                    setState(() {
                                      _selectedCountryCode = newValue;
                                    });
                                  }
                                },
                                items: <String>['+1', '+44', '+91']
                                    .map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          // Phone input field
                          Expanded(
                            child: TextFormField(
                              controller: _phoneController,
                              keyboardType: TextInputType.phone,
                              validator: _validatePhone,
                              autofillHints: const [AutofillHints.telephoneNumber],
                              textInputAction: TextInputAction.next,
                              decoration: const InputDecoration(
                                hintText: '7562828719',
                                prefixIcon: null,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),

                      // SECURE PASSWORD INPUT
                      _buildLabel('Secure Password'),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        validator: _validatePassword,
                        autofillHints: const [AutofillHints.newPassword],
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) => _handleSignup,
                        decoration: InputDecoration(
                          hintText: '••••••••',
                          prefixIcon: const Icon(
                            Icons.lock_outline_rounded,
                            color: AppColors.outline,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: AppColors.outline,
                              size: 20,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 28),

                      // CREATE ACCOUNT CTA BUTTON
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            shadowColor: AppColors.primary.withOpacity(0.4),
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: _isLoading ? null : _handleSignup,
                          child: _isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    valueColor:
                                        AlwaysStoppedAnimation<Color>(Colors.white),
                                  ),
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Create Account',
                                      style: GoogleFonts.inter(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.2,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    const Icon(
                                      Icons.arrow_forward_rounded,
                                      size: 16,
                                    ),
                                  ],
                                ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // TOGGLE FOOTER
                      Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ),
                                );
                              },
                              child: RichText(
                                text: TextSpan(
                                  text: 'Already have an account? ',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    color: AppColors.onSurfaceVariant,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'Login',
                                      style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            const Divider(
                              color: AppColors.outlineVariant,
                              thickness: 1,
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _buildFooterLink('Privacy Policy'),
                                const SizedBox(width: 12),
                                Container(
                                  width: 4,
                                  height: 4,
                                  decoration: const BoxDecoration(
                                    color: AppColors.outlineVariant,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                _buildFooterLink('Terms of Service'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6, left: 2),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: AppColors.onSurface,
            ),
      ),
    );
  }

  Widget _buildFooterLink(String text) {
    return GestureDetector(
      onTap: () {},
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: AppColors.outline,
              fontWeight: FontWeight.w400,
            ),
      ),
    );
  }
}
