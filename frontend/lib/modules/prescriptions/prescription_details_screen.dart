import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';

/// A secure data model representing a single prescribed item.
class PrescribedItem {
  final String name;
  final String dosage;
  final String duration;
  final IconData dosageIcon;
  final IconData durationIcon;

  const PrescribedItem({
    required this.name,
    required this.dosage,
    required this.duration,
    this.dosageIcon = Icons.medication_outlined,
    this.durationIcon = Icons.calendar_month_outlined,
  });
}

/// A secure data model representing prescription details.
class PrescriptionDetails {
  final int id;
  final String name;
  final String date;
  final String status;
  final String doctorName;
  final String doctorTitle;
  final String doctorNotes;
  final List<PrescribedItem> items;

  const PrescriptionDetails({
    required this.id,
    required this.name,
    required this.date,
    required this.status,
    required this.doctorName,
    required this.doctorTitle,
    required this.doctorNotes,
    required this.items,
  });
}

/// A premium, secure screen displaying comprehensive details of a medical prescription.
/// Adapts gracefully to all screen dimensions and matches the Interlink Digital design system.
class PrescriptionDetailsScreen extends StatelessWidget {
  final int prescriptionId;

  const PrescriptionDetailsScreen({
    super.key,
    required this.prescriptionId,
  });

