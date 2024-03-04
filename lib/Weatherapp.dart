import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/weatherforecast.dart';

import 'additionalInfo.dart';
import 'package:http/http.dart' as http;

class Weatherapp extends StatefulWidget {
  const Weatherapp({super.key});

  @override
  State<Weatherapp> createState() => _WeatherappState();
}

class _WeatherappState extends State<Weatherapp> {
  Future getCurrentWeather() async {
    try {
      final res = await http.get(Uri.parse(
        'http://api.openweathermap.org/data/2.5/forecast?q=Gangtok&APPID=4c2bfacb166d477017eb4c666d6b6671',
      ));
      final data = jsonDecode(res.body);
      if (data['cod'] != '200') {
        throw 'something went wrong';
      } else {
        return data;
        // data['list'][0]['main']['temp'];
      }
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            foregroundColor: Colors.white,
            title: const Text(
              'Weather App',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      getCurrentWeather();
                    });
                  },
                  icon: Icon(Icons.refresh))
            ]),
        body:
            //  temp == 0 ? const CircularProgressIndicator()
            FutureBuilder(
          future: getCurrentWeather(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: const CircularProgressIndicator.adaptive());
            }
            if (snapshot.hasError) {
              return Text(snapshot.hasError.toString());
            }
            final data = snapshot.data;
            final currentTemp = data['list'][0]['main']['temp'];
            final currentSky = data['list'][0]['weather'][0]['main'];
            final pressure = data['list'][0]['main']['pressure'];
            final Humidity = data['list'][0]['main']['humidity'];
            final speed = data['list'][0]['wind']['speed'];
            return Padding(
              padding: const EdgeInsets.all(19.0),
              child: Column(children: [
                // main card

                SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: 13,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              Text('$currentTemp K',
                                  style: const TextStyle(
                                    fontSize: 38,
                                    fontWeight: FontWeight.bold,
                                  )),
                              Icon(
                                currentSky == 'Clouds' || currentSky == 'Rain'
                                    ? Icons.cloud
                                    : Icons.sunny,
                                size: 60,
                              ),
                              Text(
                                currentSky,
                                style: TextStyle(fontSize: 27),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 22,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Weather forecast',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // ROW for cards
                SizedBox(
                  height: 24,
                ),

                SizedBox(
                  height: 125,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      final hourly = data['list'][index + 1];
                      final time = DateTime.parse(hourly['dt_txt'].toString());
                      return forecasts(
                        icon: hourly['weather'][0]['main'] == 'Rain' ||
                                hourly['weather'][0]['main'] == 'Clouds'
                            ? Icons.cloud
                            : Icons.sunny,
                        time: DateFormat.j().format(time),
                        temp: hourly['main']['temp'].toString(),
                      );
                    },
                  ),
                ),
                SizedBox(height: 22),
                Align(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Additional informations',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                //add info box
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    adiitionalinfo(
                      icon: Icons.water_drop,
                      label: "Humidity",
                      value: '$Humidity',
                    ),
                    adiitionalinfo(
                      icon: Icons.air,
                      label: "Wind speed",
                      value: '$speed',
                    ),
                    adiitionalinfo(
                        icon: Icons.beach_access_sharp,
                        label: "Pressure",
                        value: '$pressure'),
                  ],
                )
              ]),
            );
          },
        ));
  }
}
