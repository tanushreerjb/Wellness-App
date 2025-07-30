import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wellness_app/features/users/customer/screens/quote.dart';
import '../../../service/firestore_service.dart';


class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  bool isLoading = false;
  List<Map<String, dynamic>> userFavorites = [];

  @override
  void initState() {
    super.initState();
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    setState(() {
      isLoading = true;
    });

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        log(user.uid);
        final favorites = await FireStoreService().getUserFavorites(user.uid);
        setState(() {
          userFavorites = favorites;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      log('Error loading favorites: $e');
      setState(() {
        isLoading = false;
        userFavorites = [];
      });
    }
  }

  Widget _buildFavoriteQuoteCard(Map<String, dynamic> favorite) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: SizedBox(
        width: 400.0,
        child: FilledButton(
          style: ButtonStyle(
            alignment: Alignment.centerLeft,
            backgroundColor: WidgetStatePropertyAll(Colors.white12),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            ),
          ),
          onPressed: () {
            _navigateToQuoteWithSelection(favorite);
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '"${favorite['quoteText']}"',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8),
                Text(
                  '- ${favorite['authorName']}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  favorite['categoryName'],
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white54,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToQuoteWithSelection(Map<String, dynamic> favorite) {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QuotePage(
            categoryFilter: favorite['categoryName'],
            userId: user.uid,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'My Favorites',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: isLoading
          ? Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      )
          : userFavorites.isEmpty
          ? Center(
        child: Text(
          'No favorite quotes yet',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white70,
            fontFamily: 'Poppins',
          ),
        ),
      )
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: userFavorites.length,
          itemBuilder: (context, index) {
            return _buildFavoriteQuoteCard(userFavorites[index]);
          },
        ),
      ),
    );
  }
}