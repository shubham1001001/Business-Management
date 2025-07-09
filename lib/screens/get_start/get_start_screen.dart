import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales/routes/app_routes_name.dart';

import '../../core/constants/colors.dart';
import '../../providers/auth_provider/signup_provider.dart';

class GetStartScreen extends StatelessWidget {
  const GetStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: Stack(
        children: [
          // Background image
          SizedBox(
            height: size.height,
            width: size.width,
            child: Image.network("https://images.unsplash.com/photo-1536152470836-b943b246224c?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fG5hdHVyZSUyMHZzJTIwbnVydHVyZXxlbnwwfHwwfHx8MA%3D%3D", fit: BoxFit.cover),
            // Image.asset(
            //   'assets/images/bg.jpg', // Use your image path
            //   fit: BoxFit.cover,
            // ),
          ),
          // Dark overlay
          Container(width: size.width, height: size.height, color: Colors.black.withOpacity(0.4)),
          // Slogan
          Positioned(
            top: size.height * 0.3,
            left: size.width * 0.14,
            child: Text(
              textAlign: TextAlign.center,
              'Bridging miles\n with\nmeaning',
              style: TextStyle(fontSize: 40, color: Colors.white54, fontWeight: FontWeight.w600),
            ),
          ),
          // White card
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.only(bottom: size.height * 0.1),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(24, 32, 24, 16),
                decoration: const BoxDecoration(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
                child: Center(
                  child: SizedBox(
                    width: size.width * 0.6,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(AppRoutesName.signup);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.grey,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                        side: BorderSide(color: Colors.grey.shade700),
                      ),
                      child: const Text('Get Start'),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
