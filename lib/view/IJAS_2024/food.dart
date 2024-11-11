import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:ijas/Core/AppBar.dart';
import 'package:ijas/Models/FoodModel.dart';
import 'package:ijas/Provider/IjasProvider.dart';
import 'package:ijas/view/IJAS_2024/IjasWidgets/FoodDetails.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FoodPage extends StatefulWidget {
  const FoodPage({super.key});

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<IjasProvider>(context, listen: false).getFood();
    });
  }

  @override
  Widget build(BuildContext context) {
    final ijasData = Provider.of<IjasProvider>(context, listen: true);
    final mq = MediaQuery.of(context).size;
    return Material(
      child: SafeArea(
        child: CupertinoPageScaffold(
          backgroundColor: CupertinoColors.systemGroupedBackground,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CutomAppBar(context, "IJAS 2024", () {
                Navigator.of(context).pop();
              }),
              const Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min, // Added line
                  children: <Widget>[
                    Center(
                        child: Text(
                      "Food",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              ijasData.isLoading
                  ? Expanded(
                      child: Center(
                        child: CupertinoActivityIndicator(
                          color: Colors.green,
                          radius: 40,
                        ),
                      ),
                    )
                  : Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(),
                        child: GroupedListView<FoodModel, String>(
                          padding: EdgeInsets.all(0),
                          shrinkWrap: true,
                          stickyHeaderBackgroundColor: Colors.transparent,
                          elements: ijasData.foodList,
                          groupBy: (element) {
                            return element.location;
                            //   // return DateFormat('d MMMM, yyyy').format(element.date!);
                          },
                          sort: false,
                          groupSeparatorBuilder: (String value) {
                            return Padding(
                              padding:
                                  EdgeInsets.only(top: 19, bottom: 8, left: 10),
                              child: Text(
                                value,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          },
                          itemBuilder: (context, foodData) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return FoodDetail(food: foodData);
                                }));
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border(
                                    bottom: BorderSide(
                                      width: 1.5,
                                      color: Colors.grey.shade100,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: mq.width * 0.4,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${foodData.name}",
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                          Text(
                                            "${foodData.location}",
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Container(
                                            width: mq.width * 0.35,
                                            child: Text(
                                              "${foodData.description}",
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                          Icon(
                                            Icons.chevron_right,
                                            color: Colors.grey,
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}

String formatDate(String inputDate) {
  DateTime dateTime =
      DateTime.parse(inputDate).toLocal(); // Convert to local time
  final formatter = DateFormat('EEEE, MMMM dd yyyy');
  return formatter.format(dateTime);
}
