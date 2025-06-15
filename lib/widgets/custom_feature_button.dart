import 'package:flutter/material.dart';

class CustomFeatureCardButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final Color color;

  const CustomFeatureCardButton({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.color = Colors.blue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: title,
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: color,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          splashColor: Colors.white24,
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 44, color: Colors.white),
                const SizedBox(height: 12),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );

    // Card(
    //   elevation: 6,
    //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    //   color: color,
    //   child: InkWell(
    //     borderRadius: BorderRadius.circular(16),
    //     onTap: onTap,
    //     splashColor: Colors.white24,
    //     child: Container(
    //       padding: const EdgeInsets.all(20),
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           Icon(icon, size: 44, color: Colors.white),
    //           const SizedBox(height: 12),
    //           Text(
    //             title,
    //             style: const TextStyle(
    //               color: Colors.white,
    //               fontSize: 15,
    //               fontWeight: FontWeight.w600,
    //             ),
    //             textAlign: TextAlign.center,
    //           )
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
