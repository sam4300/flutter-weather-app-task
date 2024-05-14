import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_task/bloc/weather_bloc.dart';
import 'package:weather_app_task/constants/global_variables.dart';
import 'package:weather_app_task/presentation/screens/splash_screen.dart';
import 'package:weather_app_task/presentation/widgets/weather_card.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  TextEditingController locationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() {
    context.read<WeatherBloc>().add(
          WeatherDataFetch(),
        );
  }

  @override
  void dispose() {
    locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Weather App",
          style: TextStyle(
            color: AppConstants.appColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const SplashScreen(),
                ),
                (route) => false,
              );
            },
            icon: const Icon(Icons.help),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 45,
                  width: size.width * 0.60,
                  child: TextField(
                    controller: locationController,
                    onChanged: (val) {
                      setState(() {});
                    },
                    style: const TextStyle(
                      color: AppConstants.appColor,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(8),
                      hintText: 'Enter location',
                      hintStyle: TextStyle(
                        color: AppConstants.appColor,
                        fontSize: 14,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: AppConstants.appColor),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      side: const BorderSide(color: AppConstants.appColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      AppConstants.query = locationController.text;
                      fetchData();
                    },
                    child: Text(
                      locationController.text == '' ? 'Save' : 'Update',
                      style: const TextStyle(
                          color: AppConstants.appColor, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
              if (state is WeatherFailure) {
                return Text(
                  state.message,
                  style: const TextStyle(
                      color: AppConstants.appColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                );
              }
              if (state is! WeatherSuccess) {
                return const CircularProgressIndicator(
                  color: AppConstants.appColor,
                );
              }
              return WeatherCard(weatherData: state.weatherData);
            }),
          ],
        ),
      ),
    );
  }
}
