import 'dart:developer';
import 'dart:math' hide log;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:wellness_app/features/users/customer/screens/profile.dart';
import '../../../service/firestore_service.dart';

class QuotePage extends StatefulWidget {
  final String? categoryFilter;
  final String userId;
  const QuotePage({super.key, this.categoryFilter, required this.userId});

  @override
  State<QuotePage> createState() => _QuotePageState();
}

class _QuotePageState extends State<QuotePage> {
  bool isChecked = false;
  bool isLoading = true;
  bool isHeartClicked = false;
  Map<String, dynamic>? currentQuote;

  @override
  void initState() {
    super.initState();
    loadQuote();
  }

  Future<void> loadQuote() async {
    setState(() {
      isLoading = true;
    });

    try {
      if (widget.categoryFilter != null) {
        final quotes = await FireStoreService().getQuotesByCategory(
          categoryName: widget.categoryFilter!,
        );

        setState(() {
          if (quotes.isNotEmpty) {
            // Display random quote from category
            final random = Random();
            final randomIndex = random.nextInt(quotes.length);
            currentQuote = quotes[randomIndex];
            isHeartClicked = false; // Reset heart state for new quote
          }
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      log('Error loading quote: $e');
      setState(() {
        isLoading = false;
        currentQuote = null;
      });
    }
  }

  Future<void> addToFavorites() async {
    if (currentQuote == null) return;

    // Set heart to red immediately when clicked
    setState(() {
      isHeartClicked = true;
    });

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user!=null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection("users")
            .doc(user.uid)
            .get();

        String username = '';
        if (userDoc.exists) {
          Map<String, dynamic> userData = userDoc.data() as Map<String,
              dynamic>;
          username = userData['name'] ?? user.displayName ?? 'Unknown';
        } else {
          username = user.displayName ?? 'Unknown';
        }
        bool success = await FireStoreService().addToFavorites(
          userId: widget.userId,
          quoteId: currentQuote!['id'],
          quoteText: currentQuote!['quoteText'],
          authorName: currentQuote!['authorName'],
          categoryName: currentQuote!['name'],
          userName: username,
        );

        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Quote added to favorites!'),
              backgroundColor: Colors.green,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to add quote to favorites'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      log('Error adding to favorites: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error adding quote to favorites'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<WidgetState> states) {
      const Set<WidgetState> interactiveStates = <WidgetState>{
        WidgetState.pressed,
        WidgetState.hovered,
        WidgetState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.black;
      }
      return Colors.white;
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Quote',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: isLoading
          ? Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      )
          : Column(
        spacing: 20,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 360,
            child: Text(
              widget.categoryFilter ?? 'Motivation',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            width: 300,
            child: Text(
              currentQuote != null
                  ? '"${currentQuote!['quoteText']}" - ${currentQuote!['authorName']}'
                  : '"The only way to do great work is to love what you do" - Steve Jobs',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: addToFavorites,
                icon: Icon(
                  isHeartClicked ? Icons.favorite : Icons.favorite_border,
                  color: isHeartClicked ? Colors.red : Colors.white,
                  size: 30,
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }
}
