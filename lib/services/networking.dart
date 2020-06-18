import 'package:http/http.dart';
import 'dart:convert';

class NetworkHelper{
  NetworkHelper(this.url);

  final String url;

  Future<void> getData()async{
    Response resp = await get(url);
    //var result = resp.body;
    if(resp.statusCode==200)
    {
      String data = resp.body;
//      var temp = jsonDecode(data)['name']; //name
//      print(temp);
      return data;

      //main.temp_min

    }
    else
      print(resp.statusCode);

  }

}