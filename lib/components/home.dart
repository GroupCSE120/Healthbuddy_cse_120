import 'package:flutter/material.dart';
import 'package:health_buddy/constants/app_color.dart';
import 'package:lottie/lottie.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final AppColors colors = AppColors();

    return Scaffold(
      backgroundColor: colors.darkBg,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align to the top-left
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text Column
                Expanded(
                  flex: 2, // Take proportional width
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      Text(
                        'Hey!',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: colors.lightBlue,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'This is your Health Buddy.',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
                // Lottie Animation
                Expanded(
                  flex: 2,
                  child: LottieBuilder.asset(
                    'assets/images/home_lottie.json',
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white60,
                  width: 2.0,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.person_outline,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      const Text(
                        textAlign: TextAlign.start,
                        'Mr. Arjun Kharade',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Card(
                        color: colors.green,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('height'),
                        ),
                      ),
                      Card(
                        color: colors.green,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Weight'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "BMI : ",
                    style: TextStyle(fontSize: 24, color: colors.lightBlue),
                  ),
                  Text('note: BMI is in normal range, maintain it', style: TextStyle(color: Colors.green)),
                ],
              ),
            ),
            const Spacer(), // Pushes everything to the top, leaving space below
          ],
        ),
      ),
    );
  }
}
