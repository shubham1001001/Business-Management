import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/vendor_comment_timeline/vendor_comment_timeline_provider.dart';

/// not complete screen
class VendorTimelineScreen extends StatelessWidget {
  const VendorTimelineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Comment", style: TextStyle(fontWeight: FontWeight.bold)),
        leading: const BackButton(),
      ),
      body: Consumer<VendorCommentTimelineProvider>(
        builder: (context, provider, _) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _VendorHeader(),
                const SizedBox(height: 20),
                Flexible(
                  child: ListView.separated(
                    itemCount: provider.events.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final event = provider.events[index];
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              const CircleAvatar(radius: 8, backgroundColor: Colors.red),
                              if (index != provider.events.length - 1) Container(width: 2, height: 50, color: Colors.black),
                            ],
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(event.title, style: const TextStyle(fontWeight: FontWeight.w500)),
                                const SizedBox(height: 4),
                                Text("${event.date}   ${event.time}", style: const TextStyle(color: Colors.grey)),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _VendorHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Vendor name",
          style: TextStyle(color: Colors.red, fontSize: mq.size.width * 0.05, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text("+91 8152369874", style: TextStyle(fontSize: mq.size.width * 0.04)),
      ],
    );
  }
}
