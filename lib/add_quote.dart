import 'package:flutter/material.dart';

import 'core/route/route_name.dart';

class AddQuote extends StatefulWidget {
  const AddQuote({super.key});

  @override
  State<AddQuote> createState() => _AddQuoteState();
}

class _AddQuoteState extends State<AddQuote> {
  bool isChecked = false;
  String? selectedCategory;

  final List<String> categories = [
    'Quotes',
    'Motivational',
    'Inspirational',
    'Life',
    'Success',
    'Wisdom',
  ];

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
                    items: categories.map((String category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(
                          category,
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
                onPressed: () {
                  Navigator.of(context).pushNamed(AuthRouteName.adminDashboardScreen);
                },
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
