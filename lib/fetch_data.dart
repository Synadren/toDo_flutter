import 'dart:async';
import 'package:dio/dio.dart';

class FetchData {
  final String route;
  final Map params;

  Response response;
  List<dynamic> data;
  
  Dio dio = new Dio(new BaseOptions(
    baseUrl: 'https://jsonplaceholder.typicode.com/'
  ));

  FetchData(this.route, this.params);

  Future getData() async {
    try {
      response = await dio.get(route);
      data = response.data;

    } catch (e) {
      print('Error with GET: $e}');
    }
  }
}
