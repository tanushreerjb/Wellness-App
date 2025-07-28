import 'dart:developer';
import 'dart:math' hide log;
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../../service/firestore_service.dart';

class QuotePage extends StatefulWidget {
  final String? categoryFilter;
  const QuotePage({super.key, this.categoryFilter});

  @override
  State<QuotePage> createState() => _QuotePageState();
}

class _QuotePageState extends State<QuotePage> {
  bool isChecked = false;
  bool isLoading = true;
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
        ],
      ),
    );
  }
}