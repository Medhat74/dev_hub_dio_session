import 'package:dio/dio.dart';

class DioHelper{


  static Dio? dio;


  static init()
  {
    dio=Dio(BaseOptions(
      baseUrl: 'https://api.escuelajs.co/api/v1/'
    ),);
  }


  static Future<Response>  get(String endpoint)
  async{
    return await dio!.get(endpoint);
  }


  static Future<Response> post(String endpoint, Map <String, dynamic> body,String? token )
  async{

    dio!.options.headers={
      'Content-Type':'application/json',
      'Authorization':'Bearer $token '
    };
    return await dio!.post(endpoint,data: body,


    );
  }


}