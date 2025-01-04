import 'package:flutter/material.dart';
import 'SignIn.dart';
import 'specialistsignin.dart';
import 'signup_page.dart';
import 'specialistsignup.dart';

class SignInSignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hi',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),

      body: Container(
        color: Colors.white,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Regular User Container
                Container(
                  width: 350,
                  height: 300,
                  padding: EdgeInsets.all(16.0),
                  margin: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.indigoAccent,
                    border: Border.all(color: Colors.transparent, width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: Text(
                          'Regular User',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white, // White text
                                minimumSize: Size(double.infinity, 50),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => SignInPage()),
                                );
                              },
                              child: Text("Sign In"),
                            ),
                            SizedBox(height: 10),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.indigoAccent,
                                minimumSize: Size(double.infinity, 50),
                                side: BorderSide(color: Colors.indigoAccent),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => SignUpPage()),
                                );
                              },
                              child: Text("Sign Up"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Specialist Container
                Container(
                  width: 350,
                  height: 300,
                  padding: EdgeInsets.all(16.0),
                  margin: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.indigoAccent,
                    border: Border.all(color: Colors.transparent, width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: Text(
                          'Specialist',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white, // White text
                                minimumSize: Size(double.infinity, 50),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => SpecialistSignInPage()),
                                );
                              },
                              child: Text("Sign In"),
                            ),
                            SizedBox(height: 10),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.indigoAccent,
                                minimumSize: Size(double.infinity, 50),
                                side: BorderSide(color: Colors.indigoAccent),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => SpecialistSignUpPage()),
                                );
                              },
                              child: Text("Sign Up"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
