import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BannerAds extends StatelessWidget {
  const BannerAds({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(10.0),
      height: 140,
      decoration: BoxDecoration(
        color: Colors.deepPurple.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Every Rupee Counts!",
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Start saving with ₹10 in Gold every day.",
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 5),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.purple, // Button color
                  ),
                  onPressed: () {},
                  child: const Text("Start Daily Savings"),
                ),
              ],
            ),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                'https://img.etimg.com/thumb/width-1200,height-900,imgsize-273398,resizemode-75,msid-61036052/wealth/spend/7-things-to-know-while-buying-gold-coins.jpg', // Place an appropriate image asset
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
