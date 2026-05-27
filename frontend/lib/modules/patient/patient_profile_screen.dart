import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';

class PatientProfileScreen extends StatefulWidget {
  final VoidCallback? onMedsOrdered;

  const PatientProfileScreen({
    super.key,
    this.onMedsOrdered,
  });

  @override
  State<PatientProfileScreen> createState() => _PatientProfileScreenState();
}

class _PatientProfileScreenState extends State<PatientProfileScreen> {
  // Personal Details States
  String _patientName = "Sajid Ahmad";
  String _patientId = "#HC-98231";
  String _patientAge = "23 Years";
  String _patientGender = "Male";
  String _patientBloodGroup = "B+ Positive";
  String _patientHeight = "178 cm";
  String _patientEmail = "sajidahmadgpt@gmail.com";
  String _patientPhone = "+91 98765 43210";
  String _patientLocation = "South Extension, New Delhi";

  // Medical History States
  final List<String> _chronicConditions = ["headache", "Hypertension"];
  final List<String> _allergies = ["Dust Mites", "heatwave", "Latex"];

  // Prescriptions States
  final List<Map<String, dynamic>> _prescriptions = [
    {
      'id': 1,
      'name': 'Ayurvedic Immunity Booster',
      'practitioner': 'Dr. Vaidya Ramanathan',
      'date': '12 Oct 2023',
      'type': 'ayurvedic',
      'icon': Icons.spa_outlined,
    },
    {
      'id': 2,
      'name': 'Unani Respiratory Syrup',
      'practitioner': 'Dr. Hakim Zafar',
      'date': '28 Sep 2023',
      'type': 'unani',
      'icon': Icons.opacity_outlined,
    }
  ];

  // Medical Reports States
  final List<Map<String, dynamic>> _reports = [
    {
      'id': 1,
      'name': 'Full Body Blood Test.pdf',
      'date': '15 Oct 2023',
      'size': '2.4 MB',
      'type': 'pdf',
    },
    {
      'id': 2,
      'name': 'Chest X-Ray Digital.jpg',
      'date': '10 Sep 2023',
      'size': '1.1 MB',
      'type': 'image',
    }
  ];

  // Hover tracker for prescription items
  int _hoveredPrescriptionId = 0;

