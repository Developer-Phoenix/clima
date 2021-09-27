import 'package:http/http.dart';
import 'dart:convert';
const apikey= '7a675b3c4a5c27de0c94eccd0664c5df';

class NetworkHelper{
  NetworkHelper(this.urli);
  final String urli;

  Future getData () async{
    var url =  Uri.parse(urli);
    Response response = await get(url);

    if (response.statusCode==200){
      String data =response.body;
      var decodeddata = jsonDecode(data);
      return decodeddata;
    }
    else{
      print(response.statusCode);
    }

  }
}