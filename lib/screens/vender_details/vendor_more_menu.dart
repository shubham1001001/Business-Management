import 'package:flutter/material.dart';

import '../../core/constants/text_styles.dart';

class VendorMoreMenu extends StatelessWidget {
  const VendorMoreMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vendor Details", style: AppTextStyles.appBarBlackText),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

              showMenu(
                context: context,
                position: RelativeRect.fromLTRB(1000, 80, 10, 100), // Adjust position as needed
                items: [_buildMenuItem(Icons.comment, 'Comment'), _buildMenuItem(Icons.receipt_long, 'Customer statement'), _buildMenuItem(Icons.public, 'Lorem ipsum'), _buildMenuItem(Icons.public, 'Lorem ipsum')],
                elevation: 4.0,
              );
            },
          ),
        ],
      ),
      body: const Center(child: Text("Tap the top-right menu")),
    );
  }

  PopupMenuItem _buildMenuItem(IconData icon, String title) {
    return PopupMenuItem(
      child: Row(
        children: [
          Icon(icon, size: 18),
          const SizedBox(width: 12),
          Flexible(child: Text(title, overflow: TextOverflow.ellipsis)),
        ],
      ),
    );
  }
}
