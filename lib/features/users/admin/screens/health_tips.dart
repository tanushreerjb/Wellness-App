import 'package:flutter/material.dart';

import '../../../../core/route/route_name.dart';
//import 'package:wellness_app/core/route/route_name.dart';

class HealthTips extends StatefulWidget {
  const HealthTips({super.key});

  @override
  State<HealthTips> createState() => _HealthTipsState();
}

class _HealthTipsState extends State<HealthTips> {
  String? selectedCategory;

  final List<String> categories = [
    'Health',
    'Fitness',
    'Motivation',
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
          'Add Health Tips',
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
          mainAxisAlignment: MainAxisAlignment.start,

          children: [
            Column(
              spacing: 15,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Select Category',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),

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


                Text('Health Tips',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                Container(
                  child:  TextField(
                    maxLines: 10,//increases the height
                    decoration: InputDecoration(
                      hintText: 'Write a health tip',
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 250),
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
