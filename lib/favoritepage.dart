import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavoritePage extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final User? currentUser = _auth.currentUser;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Favorites"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('favorites')
            .doc(currentUser!.uid)
            .collection('userFavorites')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text("An error occurred: ${snapshot.error}"),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("No favorites yet."),
            );
          }

          return ListView(
            children: snapshot.data!.docs.map((doc) {
              Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
              return GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      contentPadding: const EdgeInsets.all(16),
                      title: const Center(child: Text("Service Details")), // Updated title
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Specialist: ${data['specialistname'] ?? 'N/A'}",
                            style: const TextStyle(fontSize: 16.0),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Service: ${data['service'] ?? 'N/A'}",
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Location: ${data['location'] ?? 'N/A'}",
                            style: const TextStyle(fontSize: 14.0),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              "Description: ${data['servicedescription'] ?? 'N/A'}",
                              style: const TextStyle(fontSize: 14.0),
                            ),
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Close"),
                        ),
                      ],
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: Colors.blue, width: 1.5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Specialist: ${data['specialistname'] ?? 'Specialist'}",
                        style: const TextStyle(fontSize: 16.0),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        "Service: ${data['service'] ?? 'Service'}",
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        "Location: ${data['location'] ?? 'Location'}",
                        style: const TextStyle(fontSize: 14.0),
                      ),
                      const SizedBox(height: 16.0),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: TextButton(
                          onPressed: () async {
                            // Remove the favorite item
                            await _firestore
                                .collection('favorites')
                                .doc(currentUser.uid)
                                .collection('userFavorites')
                                .doc(doc.id)
                                .delete();
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.red,
                          ),
                          child: const Text("Remove"),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        backgroundColor: Colors.blue,
        child: Icon(Icons.arrow_back, color: Colors.white),

      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

    );
  }
}


