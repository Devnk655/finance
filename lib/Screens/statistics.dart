import 'package:finance/Widgets/charts.dart';
import 'package:finance/data/top.dart';
import 'package:finance/model/add_date_data.dart';
import 'package:finance/model/utility.dart';
import 'package:flutter/material.dart';

class Statistics extends StatefulWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  List day =["Day","Week","Month","Year"];
  List f =[today(),week(),month(),year()];
  List<Add_data> a =[];
  int index_color=0;
  ValueNotifier kj =  ValueNotifier(0);
  @override
  void initState() {
    super.initState();
    index_color = 0;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable:kj ,
          builder: (context,dynamic value,child){
            a=f[value];
            return custom();
          },
        ),
      ),
    );
  }

  CustomScrollView custom() {
    return CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
                // height:350,
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    Text("Statistics",style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    ),
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal:15 ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //multiple form of list or something to  create
                          ...List.generate(2, (index) {
                            return GestureDetector(
                              onTap: (){
                                setState(() {
                                  index_color=index;
                                  kj.value=index;
                                });
                              },
                              child: Container(
                                height: 40,width: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  //onclick then only color is been showin in the app
                                  color:index_color==index? Color.fromARGB(255, 47, 125, 121):Colors.white,
                                ),
                                alignment: Alignment.center,
                                child: Text(day[index],style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  //here text color is been seen properly
                                  color: index_color==index? Colors.white:Colors.black,
                                  fontSize: 16,
                                ),
                                ),
                              ),
                            );
                          },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 3,
                                ),
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              //onclick then only color is been showin in the app
                            ),
                            width: 120,
                            height: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                            children: [
                              Text("Expense",style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color:Colors.grey,
                              ),
                              ),
                              Icon(Icons.arrow_downward_sharp,color: Colors.grey),
                            ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    SizedBox(height:300,child: Chart()),
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.only(left:15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Top Spending",style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color:Colors.black,
                          ),
                          ),
                          Icon(Icons.swap_vert,size: 25,color:Colors.grey),

                        ],
                      ),
                    )
                  ],
                ),
            ),
          ),
          SliverList(delegate: SliverChildBuilderDelegate((context,index){
            if(index<a.length) {
              return ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.asset(
                    "images/creditcard.png", height: 50, width: 50,),
                ),
                title: Text(
                  a[index].name,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  '${day[a[index].dateTime.weekday-1]} ${a[index].dateTime.year}-${a[index].dateTime.day}-${a[index].dateTime.month}',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                trailing: Text(
                  a[index].amount,
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                    color: a[index].IN == "Income" ? Colors.green : Colors.red,
                  ),
                ),
              );
            }
            else{
              return null;
            }

          },
            childCount: a.length,
          ))
        ],
      );
  }
}
