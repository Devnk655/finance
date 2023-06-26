import 'package:finance/data/1.dart';

List<money> geter_top() {
  money snap_food = money();
  snap_food.time = "jan 30,2022";
  snap_food.image = "freelance-work.png";
  snap_food.buy = true;
  snap_food.fee = "\$-100";
  snap_food.name = "Snap food";
  money snap = money();
  snap.image = "fiverr.png";
  snap.time = "today";
  snap.buy = true;
  snap.fee = "\$-60";
  snap.name = "Fiver";
  return [snap_food, snap];
}
