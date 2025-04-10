import 'package:figdesign/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class UpdatesScreen extends StatelessWidget {
  final DatabaseReference _databaseReference =
  FirebaseDatabase.instance.ref().child('updates');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFF4B0082),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Row(
                children: [
                  const SizedBox(width: 10),
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/chatbot.png'),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'StudentEase',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),  // <-- This dynamically fills the available space
                  IconButton(
                    icon: const Icon(Icons.logout, color: Colors.white),
                    onPressed: () => _logout(context),
                  ),
                ],
              ),

              const SizedBox(height: 30),
              const Text(
                'New Updates',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: StreamBuilder<DatabaseEvent>(
                  stream: _databaseReference.onValue,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'Error: ${snapshot.error}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      );
                    } else if (snapshot.hasData &&
                        snapshot.data!.snapshot.value != null) {
                      Map<dynamic, dynamic> data = snapshot.data!.snapshot.value
                      as Map<dynamic, dynamic>;
                      List<Map<dynamic, dynamic>> updates = data.entries
                          .map((entry) => {
                        'key': entry.key,
                        ...entry.value as Map<dynamic, dynamic>
                      })
                          .toList();

                      return ListView.builder(
                        itemCount: updates.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.all(16.0),
                            margin: const EdgeInsets.only(bottom: 10.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  updates[index]['headline'] ?? 'No headline',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                // Text(
                                //   updates[index]['content'] ?? 'No content',
                                //   style: const TextStyle(fontSize: 14),
                                // ),
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: Text(
                          'No updates available.',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/chat');
                      },
                      child: const CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage('assets/bot.png'),
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Help?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void _logout(BuildContext context) {
    // Perform logout actions (if any), such as Firebase sign-out
    // FirebaseAuth.instance.signOut();

    // Navigate to the Signin page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SigninScreen()), // Replace `SigninScreen` with your actual Signin page class
    );

    // Optionally, show a logout confirmation
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Logged out successfully')),
    );
  }

}
