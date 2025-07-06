import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        spacing: 24,
        //crossAxisAlignment: CrossAxisAlignment.center,
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            child:
            Row(
              children: [
                SizedBox(width: 35,),
                Text(
                  "Explore",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 180.0,
                child: FilledButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.white30),
                  ),
                  onPressed: () {},
                  child: Text(
                    'My Favorites',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),

              /*const SizedBox(width: 50),*/
              SizedBox(
                width: 180.0,
                child: FilledButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.white30),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Remind Me',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),

          Row(
            children: [
              SizedBox(width: 35,),
              Text(
                "Today's Quote",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  color: Colors.white,
                ),
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 370.0,
                height: 80.0,
                child: FilledButton(
                  style: FilledButton.styleFrom(backgroundColor: (Colors.white30)),

                  onPressed: (){},
                  child: Text(
                    '"Your wellness is an investment, not an expense" - Author Name',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),

          Row(
            children: [
              SizedBox(width: 35,),
              Text(
                "Quotes",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  color: Colors.white,
                ),
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 350.0,
                height: 60.0,
                child: FilledButton.icon(
                  style: FilledButton.styleFrom(alignment: Alignment.centerLeft,
                    backgroundColor: (Colors.white30),
                  ),
                  onPressed: () {},
                  icon: Icon(Icons.sunny, size: 20, color: Colors.white,),
                  label: Text('Feeling Blessed',
                    style: TextStyle(color: Colors.white),),
                ),
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 350.0,
                height: 60.0,
                child: FilledButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.paid_rounded, size: 20, color: Colors.white,),
                  style: FilledButton.styleFrom(alignment: Alignment.centerLeft,
                    backgroundColor: (Colors.white30),
                  ),
                  label: Text('Pride Month',
                    style: TextStyle(color: Colors.white),),
                ),
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 350.0,
                height: 60.0,
                child: FilledButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.star_border, size: 20, color: Colors.white,),
                  style: FilledButton.styleFrom(alignment: Alignment.centerLeft,
                    backgroundColor: (Colors.white30),
                  ),
                  label: Text('Self Worth',
                    style: TextStyle(color: Colors.white),),
                ),
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 350.0,
                height: 60.0,
                child: FilledButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.ac_unit_rounded, size: 20, color: Colors.white,),
                  style: FilledButton.styleFrom(alignment: Alignment.centerLeft,
                    backgroundColor: (Colors.white30),
                  ),
                  label: Text('Love',
                    style: TextStyle(color: Colors.white),),
                ),
              ),
            ],
          ),

          Row(
            children:[
              SizedBox(width: 35,),
              Text(
                "Health Tips",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  color: Colors.white,
                ),
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 350.0,
                height: 70.0,
                child: FilledButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.sunny, size: 20, color: Colors.white,),
                  style: FilledButton.styleFrom(alignment: Alignment.centerLeft,
                    backgroundColor: (Colors.white30),
                  ),
                  label: Text('Breathe to Reset',
                    style: TextStyle(color: Colors.white),),
                ),
              ),
            ],
          ),
        ], //Children
      ),
    );
  }
}
