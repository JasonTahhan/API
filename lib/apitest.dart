import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Country and State Dropdowns'),
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
        ),
        
        body: CountryStateDropdowns(), 
      ),
    );
  }
}

class CountryStateDropdowns extends StatefulWidget {
  @override
  _CountryStateDropdownsState createState() => _CountryStateDropdownsState();
}

class _CountryStateDropdownsState extends State<CountryStateDropdowns> {
  String? selectedCountry;
  List<CountryModel> countries = [];
  List<StateModel> statesData = [];
  String? selectedState;
  bool isLoading = true;
  bool hasStates = false; 

  @override
  void initState() {
    super.initState();
    fetchCountries();
  }

  Future<void> fetchCountries() async {
    try {
      var response = await http.get(Uri.parse(
          'http://192.168.88.10:30513/otonomus/common/api/v1/countries?page=0&size=300'));

      var decodedResponse = jsonDecode(response.body);
      var result = decodedResponse['data'] as List;
      final finalResponse =
          result.map((map) => CountryModel.fromJson(map)).toList();
      setState(() {
        countries = finalResponse;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching countries: $e');
      
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> fetchStatesForCountry(String country) async {
    try {
      final response = await http.get(Uri.parse(
          'http://192.168.88.10:30513/otonomus/common/api/v1/country/$country/states'));
      dynamic decodedResponse = json.decode(response.body);

      if (decodedResponse is List) {
        List<String> stateList =
            decodedResponse.map((item) => item['stateName'].toString()).toList();
        setState(() {
          statesData = [];
          for (String stateName in stateList) {
            statesData.add(StateModel(stateName: stateName));
          }
        });
      } else if (decodedResponse is Map && decodedResponse.containsKey('data')) {
        final statesList = decodedResponse['data'] as List;
        List<StateModel> stateList =
            statesList.map((item) => StateModel.fromJson(item)).toList();
        setState(() {
          statesData = stateList;
        });
      } else {
        
        statesData.clear();
      }

      hasStates = statesData.isNotEmpty;
    } catch (e) {
      print('Error fetching states: $e');
      
      setState(() {
        hasStates = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DropdownButton<String>(
            value: selectedCountry,
            hint: Text('Select a country'),
            onChanged: (newValue) {
              setState(() {
                selectedCountry = newValue;
                selectedState = null;
                hasStates = false;

                if (selectedCountry != null) {
                  fetchStatesForCountry(selectedCountry!);
                }
              });
            },
            items: countries.map((country) {
              return DropdownMenuItem<String>(
                value: country.countryId,
                child: Text(country.countryName ?? ''),
              );
            }).toList(),
          ),
          SizedBox(height: 16),
          if (isLoading)
            CircularProgressIndicator() 
          else if (!hasStates && selectedCountry != null)
            Text(
              'No states available for the selected country.',
              style: TextStyle(color: Colors.red),
            ),
          if (hasStates && statesData.isNotEmpty && selectedCountry != null)
            DropdownButton<String>(
              value: selectedState,
              hint: Text('Select a state'),
              onChanged: (newValue) {
                setState(() {
                  selectedState = newValue;
                });
              },
              items: statesData.map((state) {
                return DropdownMenuItem<String>(
                  value: state.idState,
                  child: Text(state.stateName ?? ''),
                );
              }).toList(),
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              dropdownColor: Colors.white,
            ),
        ],
      ),
    );
  }
}

class CountryModel {
  final String? countryId;
  final String? countryName;
  final String? countryCode;
  final String? isoCode2;
  final String? isoCode3;

  CountryModel({
    this.countryId,
    this.countryName,
    this.countryCode,
    this.isoCode2,
    this.isoCode3,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
        countryId: json["idCountry"],
        countryName: json["countryName"],
        countryCode: json["countryCode"],
        isoCode2: json["isoCode2"],
        isoCode3: json["isoCode3"],
      );

  Map<String, dynamic> toJson() => {
        "idCountry": countryId,
        "countryName": countryName,
        "countryCode": countryCode,
        "isoCode2": isoCode2,
        "isoCode3": isoCode3,
      };

  @override
  String toString() {
    return 'CountryModel(idCountry: $countryId, countryName: $countryName, countryCode: $countryCode, isoCode2: $isoCode2, isoCode3: $isoCode3)';
  }
}

class StateModel {
  final String? idState;
  final String? stateName;
  final String? stateCode;
  final List<CityModel> cityVOList;

  StateModel({
    this.idState,
    this.stateName,
    this.stateCode,
    this.cityVOList = const [],
  });

  factory StateModel.fromJson(Map<String, dynamic> json) => StateModel(
        idState: json["idState"],
        stateName: json["stateName"],
        stateCode: json["stateCode"],
        cityVOList: List<CityModel>.from(
          json["cityVOList"].map((x) => CityModel.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
        "idState": idState,
        "stateName": stateName,
        "stateCode": stateCode,
        "cityVOList": List<dynamic>.from(cityVOList.map((x) => x.toJson())),
      };
  @override
  String toString() {
    return 'StateModel(idState: $idState, stateName: $stateName, stateCode: $stateCode, cityVOList: $cityVOList)';
  }
}

class CityModel {
  final String? idCity;
  final String? cityName;

  CityModel({this.idCity, this.cityName});

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
        idCity: json["idCity"],
        cityName: json["cityName"],
      );

  Map<String, dynamic> toJson() => {
        "idCity": idCity,
        "cityName": cityName,
      };

@override
  String toString() {
    return 'CityModel(idCity: $idCity, cityName: $cityName)';}}