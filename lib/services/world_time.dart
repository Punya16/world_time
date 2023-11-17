import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{
  late String url;
  late String time;
  late String location;
  late String flag;
  late bool isDaytime;

  WorldTime({ required this.location ,required this.flag, required this.url });
  Future<void> getTime() async {
    try {
      Response response = await get(
          Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);

      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(0, 3);
      String offset1 = data['utc_offset'].substring(4, 6);

      DateTime now = DateTime.parse(datetime);
      now = now.add(
          Duration(hours: int.parse(offset), minutes: int.parse(offset1)));

      isDaytime = now.hour>6 && now.hour<18 ?true:false;
      time = DateFormat.jm().format(now);
    }


    catch (e) {
      time = 'Could not load time';
    }
  }
}

