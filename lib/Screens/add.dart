import 'package:finance/model/add_date_data.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final box = Hive.box<Add_data>("data");
  //DateTime to use time and dat stamp in flutter
  DateTime date = DateTime.now();
  String? selectedItem;
  String? selectedItem1;
  final TextEditingController explain_C = TextEditingController();
  FocusNode ex = FocusNode();
  final TextEditingController amount_c = TextEditingController();
  FocusNode amount = FocusNode();
  final List<String> _item = [
    "Food",
    "Transfer",
    "Transportation",
    "Education"
  ];
  final List<String> _item1 =[
    "Income",
    "Expand",
  ];
void initState(){
  super.initState();
  ex.addListener(() {
    setState(() {
    });
  });
  amount.addListener(() {
    setState(() {
    });
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            backgroundContainer(context),
            Positioned(
              top: 120,
              child: mainContainer(),
            ),
          ],
        ),
      ),
    );
  }

  Container mainContainer() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      height: 550,
      width: 340,
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          name(),
          SizedBox(height: 30),
         explain(),
          SizedBox(height: 30),
         Amount(),
          SizedBox(height: 30),
          How(),
          SizedBox(height: 30,),
          date_time(),
          SizedBox(height: 20,),
          save(),

        ],
      ),
    );
  }
  GestureDetector save(){
  return  GestureDetector(
    onTap: (){
      var add = Add_data(selectedItem1!,amount_c.text,date,explain_C.text,selectedItem!);
      box.add(add);
      Navigator.pop(context);
    },
    child: Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color:Color(0xff368983)
      ),
      width: 120,
      height: 50,
      child: Text("Save",
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize:17,
            color: Colors.white
        ),),
    ),
  );
  }
  Widget date_time()  {
  return Container(
    alignment: Alignment.bottomLeft,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      border: Border.all(width: 2,color:Color(0xffC5C5C5)),
    ),
    width: 300,
    child: TextButton(onPressed: ()async{
      //using of datetime that is been used here
      DateTime?newDate = await showDatePicker(context: context, initialDate: date, firstDate:DateTime(2020), lastDate:DateTime(2100));
      if(newDate==Null) return;
      setState(() {
        date=newDate!;
      });
    }, child: Text("Date : ${date.year}/${date.day}/${date.month}",
      style:TextStyle(
        fontSize: 15,
        color:Colors.black,
      ) ,),),
  );
  }
  Padding Amount(){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    child: TextField(
      keyboardType:TextInputType.number ,
      focusNode: amount,
      controller:amount_c ,
      decoration: InputDecoration(contentPadding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
          labelText: "amount",
          labelStyle: TextStyle(fontSize: 17,color: Colors.grey.shade500),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width:2,color: Colors.grey ),
          )
      ),
    ),
  );
  }
Padding How(){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 2,
          color: Color(0xffC5C5C5),
        ),
      ),
      child: DropdownButton<String>(
        value: selectedItem1,
        hint: Text(
          'How',
          style: TextStyle(color: Colors.grey),
        ),
        isExpanded: true, // Expand the dropdown menu
        onChanged: (value) {
          setState(() {
            selectedItem1 = value;
          });
        },
        items: _item1.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(value),
                Icon(Icons.arrow_drop_down), // Add an icon at the end
              ],
            ),
          );
        }).toList(),
      ),
    ),
  );
}


  Padding explain(){
  return  Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    child: TextField(
      focusNode: ex,
      controller:explain_C ,
      decoration: InputDecoration(contentPadding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
          labelText: "explain",
          labelStyle: TextStyle(fontSize: 17,color: Colors.grey.shade500),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width:2,color: Colors.grey ),
          )
      ),
    ),
  );
  }

  Padding name() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 2,
            color: Color(0xffC5C5C5),
          ),
        ),
        child: DropdownButton<String>(
          value: selectedItem,
          hint: Text(
            'Select an item',
            style: TextStyle(color: Colors.grey),
          ),
          isExpanded: true, // Expand the dropdown menu
          onChanged: (value) {
            setState(() {
              selectedItem = value;
            });
          },
          items: _item.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(value),
                  Icon(Icons.arrow_drop_down), // Add an icon at the end
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Column backgroundContainer(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 240,
          decoration: BoxDecoration(
            color: Color(0xff368983),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    Text(
                      "Adding",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    Icon(
                      Icons.attach_file_outlined,
                      color: Colors.white,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
