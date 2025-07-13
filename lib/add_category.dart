import 'package:flutter/material.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  bool isChecked = false;

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
      body: Column(
        children: [
          SizedBox(
            child: Text('Category Name'),
          ),

          SizedBox(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Category Name',
                prefixIcon: Icon(
                  Icons.password_outlined,
                  size: 24.0,
                  color: Colors.white70,
                ),
              ),
            ),
          )


        ],
      ),
    );
}
}



