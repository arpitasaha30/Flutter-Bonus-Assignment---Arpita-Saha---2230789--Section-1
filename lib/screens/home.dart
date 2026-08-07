import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:summer_iub_app/screens/coffe_records_screen.dart';
import 'package:summer_iub_app/screens/create_coffee_record_screen.dart';
import 'package:summer_iub_app/screens/firebase_coffee_records_screen.dart';
import 'package:summer_iub_app/state_management/coffee_state_management.dart';
import 'package:summer_iub_app/widgets/app_backgroud_design_widget.dart';

// ACM

class HomePage extends StatefulWidget {
  // Attribute
  final String pageTitle;

  // Constructor
  const HomePage({super.key, required this.pageTitle});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  int _coffeeCount = 0;

  void incrememntCoffeeCount() {
    _coffeeCount++;
    setState((){}); // For giving user some feedba
    print("Coffee Count: $_coffeeCount");
  }

  void navigateToCoffeeRecordsScreen() {
   Navigator.of(context)
   .push(MaterialPageRoute(builder: (context) =>  CoffeRecordsScreen()));
  }

   void navigateToCreateCoffeeRecordScreen() {
   Navigator.of(context)
   .push(MaterialPageRoute(builder: (context) =>  CreateCoffeeRecordScreen()));
  }

   void navigateToFirebaseCoffeeRecordsScreen() {
   Navigator.of(context)
   .push(MaterialPageRoute(builder: (context) =>  const FirebaseCoffeeRecordsScreen()));
  }

  // Opens the coffee records list as a popup that slides up from the
  // bottom of the screen (a "bottom sheet"), instead of navigating to a
  // whole new page.
  void showCoffeeRecordsPopup() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.3,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) {
            return Column(
              children: [
                // Little grey "drag handle" bar at the top of the sheet.
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const Text(
                  "Coffee Records",
                  style: TextStyle(
                    fontSize: 20.00,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown,
                  ),
                ),
                const SizedBox(height: 10.00),
                Expanded(
                  child: Consumer<CoffeeStateManagement>(
                    builder: (context, csm, _) {
                      if (csm.items.isEmpty) {
                        return const Center(
                          child: Text(
                            "No coffee records yet.",
                            style: TextStyle(color: Colors.brown),
                          ),
                        );
                      }
                      return ListView.builder(
                        controller: scrollController,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        itemCount: csm.items.length,
                        itemBuilder: (context, index) {
                          final coffeeRecord = csm.items[index];
                          return Card(
                            child: ListTile(
                              leading: const Icon(Icons.coffee, color: Colors.brown),
                              title: Text(coffeeRecord.title),
                              subtitle: Text(
                                  "${coffeeRecord.des} - Amount: ${coffeeRecord.amount}"),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }



  // Methods
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.pageTitle,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20.00,
          ),
        ),
        backgroundColor: Colors.brown,
      ),


      // * * * * -> Row

      // * 
      // * 
      // *
      // Column

      body: AppBackgroudDesignWidget(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.brown.shade600,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 10.00,
                  horizontal: 20.00,
                ),
                margin: EdgeInsets.symmetric(
                  horizontal: 25.00,
                ),
                child: Column(
                  children: [
                    Text(
                      "Welcome To Coffe House",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.00,
                        fontWeight: FontWeight.bold,
                      )
                    ),
      
                    // ---------------------------------------------------------
                    SizedBox(height: 10.00),
                    // ---------------------------------------------------------
      
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed:(){
                            navigateToCreateCoffeeRecordScreen();
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              horizontal: 50.00,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          icon: Icon(
                            Icons.shopping_cart,
                            color: Colors.brown,
                          ),
                          label: Text(
                            "Order Now",
                            style: TextStyle(
                              color: Colors.brown,
                              fontSize: 18.00,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
      
                        SizedBox(width: 10.00),
      
                        IconButton.filled(
                          onPressed: (){
                            navigateToCoffeeRecordsScreen();
                          },
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.brown,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 30.00,
                          ),
                        ),
                       
                        
                      ],
                    ),

                    // ---------------------------------------------------------
                    SizedBox(height: 10.00),
                    // ---------------------------------------------------------

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: (){
                          navigateToFirebaseCoffeeRecordsScreen();
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            horizontal: 50.00,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        icon: Icon(
                          Icons.wifi,
                          color: Colors.brown,
                        ),
                        label: Text(
                          "Check Firebase",
                          style: TextStyle(
                            color: Colors.brown,
                            fontSize: 18.00,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      
              SizedBox(height: 30.00),
      
      
              Text(
                  "How many coffee cups did you drink today?",
                  style: TextStyle(
                    color: Colors.brown,
                    fontSize: 18.00,
                  )
                ),
        
              Text(
                _coffeeCount.toString(),
                style: TextStyle(
                  color: Colors.brown,
                  fontSize: 36.00,
                  fontWeight: FontWeight.bold,
                )
              ),
            
            ],
          )
        ),

      floatingActionButton: GestureDetector(
        onLongPress: () {
          showCoffeeRecordsPopup();
        },
        child: FloatingActionButton(
          onPressed: () {
            incrememntCoffeeCount();
          },
          child: Icon(Icons.local_cafe),
        ),
      ),
    );
  }
}