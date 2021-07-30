import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CurrentWeather extends StatelessWidget {
  final String city;

  CurrentWeather(this.city);

  Future<String> getData() async {
    var endpointUrl = 'http://api.openweathermap.org/data/2.5/weather';
    Map<String, String> queryParams = {
      'q': city,
      'appid': '66d34f5aafa811b05051b1ec23d0b151'
    };
    String queryString = Uri(queryParameters: queryParams).query;

    var requestUrl = endpointUrl + '?' + queryString;
    var response = await http.get(Uri.parse(requestUrl));

    Map<String, dynamic> responseJson = jsonDecode(response.body.toString());

    final temp = responseJson['main']['temp'] - 273;

    final string = responseJson['name'].toString() +
        ',' +
        responseJson['weather'][0]['main'].toString() +
        ',' +
        responseJson['weather'][0]['description'].toString() +
        ',' +
        temp.toStringAsFixed(1) +
        ' C';
    return string;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            final str = snapshot.data.toString();
            final list = str.split(',');
            if (str != 'null') {
              return Column(
                children: list.map((info) {
                  return Text(info);
                }).toList(),
              );
            } else
              return Text(
                'No info about this city',
                textAlign: TextAlign.center,
              );
          }),
    );
  }
}