  /// Protected database lookup mapping IDs to secure prescription data models.
  /// Prevents unexpected crashes or data leakages by providing safe fallbacks.
  PrescriptionDetails _lookupPrescriptionDetails(int id) {
    switch (id) {
      case 1:
        return const PrescriptionDetails(
          id: 1,
          name: 'Ayurvedic Immunity Booster Kit',
          date: '12 Oct 2023',
          status: 'Active',
          doctorName: 'Dr. Vaidya Ramanathan',
          doctorTitle: 'Chief Ayurvedic Physician',
          doctorNotes:
              'Maintain a balanced diet rich in seasonal vegetables. Strictly avoid cold drinks, deep-fried foods, and heavy meals late at night. Practice Pranayama (Anulom Vilom and Kapalbhati) for at least 15 minutes daily to enhance lung capacity and overall immunity. Return for a follow-up consultation in 3 weeks.',
          items: [
            PrescribedItem(
              name: 'Ashwagandha Capsules',
              dosage: '1 capsule twice daily after meals',
              duration: 'Duration: 30 days',
              dosageIcon: Icons.medication_outlined,
            ),
            PrescribedItem(
              name: 'Giloy Ghan Vati',
              dosage: '2 tablets in the morning on an empty stomach',
              duration: 'Duration: 15 days',
              dosageIcon: Icons.medication_outlined,
            ),
            PrescribedItem(
              name: 'Chyawanprash',
              dosage: '1 tablespoon with warm milk before bed',
              duration: 'Duration: 60 days',
              dosageIcon: Icons.soup_kitchen_outlined,
            ),
          ],
        );
      case 2:
        return const PrescriptionDetails(
          id: 2,
          name: 'Unani Respiratory Syrup Kit',
          date: '28 Sep 2023',
          status: 'Completed',
          doctorName: 'Dr. Hakim Zafar',
          doctorTitle: 'Senior Unani Physician',
          doctorNotes:
              'Keep warm at all times. Avoid damp environments and exposure to cold air. Drink warm water throughout the day. Return for a follow-up consultation in 2 weeks.',
          items: [
            PrescribedItem(
              name: 'Unani Respiratory Syrup',
              dosage: '2 teaspoons twice daily after meals',
              duration: 'Duration: 15 days',
              dosageIcon: Icons.opacity_outlined,
            ),
            PrescribedItem(
              name: 'Kalonji Seed Capsules',
              dosage: '1 capsule daily with water',
              duration: 'Duration: 30 days',
              dosageIcon: Icons.medication_outlined,
            ),
          ],
        );
      default:
        // Safe, protected fallback to prevent app crashes if an invalid ID is passed
        return PrescriptionDetails(
          id: id,
          name: 'Prescription Details',
          date: 'Unknown Date',
          status: 'Inactive',
          doctorName: 'Medical practitioner',
          doctorTitle: 'Consulting Physician',
          doctorNotes: 'Please contact the clinic for further instructions.',
          items: const [],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final details = _lookupPrescriptionDetails(prescriptionId);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 2,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
          tooltip: 'Go Back',
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Prescription Details',
          style: GoogleFonts.manrope(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert_rounded, color: Colors.white),
            tooltip: 'More Options',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Options coming soon...')),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double horizontalMargin = constraints.maxWidth > 700 ? 48.0 : 16.0;
            final double contentWidth = constraints.maxWidth > 1200 ? 1200 : constraints.maxWidth;

            return Center(
              child: SizedBox(
                width: contentWidth,
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: horizontalMargin, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 1. Prescription Summary Card
                      _buildSummaryCard(context, details),
                      const SizedBox(height: 24),

                      // 2. Prescribed Items Header
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0, bottom: 12.0),
                        child: Text(
                          'Prescribed Items',
                          style: GoogleFonts.manrope(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.onSurface,
                          ),
                        ),
                      ),

                      // 3. Grid / List of Prescribed Items
                      _buildPrescribedItemsLayout(constraints, details.items),
                      const SizedBox(height: 24),

                      // 4. Doctor's Instructions Card
                      _buildDoctorNotesCard(details),
                      const SizedBox(height: 24),

                      // 5. Secure Action Buttons
                      _buildActionButtons(context),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  /// Builds the top prescription summary container (Kit title, date, doctor details).
  Widget _buildSummaryCard(BuildContext context, PrescriptionDetails details) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.outlineVariant.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Rx Rounded Icon
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.receipt_long_outlined,
                  color: AppColors.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      details.name,
                      style: GoogleFonts.manrope(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.onSurface,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Prescribed on ${details.date}',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              // Status Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: details.status.toLowerCase() == 'active'
                      ? AppColors.secondaryContainer.withOpacity(0.3)
                      : AppColors.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: details.status.toLowerCase() == 'active'
                        ? AppColors.secondaryContainer
                        : AppColors.outlineVariant,
                    width: 1,
                  ),
                ),
                child: Text(
                  details.status,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: details.status.toLowerCase() == 'active'
                        ? AppColors.onSecondaryContainer
                        : AppColors.outline,
                  ),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Divider(height: 1),
          ),
          Row(
            children: [
              // Avatar for doctor
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.person_outline_rounded,
                  color: AppColors.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      details.doctorName,
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.onSurface,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      details.doctorTitle,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Builds a responsive grid (on wider viewports) or vertical list of prescribed items.
  Widget _buildPrescribedItemsLayout(BoxConstraints constraints, List<PrescribedItem> items) {
    if (items.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.outlineVariant.withOpacity(0.3)),
        ),
        child: Center(
          child: Text(
            'No items prescribed.',
            style: GoogleFonts.inter(color: AppColors.outline),
          ),
        ),
      );
    }

    final bool isWide = constraints.maxWidth > 700;

    if (isWide) {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 600,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 3.8,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) => _buildItemCard(items[index]),
      );
    } else {
      return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) => _buildItemCard(items[index]),
      );
    }
  }

  /// Card widget for a single prescribed medicine.
  Widget _buildItemCard(PrescribedItem item) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.outlineVariant.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.015),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            item.name,
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.onSurface,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(item.dosageIcon, size: 18, color: AppColors.primary),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  item.dosage,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(item.durationIcon, size: 18, color: AppColors.primary),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  item.duration,
                  style: GoogleFonts.inter(
                    fontSize: 13,
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

  /// Card widget displaying special physician instructions or notes.
  Widget _buildDoctorNotesCard(PrescriptionDetails details) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.info_outline_rounded, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(
                "Doctor's Notes",
                style: GoogleFonts.manrope(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            details.doctorNotes,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: AppColors.onSurfaceVariant,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  /// Refined solid and outlined stadium action buttons.
  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            icon: const Icon(Icons.shopping_cart_outlined, size: 20),
            label: Text(
              'Order Refill',
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Order Refill submitted successfully!')),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              side: const BorderSide(color: AppColors.primary, width: 1.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            icon: const Icon(Icons.download_outlined, size: 20),
            label: Text(
              'Download PDF',
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Downloading prescription PDF...')),
              );
            },
          ),
        ),
      ],
    );
  }
}
