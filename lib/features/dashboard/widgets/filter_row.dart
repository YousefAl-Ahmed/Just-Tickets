import 'package:flutter/material.dart';
import 'package:just_tickets/constants/assets.dart';
import 'package:just_tickets/features/dashboard/widgets/filter_square.dart';
import 'package:just_tickets/features/dashboard/widgets/time_dropdown.dart';

class FilterRow extends StatelessWidget {
  const FilterRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0), // Space on sides
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // First Filter Button (Filter Options)
          FilterSquare(
            label: 'تصفية',
            rightIcon: Assets.filter, // Your SVG path for right icon
            leftIcon: Assets.downArrow, // Your SVG path for left icon
            onTap: () => _showFilterModal(context),
          ),

          // Second Filter Button (Dropdown for Time)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: TimeDropdown(),
          ),

          // Third Filter Button (Offers Filter)
          FilterSquare(
            label: 'العروض',
            onTap: () => _applyOffersFilter(),
          ),
        ],
      ),
    );
  }

  // Function to open filter modal
  void _showFilterModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return _FilterModal();
      },
    );
  }

  // Function to apply offers filter (dummy for now)
  void _applyOffersFilter() {
    print("Offers filter applied");
    // In the future, this will trigger the filtering of events based on offers
  }
}

class _FilterModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // First section with checkboxes
          _buildFilterCheckbox('أضيف حديثا', context),
          _buildFilterCheckbox('الأعلى تقييما', context),
          _buildFilterCheckbox('العروض', context),

          const Divider(),

          // Price range filter
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'من',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'إلى',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
          ),

          ElevatedButton(
            onPressed: () {
              // Implement your filtering logic here
              Navigator.pop(context);
            },
            child: const Text('تطبيق'),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterCheckbox(String title, BuildContext context) {
    return CheckboxListTile(
      value: false, // Default value
      onChanged: (bool? value) {
        // Handle checkbox changes
      },
      title: Text(title, style: Theme.of(context).textTheme.bodyLarge),
    );
  }
}
