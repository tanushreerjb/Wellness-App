import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../core/route/route_name.dart';
import '../../../service/firestore_service.dart';

class AddQuote extends StatefulWidget {
  final String userId;
  const AddQuote({super.key, required this.userId});

  @override
  State<AddQuote> createState() => _AddQuoteState();
}

class _AddQuoteState extends State<AddQuote> {
  bool isChecked = false;
  bool isLoading = false;
  String? selectedCategory;

  List<Map<String,dynamic>> categories = [];

  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _quotesController = TextEditingController();


  @override

  void initState(){
    super.initState();
    loadCategory();
  }

  Future<void> loadCategory() async {
    try {
      // Load user categories from FireStore
      List<Map<String, dynamic>> temp = await FireStoreService().getCategories(
        userId: widget.userId,
      );

      setState(() {
        categories = temp;
      });
    } catch (e) {
      _showSnackBar('Failed to load categories: ${e.toString()}', isError: true);
    }
  }

  Future<void> _saveQuote() async {
    // Validate input
    if (selectedCategory == null || selectedCategory!.isEmpty) {
      _showSnackBar('Please select a category', isError: true);
      return;
    }

    if (_authorController.text
        .trim()
        .isEmpty) {
      _showSnackBar('Please enter author name', isError: true);
      return;
    }

    if (_quotesController.text
        .trim()
        .isEmpty) {
      _showSnackBar('Please enter the quote', isError: true);
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      // Call the FireStore service to add quote
      bool success = await FireStoreService().addQuote(
        userId: widget.userId,
        categoryName: selectedCategory!,
        authorName: _authorController.text.trim(),
        quoteText: _quotesController.text.trim(),
      );

      if (success) {
        _showSnackBar('Quote added successfully!');
        Navigator.of(context).pushNamed(AuthRouteName.adminDashboardScreen);
      } else {
        _showSnackBar('Failed to add quote. Please try again.', isError: true);
      }
    } catch (e) {
      _showSnackBar('Error: ${e.toString()}', isError: true);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        duration: Duration(seconds: 3),
      ),
    );
  }

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
          'Add Quote',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        //automaticallyImplyLeading: false,
      ),

      body: Padding(
        padding: const EdgeInsets.all(25.0),

        child: Column(
          spacing: 20,
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Select Category',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 15),

                Container(
                  /*decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),*/
                  child: DropdownButtonFormField<String>(
                    value: selectedCategory,
                    hint: Text(
                      'Choose a category',
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.white,
                      size: 24,
                    ),
                    dropdownColor: Colors.grey[800],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                    ),
                    items: categories.map((Map<String, dynamic> category) {
                      return DropdownMenuItem<String>(
                        value: category['name'],
                        child: Text(
                          category['name'],
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedCategory = newValue;
                      });
                    },
                  ),
                ),

                SizedBox(height: 15),

                Text(
                  'Author Name',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 15),

                TextField(
                  controller: _authorController,
                  decoration: InputDecoration(
                    hintText: 'Author Name',
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  'Quote',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                SizedBox(height: 15),
                Container(
                  child:  TextField(
                    controller: _quotesController,
                    maxLines: 10,//increases the height
                  decoration: InputDecoration(
                    hintText: 'Write a Quote',
                  ),
                ),
                ),
              ],

            ),

            SizedBox(height: 100),
            SizedBox(
              height: 50,
              width: 500,
              child: FilledButton(
                onPressed: isLoading ? null: _saveQuote,
                style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.grey),
                ),
                child: Text(
                  'Save',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
            ),

          ],

        ),
      ),
    );
  }
}