  // Controllers for Dialogs (ensuring proper lifecycle cleanups)
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _locationController;
  late TextEditingController _ageController;
  late TextEditingController _genderController;
  late TextEditingController _heightController;
  late TextEditingController _bloodGroupController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: _patientName);
    _emailController = TextEditingController(text: _patientEmail);
    _phoneController = TextEditingController(text: _patientPhone);
    _locationController = TextEditingController(text: _patientLocation);
    _ageController = TextEditingController(text: _patientAge);
    _genderController = TextEditingController(text: _patientGender);
    _heightController = TextEditingController(text: _patientHeight);
    _bloodGroupController = TextEditingController(text: _patientBloodGroup);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _locationController.dispose();
    _ageController.dispose();
    _genderController.dispose();
    _heightController.dispose();
    _bloodGroupController.dispose();
    super.dispose();
  }

  // --- ACTIONS & DIALOGS ---

  // Secure Profile Editor
  void _openEditProfileDialog() {
    // Sync current values to controllers
    _nameController.text = _patientName;
    _emailController.text = _patientEmail;
    _phoneController.text = _patientPhone;
    _locationController.text = _patientLocation;
    _ageController.text = _patientAge;
    _genderController.text = _patientGender;
    _heightController.text = _patientHeight;
    _bloodGroupController.text = _patientBloodGroup;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.surfaceContainerLowest,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(
            'Edit Personal Details',
            style: GoogleFonts.manrope(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          content: SingleChildScrollView(
            child: SizedBox(
              width: 400,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildDialogTextField('Full Name', _nameController, Icons.person_outline),
                  const SizedBox(height: 12),
                  _buildDialogTextField('Email Address', _emailController, Icons.mail_outline),
                  const SizedBox(height: 12),
                  _buildDialogTextField('Phone Number', _phoneController, Icons.call_outlined),
                  const SizedBox(height: 12),
                  _buildDialogTextField('Location/Address', _locationController, Icons.location_on_outlined),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildDialogTextField('Age', _ageController, Icons.calendar_month_outlined),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildDialogTextField('Gender', _genderController, Icons.wc_outlined),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildDialogTextField('Height', _heightController, Icons.straighten_outlined),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildDialogTextField('Blood Group', _bloodGroupController, Icons.water_drop_outlined),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: GoogleFonts.inter(
                  color: AppColors.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                setState(() {
                  _patientName = _nameController.text.trim();
                  _patientEmail = _emailController.text.trim();
                  _patientPhone = _phoneController.text.trim();
                  _patientLocation = _locationController.text.trim();
                  _patientAge = _ageController.text.trim();
                  _patientGender = _genderController.text.trim();
                  _patientHeight = _heightController.text.trim();
                  _patientBloodGroup = _bloodGroupController.text.trim();
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Profile details saved successfully!',
                      style: GoogleFonts.inter(),
                    ),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: AppColors.primary,
                  ),
                );
              },
              child: Text(
                'Save Changes',
                style: GoogleFonts.inter(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDialogTextField(String label, TextEditingController controller, IconData icon) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, size: 20, color: AppColors.primary),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      ),
    );
  }

  // Adding conditions/allergies dialog
  void _openAddItemDialog(bool isCondition) {
    final TextEditingController itemInputController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.surfaceContainerLowest,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(
            isCondition ? 'Add Chronic Condition' : 'Add Allergy Warning',
            style: GoogleFonts.manrope(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          content: TextField(
            controller: itemInputController,
            autofocus: true,
            decoration: InputDecoration(
              hintText: isCondition ? 'e.g. Diabetes, Asthma' : 'e.g. Peanuts, Penicillin',
              prefixIcon: Icon(
                isCondition ? Icons.history_rounded : Icons.medical_information_rounded,
                color: AppColors.primary,
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                itemInputController.dispose();
                Navigator.pop(context);
              },
              child: Text('Cancel', style: GoogleFonts.inter(color: AppColors.onSurfaceVariant)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                final text = itemInputController.text.trim();
                if (text.isNotEmpty) {
                  setState(() {
                    if (isCondition) {
                      _chronicConditions.add(text);
                    } else {
                      _allergies.add(text);
                    }
                  });
                }
                itemInputController.dispose();
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Added "$text" successfully!'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              child: Text('Add', style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  // Interactive checkout bottom sheet
  void _openOrderMedsSheet(Map<String, dynamic> prescription) {
    final TextEditingController addressController = TextEditingController(text: _patientLocation);
    String selectedPayment = "Cash on Delivery";
    double shippingFee = 49.00;
    double itemPrice = prescription['type'] == 'ayurvedic' ? 399.00 : 280.00;
    double grandTotal = itemPrice + shippingFee;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surfaceContainerLowest,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 24,
                bottom: MediaQuery.of(context).viewInsets.bottom + 24,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Handle Bar
                    Center(
                      child: Container(
                        width: 48,
                        height: 5,
                        decoration: BoxDecoration(
                          color: AppColors.outlineVariant,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Icon(Icons.shopping_bag_outlined, color: AppColors.primary, size: 28),
                        const SizedBox(width: 10),
                        Text(
                          'Prescription Order Checkout',
                          style: GoogleFonts.manrope(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.onSurface,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    // Item review card
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceContainerLow,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.outlineVariant.withOpacity(0.4)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: prescription['type'] == 'ayurvedic'
                                  ? AppColors.secondaryContainer.withOpacity(0.4)
                                  : AppColors.tertiaryContainer.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              prescription['icon'] as IconData,
                              color: prescription['type'] == 'ayurvedic'
                                  ? AppColors.onSecondaryContainer
                                  : AppColors.tertiaryContainer,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  prescription['name'] as String,
                                  style: GoogleFonts.inter(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.onSurface,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  prescription['practitioner'] as String,
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    color: AppColors.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            '₹${itemPrice.toStringAsFixed(0)}',
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    // Shipping details input
                    Text(
                      'Delivery Address',
                      style: GoogleFonts.manrope(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.onSurface,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: addressController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.local_shipping_outlined),
                        hintText: 'Enter complete shipping address',
                      ),
                    ),
                    const SizedBox(height: 18),
                    // Payment Option Selection
                    Text(
                      'Payment Method',
                      style: GoogleFonts.manrope(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.onSurface,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildPaymentChip('Cash on Delivery', selectedPayment, (val) {
                          setSheetState(() => selectedPayment = val);
                        }),
                        const SizedBox(width: 8),
                        _buildPaymentChip('UPI/Online', selectedPayment, (val) {
                          setSheetState(() => selectedPayment = val);
                        }),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // Bill Summary
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceContainerLowest,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.outlineVariant.withOpacity(0.4)),
                      ),
                      child: Column(
                        children: [
                          _buildBillRow('Item Cost', '₹${itemPrice.toStringAsFixed(2)}'),
                          const SizedBox(height: 8),
                          _buildBillRow('Delivery Fee', '₹${shippingFee.toStringAsFixed(2)}'),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: Divider(height: 1),
                          ),
                          _buildBillRow(
                            'Grand Total',
                            '₹${grandTotal.toStringAsFixed(2)}',
                            isTotal: true,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Confirm Order Button
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          elevation: 2,
                        ),
                        onPressed: () {
                          // Simulate secure payment spinner
                          Navigator.pop(context);
                          _showSuccessCheckoutOverlay(prescription['name'] as String);
                        },
                        child: Text(
                          'Place Order • ₹${grandTotal.toStringAsFixed(0)}',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildPaymentChip(String title, String activeVal, ValueChanged<String> onTap) {
    final isActive = activeVal == title;
    return ChoiceChip(
      label: Text(
        title,
        style: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          color: isActive ? Colors.white : AppColors.onSurfaceVariant,
        ),
      ),
      selected: isActive,
      selectedColor: AppColors.primary,
      backgroundColor: AppColors.surfaceContainerLow,
      onSelected: (selected) {
        if (selected) onTap(title);
      },
    );
  }

  Widget _buildBillRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: isTotal ? 15 : 13,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
            color: isTotal ? AppColors.onSurface : AppColors.onSurfaceVariant,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: isTotal ? 17 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
            color: isTotal ? AppColors.primary : AppColors.onSurface,
          ),
        ),
      ],
    );
  }

  // Beautiful checkmark checkout trigger
  void _showSuccessCheckoutOverlay(String medicineName) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        // Trigger simulated callback to update parent home cart
        Future.delayed(const Duration(milliseconds: 1400), () {
          Navigator.pop(context);
          if (widget.onMedsOrdered != null) {
            widget.onMedsOrdered!();
          }
        });

        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Container(
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(24),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 24,
                  offset: Offset(0, 8),
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  width: 56,
                  height: 56,
                  child: CircularProgressIndicator(
                    strokeWidth: 4.5,
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                  ),
                ),
                const SizedBox(height: 24),
                Icon(
                  Icons.check_circle_rounded,
                  color: Colors.green.shade600,
                  size: 64,
                ),
                const SizedBox(height: 16),
                Text(
                  'Order Confirmed!',
                  style: GoogleFonts.manrope(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Your prescription of "$medicineName" has been processed successfully.',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: AppColors.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Upload simulation flow
  void _openUploadReportSheet() {
    final List<String> mockOptions = [
      "Full Blood Panel (Labcorp)",
      "Thyroid profile (THS)",
      "Lungs Digital Scan",
      "Ayurvedic Consultation Summary"
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surfaceContainerLowest,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Simulate Uploading Medical Report',
                style: GoogleFonts.manrope(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Select a medical document template to simulate a secure upload:',
                style: GoogleFonts.inter(fontSize: 13, color: AppColors.onSurfaceVariant),
              ),
              const SizedBox(height: 16),
              Column(
                children: mockOptions.map((opt) {
                  return ListTile(
                    leading: const Icon(Icons.picture_as_pdf_outlined, color: AppColors.primary),
                    title: Text(opt, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600)),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 12),
                    onTap: () {
                      Navigator.pop(context);
                      _executeReportUpload(opt);
                    },
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }

  void _executeReportUpload(String templateName) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        // Mock loading upload
        Future.delayed(const Duration(milliseconds: 1200), () {
          Navigator.pop(context);
          setState(() {
            final double sizeMB = 1.0 + (5.0 - 1.0) * (3.14159 % 0.8);
            _reports.add({
              'id': _reports.length + 1,
              'name': '${templateName.replaceAll(' ', '_')}.pdf',
              'date': '27 May 2026',
              'size': '${sizeMB.toStringAsFixed(1)} MB',
              'type': 'pdf',
            });
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Report "$templateName" uploaded securely!'),
              behavior: SnackBarBehavior.floating,
              backgroundColor: AppColors.primary,
            ),
          );
        });

        return Dialog(
          backgroundColor: AppColors.surfaceContainerLowest,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              children: [
                const CircularProgressIndicator(color: AppColors.primary),
                const SizedBox(width: 20),
                Text(
                  'Encrypting & Uploading...',
                  style: GoogleFonts.inter(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // View PDF dialog simulation
  void _openReportPreview(Map<String, dynamic> report) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          insetPadding: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      report['name'] as String,
                      style: GoogleFonts.manrope(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Size: ${report['size']} • Verified Secure Encryption',
                      style: GoogleFonts.inter(fontSize: 11, color: AppColors.outline),
                    ),
                    const SizedBox(height: 20),
                    // PDF simulated content
                    Container(
                      height: 320,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.surfaceContainerLow,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.outlineVariant),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            report['type'] == 'pdf' ? Icons.picture_as_pdf_rounded : Icons.image_rounded,
                            size: 80,
                            color: AppColors.primary.withOpacity(0.3),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            '[ Simulated Decrypted View ]',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(
                              'Patient: Sajid Ahmad (ID: #HC-98231)\nVerified Health Signature matching clinic standards.',
                              style: GoogleFonts.inter(fontSize: 12, color: AppColors.onSurfaceVariant),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Close', style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                          ),
                          icon: const Icon(Icons.download_rounded, size: 16),
                          label: const Text('Download Original'),
                          onPressed: () {
                            Navigator.pop(context);
                            _simulateDownload(report['name'] as String);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _simulateDownload(String name) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Downloading "$name" securely...'),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 1),
      ),
    );

    Future.delayed(const Duration(milliseconds: 1200), () {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.white, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text('"$name" downloaded successfully into Downloads!'),
              ),
            ],
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.green.shade600,
        ),
      );
    });
  }

  // --- BUILD METHOD ---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primaryContainer, AppColors.primary],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
              onPressed: () {
                // Since this is embedded in dashboard, we can prompt return to main home tab (0)
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Redirecting to Wellness dashboard home tab...'),
                    duration: Duration(milliseconds: 800),
                  ),
                );
              },
            ),
            title: Text(
              'Patient Profile',
              style: GoogleFonts.manrope(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.share_rounded, color: Colors.white, size: 20),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Profile link copied securely to clipboard!')),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.settings_outlined, color: Colors.white, size: 20),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Opening secure profile configurations...')),
                  );
                },
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth > 900;
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(18),
            child: Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: isDesktop ? _buildDesktopLayout() : _buildMobileLayout(),
              ),
            ),
          );
        },
      ),
      floatingActionButton: _buildEditFAB(),
    );
  }

  // --- LAYOUTS ---

  // Wide screen layout (Double Columns split as flex 4 : 8)
  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left Column: Identity & Personal Details
        Expanded(
          flex: 4,
          child: Column(
            children: [
              _buildIdentityCard(),
              const SizedBox(height: 18),
              _buildPersonalDetailsCard(),
            ],
          ),
        ),
        const SizedBox(width: 18),
        // Right Column: Medical Data
        Expanded(
          flex: 8,
          child: Column(
            children: [
              _buildBentoMedicalHistoryRow(),
              const SizedBox(height: 18),
              _buildPrescriptionsCard(),
              const SizedBox(height: 18),
              _buildReportsCard(),
            ],
          ),
        ),
      ],
    );
  }

  // Stacked mobile layout (Vertical cards list)
  Widget _buildMobileLayout() {
    return Column(
      children: [
        _buildIdentityCard(),
        const SizedBox(height: 16),
        _buildPersonalDetailsCard(),
        const SizedBox(height: 16),
        _buildBentoMedicalHistoryRow(),
        const SizedBox(height: 16),
        _buildPrescriptionsCard(),
        const SizedBox(height: 16),
        _buildReportsCard(),
      ],
    );
  }

  // --- SUBWIDGETS & CARDS ---

  // Identity Card: Profile picture, member tags
  Widget _buildIdentityCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.outlineVariant.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Profile Avatar Frame with Edit hover circle
          Stack(
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.secondaryContainer.withOpacity(0.5), width: 4),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4)),
                  ],
                ),
                child: ClipOval(
                  child: Image.network(
                    'https://media.licdn.com/dms/image/v2/D5603AQF1KscyhgoRhw/profile-displayphoto-shrink_800_800/B56ZTxOOd.GoAc-/0/1739213827214?e=1781136000&v=beta&t=AeXJ3EBaiGUwkKeweQXjb7CPypJqrebit4My932bgVQ',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.person_rounded,
                      size: 64,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
              // Edit circle button overlays
              Positioned(
                bottom: 2,
                right: 2,
                child: GestureDetector(
                  onTap: _openEditProfileDialog,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Icon(
                      Icons.edit_rounded,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Name and ID
          Text(
            _patientName,
            style: GoogleFonts.manrope(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.onSurface,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Patient ID: $_patientId',
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 16),
          // Member Chips
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.secondaryContainer.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Premium Member',
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: AppColors.onSecondaryContainer,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainer,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Verified',
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Personal Details Card (Age, Gender, Blood type, Contact data)
  Widget _buildPersonalDetailsCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.outlineVariant.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.person_outline_rounded, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(
                'Personal Details',
                style: GoogleFonts.manrope(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          // Details Grid
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 2.2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            children: [
              _buildGridItem('Age', _patientAge),
              _buildGridItem('Gender', _patientGender),
              _buildGridItem('Blood Group', _patientBloodGroup, isBlood: true),
              _buildGridItem('Height', _patientHeight),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 14.0),
            child: Divider(height: 1),
          ),
          // Contact Details
          _buildContactRow(Icons.mail_outline_rounded, _patientEmail),
          const SizedBox(height: 12),
          _buildContactRow(Icons.call_outlined, _patientPhone),
          const SizedBox(height: 12),
          _buildContactRow(Icons.location_on_outlined, _patientLocation),
        ],
      ),
    );
  }

  Widget _buildGridItem(String title, String value, {bool isBlood = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: GoogleFonts.inter(
            fontSize: 9,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.8,
            color: AppColors.outline,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: isBlood ? AppColors.error : AppColors.onSurface,
          ),
        ),
      ],
    );
  }

  Widget _buildContactRow(IconData icon, String value) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary, size: 18),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 13,
              color: AppColors.onSurface,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  // Bento Medical History cards (Chronic Conditions & Allergies)
  Widget _buildBentoMedicalHistoryRow() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth > 500;
        if (wide) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildChronicConditionsCard()),
              const SizedBox(width: 16),
              Expanded(child: _buildAllergiesCard()),
            ],
          );
        } else {
          return Column(
            children: [
              _buildChronicConditionsCard(),
              const SizedBox(height: 16),
              _buildAllergiesCard(),
            ],
          );
        }
      },
    );
  }

  // Chronic Conditions
  Widget _buildChronicConditionsCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.outlineVariant.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.01),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.history_rounded, color: AppColors.primary),
                  const SizedBox(width: 8),
                  Text(
                    'Chronic Conditions',
                    style: GoogleFonts.manrope(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.onSurface,
                    ),
                  ),
                ],
              ),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(Icons.add_circle_outline_rounded, color: AppColors.outline),
                onPressed: () => _openAddItemDialog(true),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: _chronicConditions.map((cond) {
              final isHeadache = cond.toLowerCase() == 'headache';
              return Chip(
                label: Text(
                  cond,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: isHeadache ? AppColors.error : AppColors.onSurface,
                  ),
                ),
                backgroundColor: isHeadache
                    ? const Color(0xFFFFDAD6)
                    : AppColors.surfaceContainerLow,
                side: BorderSide.none,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                deleteIcon: const Icon(Icons.close, size: 12),
                onDeleted: () {
                  setState(() => _chronicConditions.remove(cond));
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // Allergies Card
  Widget _buildAllergiesCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.outlineVariant.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.01),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.medical_information_outlined, color: AppColors.primary),
                  const SizedBox(width: 8),
                  Text(
                    'Allergies',
                    style: GoogleFonts.manrope(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.onSurface,
                    ),
                  ),
                ],
              ),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(Icons.add_circle_outline_rounded, color: AppColors.outline),
                onPressed: () => _openAddItemDialog(false),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: _allergies.map((allergy) {
              return Chip(
                label: Text(
                  allergy,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: AppColors.onSurface,
                  ),
                ),
                backgroundColor: const Color(0xFFF47779).withOpacity(0.18),
                side: BorderSide(color: const Color(0xFFF47779).withOpacity(0.3)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                deleteIcon: const Icon(Icons.close, size: 12),
                onDeleted: () {
                  setState(() => _allergies.remove(allergy));
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // Prescriptions list
  Widget _buildPrescriptionsCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.outlineVariant.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.receipt_long_outlined, color: AppColors.primary),
                  const SizedBox(width: 8),
                  Text(
                    'Recent Prescriptions',
                    style: GoogleFonts.manrope(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.onSurface,
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Accessing full historical records archive...')),
                  );
                },
                child: Text(
                  'View All',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _prescriptions.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final pr = _prescriptions[index];
              final isAyur = pr['type'] == 'ayurvedic';
              final isHovered = _hoveredPrescriptionId == pr['id'];

              return MouseRegion(
                onEnter: (_) => setState(() => _hoveredPrescriptionId = pr['id'] as int),
                onExit: (_) => setState(() => _hoveredPrescriptionId = 0),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isHovered ? AppColors.primary.withOpacity(0.03) : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isHovered
                          ? AppColors.primary.withOpacity(0.4)
                          : AppColors.outlineVariant.withOpacity(0.5),
                    ),
                  ),
                  child: Row(
                    children: [
                      // Prescription Emblem
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: isAyur
                              ? AppColors.secondaryContainer.withOpacity(0.6)
                              : AppColors.tertiaryContainer.withOpacity(0.18),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          pr['icon'] as IconData,
                          color: isAyur ? AppColors.onSecondaryContainer : AppColors.tertiaryContainer,
                        ),
                      ),
                      const SizedBox(width: 14),
                      // Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              pr['name'] as String,
                              style: GoogleFonts.inter(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: AppColors.onSurface,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              '${pr['practitioner']} • ${pr['date']}',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                color: AppColors.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Action buttons responsive stack
                      Row(
                        children: [
                          TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: AppColors.surfaceContainerLow,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  backgroundColor: Colors.white,
                                  title: Text(pr['name'] as String, style: GoogleFonts.manrope(fontWeight: FontWeight.bold)),
                                  content: Text(
                                    'Prescribed dosage: Take 1 capsule twice daily after meals.\nAuthorized practitioner: ${pr['practitioner']}.\nDigital Signature: VERIFIED.',
                                    style: GoogleFonts.inter(),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('OK'),
                                    )
                                  ],
                                ),
                              );
                            },
                            child: Text(
                              'Details',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: AppColors.onSurfaceVariant,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            onPressed: () => _openOrderMedsSheet(pr),
                            child: Text(
                              'Order Meds',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // Medical Reports Card (List + View/Download Actions)
  Widget _buildReportsCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.outlineVariant.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.description_outlined, color: AppColors.primary),
                  const SizedBox(width: 8),
                  Text(
                    'Medical Reports',
                    style: GoogleFonts.manrope(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.onSurface,
                    ),
                  ),
                ],
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryContainer,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                icon: const Icon(Icons.upload_rounded, size: 14),
                label: Text(
                  'Upload New',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: _openUploadReportSheet,
              ),
            ],
          ),
          const SizedBox(height: 14),
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 400,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 4.0,
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _reports.length,
            itemBuilder: (context, index) {
              final rep = _reports[index];
              return Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.outlineVariant.withOpacity(0.4)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.picture_as_pdf_rounded, color: AppColors.primary, size: 30),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            rep['name'] as String,
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: AppColors.onSurface,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Uploaded: ${rep['date']} • ${rep['size']}',
                            style: GoogleFonts.inter(
                              fontSize: 10,
                              color: AppColors.outline,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.visibility_outlined, size: 18, color: AppColors.primary),
                          onPressed: () => _openReportPreview(rep),
                        ),
                        IconButton(
                          icon: const Icon(Icons.download_outlined, size: 18, color: AppColors.primary),
                          onPressed: () => _simulateDownload(rep['name'] as String),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline_rounded, size: 18, color: AppColors.error),
                          onPressed: () {
                            setState(() => _reports.removeWhere((r) => r['id'] == rep['id']));
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Removed report "${rep['name']}"')),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // Large Floating Action button for Edit Profile on Mobile or Desktop sizes
  Widget _buildEditFAB() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = MediaQuery.of(context).size.width > 700;
        if (wide) {
          return FloatingActionButton.extended(
            backgroundColor: AppColors.primaryContainer,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            icon: const Icon(Icons.edit_rounded, size: 18),
            label: Text(
              'Edit Profile',
              style: GoogleFonts.inter(fontWeight: FontWeight.bold),
            ),
            onPressed: _openEditProfileDialog,
          );
        } else {
          return FloatingActionButton(
            backgroundColor: AppColors.primaryContainer,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            onPressed: _openEditProfileDialog,
            child: const Icon(Icons.edit_rounded),
          );
        }
      },
    );
  }
}
