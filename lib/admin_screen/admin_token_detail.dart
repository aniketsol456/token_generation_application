import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:token_generation_application/services/token_option.dart';

// Define Token class
class Token {
  final String description;
  final String Date;
  final String Time;

  Token({
    required this.description,
    required this.Date,
    required this.Time,
  });
}

class AdminTokenDetailScreen extends StatefulWidget {
  const AdminTokenDetailScreen({Key? key}) : super(key: key);

  @override
  State<AdminTokenDetailScreen> createState() => _AdminTokenDetailScreenState();
}

class _AdminTokenDetailScreenState extends State<AdminTokenDetailScreen> {
  List<Token> tokens = []; // Initialize an empty list of tokens

  @override
  void initState() {
    super.initState();
    fetchAndSetTokens(); // Fetch tokens when the screen is initialized
  }

  Future<void> fetchAndSetTokens() async {
    try {
      // Fetch transactions using FirebaseOperations
      Stream<QuerySnapshot> tokenStream =
          FirebaseOperations.fetchTransactions();

      // Listen to the stream and update tokens when data changes
      tokenStream.listen((QuerySnapshot snapshot) {
        List<Token> fetchedTokens = snapshot.docs.map((doc) {
          return Token(
            description: doc['Description'] ?? '',
            Date: doc['Date'] ?? '',
            Time: doc['Time'] ?? '',
          );
        }).toList();

        setState(() {
          tokens = fetchedTokens;
        });
      });
    } catch (e) {
      print('Error fetching tokens: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Token Details'),
      ),
      body: tokens.isNotEmpty
          ? ListView.builder(
              itemCount: tokens.length,
              itemBuilder: (context, index) {
                final token = tokens[index];
                return ListTile(
                  // title: Text('Token ${token.sequenceNumber}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Date: ${token.Date}'),
                      Text('Description: ${token.description}'),
                      Text('Time: ${token.Time}'),
                    ],
                  ),
                );
              },
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
