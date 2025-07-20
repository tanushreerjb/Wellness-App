import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

import 'core/route/route_name.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  bool isChecked = false;
  String selectedType = 'Quotes';

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
          'Add Category',
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
                Text(
                  'Choose image for category:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 15),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Category Name',
                  ),
                ),
              ],
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Choose image for category:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 15),

                Row(
                  spacing: 20,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedType = 'Quotes';
                          });
                        },

                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 16,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[800],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                                child: selectedType == 'Quotes'
                                    ? Center(
                                        child: Container(
                                          width: 12,
                                          height: 12,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    : null,
                              ),
                              SizedBox(width: 16),
                              Text(
                                'Quotes',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedType = 'Health';
                          });
                        },

                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 16,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[800],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                                child: selectedType == 'Health'
                                    ? Center(
                                        child: Container(
                                          width: 12,
                                          height: 12,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    : null,
                              ),
                              SizedBox(width: 16),
                              Text(
                                'Health',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Choose image for category:',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 15),

                    GestureDetector(
                      onTap: () {
                        // Handle image selection
                        print('Image selection tapped');
                      },
                      child: DottedBorder(
                        color: Colors.grey[600]!,
                        strokeWidth: 2,
                        dashPattern: [8, 4],
                        // [dash length, gap length]
                        borderType: BorderType.RRect,
                        radius: Radius.circular(12),
                        child: Container(
                          width: double.infinity,
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 60,
                                height: 60,

                                child: Icon(Icons.image, size: 50),
                              ),
                              SizedBox(height: 15),
                              Text('Tap to choose image'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
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
          ], //Main Children
        ),
      ),
    );
  }
}
