import '1.dart';

List<money> geter(){
  money upwork = money();
  upwork.name="upwork";
  upwork.fee="650";
  upwork.time="today";
  upwork.image="upwork.png";
  upwork.buy=false;
  money starbucks = money();
  starbucks.name="starbucks";
  starbucks.fee="15";
  starbucks.time="today";
  starbucks.image="starbucks.png";
  starbucks.buy=true;
  money transfer = money();
  transfer.name="creditcard";
  transfer.fee="100";
  transfer.time="jan 30,2022";
  transfer.image="creditcard.png";
  transfer.buy=true;
return[upwork,starbucks,transfer,upwork,starbucks,transfer,upwork,starbucks,transfer];
}