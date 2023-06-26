import 'package:finance/data/listdata.dart';
import 'package:finance/model/add_date_data.dart';
import 'package:finance/model/utility.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var history;
  final box =  Hive.box<Add_data>("data");
  List<String> day = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: SafeArea(
       //this will help hivedatabase to bee add data quickly into the app
       child:ValueListenableBuilder(
           valueListenable:box.listenable(),
         builder:(context,value,child) {
           return CustomScrollView(
             slivers: [
               SliverToBoxAdapter(
                 child: SizedBox(height:350,child: _head()),
               ),
               SliverToBoxAdapter(
                   child: Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Text("Transactions History",style: TextStyle(
                           fontWeight: FontWeight.w500,
                           fontSize: 19,
                           color:Colors.black,
                         ),
                         ),
                         Text("See All",style: TextStyle(
                           fontWeight: FontWeight.w500,
                           fontSize: 15,
                           color:Colors.grey,
                         ),
                         ),
                       ],
                     ),
                   )
               ),
               SliverList
                 (delegate:
               SliverChildBuilderDelegate((
                   context,index
                   ){
                 history = box.values.toList()[index];
                 return getList(history,index);
               },
                 childCount:box.length,
               ),)
             ],
           );
         },
       )
     ),
    );
  }
  Widget getList(Add_data history, int index){
    return Dismissible(key: UniqueKey(),
        onDismissed: (direction){
      history.delete();
        },
       child:get(index, history) );
  }
  ListTile get(int index,Add_data history){
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Image.asset("images/${geter()[index].image!}",height: 50,width: 50,),
      ),
      title: Text(
        history.name,
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle:Text(
        '${day[history.dateTime.weekday-1]} ${history.dateTime.year}-${history.dateTime.day}-${history.dateTime.month}',
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: Text(
        history.amount,
        style: TextStyle(
          fontSize: 19,
          fontWeight: FontWeight.w600,
          color:history.IN=="Income"?Colors.green:Colors.red,
        ),
      ),
    );
  }
  Widget _head(){
    return Stack(
      children: [
        Column(
          children: [
            Container(
              width: double.infinity,
              height: 240,
              decoration: BoxDecoration(
                color:Color(0xff368983),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 35,
                    left: 340,
                    child:
                    ClipRRect(
                      borderRadius:BorderRadius.circular(7) ,
                      child: Container(
                        height: 40,
                        width: 40,
                        color: Color.fromRGBO(250, 250, 250, 0.1),
                        child: Icon(Icons.notification_add_outlined,size: 30,
                          color: Colors.white,),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:35,left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Good afternoon",
                          style:
                          TextStyle(fontSize:16,fontWeight: FontWeight.w500,
                              color: Colors.white),),
                        Text("Deven Khengar",
                          style:
                          TextStyle(fontSize:20 ,fontWeight: FontWeight.w500,
                              color: Colors.white),),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 160,
          left: 37,
          child: Container(
            height: 170,
            width: 320,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(47, 125, 121, 0.3),
                  offset: Offset(0,6),
                  blurRadius: 12,
                  spreadRadius: 6,
                )
              ],
              color:Color.fromARGB(255, 47, 125, 121),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                SizedBox(height: 10,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total Balance",style:
                      TextStyle(fontSize:16,fontWeight: FontWeight.w500,
                          color: Colors.white),
                      ),
                      Icon(Icons.more_horiz,color:Colors.white)
                    ],
                  ),
                ),
                SizedBox(height: 7,),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Row(
                    children: [
                      Text("\$${total()}",style:
                      TextStyle(fontSize:25,fontWeight: FontWeight.bold,
                          color: Colors.white))
                    ],
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 13,
                            backgroundColor: Color.fromARGB(255, 85, 145, 141),
                            child: Icon(Icons.arrow_downward,color: Colors.white,
                                size:19),
                          ),
                          SizedBox(
                            width:7 ,
                          ),
                          Text("Income",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 16),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 13,
                            backgroundColor: Color.fromARGB(255, 85, 145, 141),
                            child: Icon(Icons.arrow_upward,color: Colors.white,
                                size:19),
                          ),
                          SizedBox(
                            width:7 ,
                          ),
                          Text("Expenses",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 6,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("\$${income()}", style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: 16),),
                      Text("\$${expenses()}", style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: 16),),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
