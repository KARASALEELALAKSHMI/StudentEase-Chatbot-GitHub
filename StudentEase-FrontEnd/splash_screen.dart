import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/signin');
    });

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF8A2BE2), Color(0xFF4B0082)],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Animated welcome text
            AnimatedOpacity(
              opacity: 1.0,
              duration: Duration(seconds: 1),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      '📘 Welcome\nto Student\nEase!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 2.0,
                        height: 1.4, // Adjust line spacing
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '📚 Learn, Grow, Succeed',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white70,
                        fontStyle: FontStyle.italic,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Animated Logo with scale and fade transition
            AnimatedScale(
              scale: 1.2, // Slight scaling for logo
              duration: Duration(seconds: 2),
              child: AnimatedOpacity(
                opacity: 1.0,
                duration: Duration(seconds: 3),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: Image.asset(
                    'assets/Rectangle.png',
                    fit: BoxFit.contain,
                    height: 150, // Adjust height for a modern logo look
                  ),
                ),
              ),
            ),

            // Bottom curved container
            AnimatedContainer(
              duration: Duration(seconds: 2),
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7), // Add transparency for modern effect
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
