import 'package:flutter/material.dart';

class forecasts extends StatelessWidget {
  final IconData icon;
  final String time;
  final String temp;

  const forecasts(
      {required this.icon, required this.time, required this.temp, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Card(
          elevation: 6,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  time,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,

                  // overflow: TextOverflow.,
                ),
                SizedBox(height: 8),
                Icon(
                  icon,
                  size: 40,
                ),
                SizedBox(height: 8),
                Text(
                  temp,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
