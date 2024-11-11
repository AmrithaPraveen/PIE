import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ijas/Core/AppBar.dart';
import 'package:ijas/Models/FoodModel.dart';

class FoodDetail extends StatelessWidget {
  FoodModel food;

  FoodDetail({required this.food, super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: CupertinoPageScaffold(
          child: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CutomAppBar(context, "IJAS 2024", () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                }),
                CutomAppBar(context, "Food", () {
                  Navigator.of(context).pop();
                }),
                SizedBox(
                  height: 15,
                ),
                Text("Food Detail",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                SizedBox(
                  height: 10,
                ),
                // Text("Date : ${schedule.date}",
                //     style:
                //         TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                // SizedBox(
                //   height: 10,
                // ),
                Text("Name : ${food.name}",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Description : ${food.description}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Location : ${food.location}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Menu : ${food.menu}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
