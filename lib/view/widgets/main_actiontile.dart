import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainAction extends StatelessWidget {
  const MainAction({
    super.key,
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80, // Adjust width if needed
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.deepPurple.shade50,
            child: Icon(icon, color: Colors.purple),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            textAlign: TextAlign.center, // Center-align the text
            style: GoogleFonts.roboto(
              fontSize: 12,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
