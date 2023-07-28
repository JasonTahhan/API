
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class CountryStateDropdowns extends StatefulWidget {
 
//  _CountryStateDropdownsState createState() => _CountryStateDropdownsState();
 
//   @override
//   Widget build(BuildContext context) {
//     throw UnimplementedError();
//   }
// }
//  class _CountryStateDropdownsState extends State<CountryStateDropdowns> {
//   List<dynamic> countries = [];
//   List<dynamic> states = [];
//   String selectedCountry = '';
//   String selectedState = '';

//   @override
//   void initState() {
//     super.initState();
//     fetchCountries();
//   }

  
//   Future<void> fetchCountries() async {
//     try {
//       final response = await http.get(Uri.parse('http://192.168.88.10:30513/otonomus/common/api/v1/countries?page=0&size=300'));
//       if (response.statusCode == 200) {
//         setState(() {
//           countries = json.decode(response.body);
//         });
//       }
//     } catch (e) {
//       print('Error fetching countries: $e');
//     }
//   }

//   Future<void> fetchStates(String countryCode) async {
//     try {
//       final response = await http.get(Uri.parse('http://192.168.88.10:30513/otonomus/common/api/v1/country/%7BcountryId%7D/states/$countryCode'));
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         setState(() {
//           if (data['states'] != null) {
//             states = data['states'];
//             selectedState = '';
//           } else {
//             states = [];
//             selectedState = '';
//           }
//         });
//       }
//     } catch (e) {
//       print('Error fetching states: $e');
//     }
//   } 

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //         body: Center(
// //       child: Column(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         crossAxisAlignment: CrossAxisAlignment.center,
// //         children: [
// //           ElevatedButton(
// //             child: Text("get all"),
// //             onPressed: () async {
// //               var response = await http.get(Uri.parse("http://192.168.88.10:30513/otonomus/common/api/v1/countries?page=0&size=300"));
// //               var decodedResponse = jsonDecode(response.body);
// //               // print(decodedResponse);

// //               var result = decodedResponse as List;
// //               final finalResponse =
// //                   result.map((map) => CountryModule.fromJson(map)).toList();
// //               // print(finalResponse.length);
// //               for (int i = 0; i < finalResponse.length; i++) {
// //                 print(finalResponse[i].idcountry);
// //               }
// //               // return finalResponse;
// //             },
// //           ),
// //           SizedBox(
// //             height: 30,
// //           ),
// //           TextFormField(
// //             controller: textEditingController,
// //           ),
// //           SizedBox(
// //             height: 30,
// //           ),
// //           ElevatedButton(
// //             child: Text("get one"),
// //             onPressed: () async {
// //               await getPostById(textEditingController.text);
// //             },
// //           ),
// //         ],
// //       ),
// //     ));
// //   }

// //   getPostById(String postId) async {
// //     try {
// //       var response = await http
// //           .get(Uri.parse("https://jsonplaceholder.typicode.com/posts/$postId"));
// //       var decodedResponse = jsonDecode(response.body);
// //       if (response.statusCode != 200) {
// //         throw decodedResponse["message"];
// //       }

// //       var result = decodedResponse;
// //       final finalResponse = CountryModule.fromJson(result);

// //       print(finalResponse.toString());
// //     } catch (e) {
// //       print(e);
// //     }
// //   }
// // }

//  @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Country and State Dropdowns')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Select Country:'),
//             DropdownButton<String>(
//               value: selectedCountry,
//               onChanged: (String? newValue) {
//                 setState(() {
//                   selectedCountry = newValue!;
//                   fetchStates(newValue);
//                 });
//               },
//               items: countries.map<DropdownMenuItem<String>>((dynamic country) {
//                 return DropdownMenuItem<String>(
//                   value: country['alpha2Code'],
//                   child: Text(country['name']),
//                 );
//               }).toList(),
//             ),
//             SizedBox(height: 16),
//             Text('Select State:'),
//             DropdownButton<String>(
//               value: selectedState,
//               onChanged: (String? newValue) {
//                 setState(() {
//                   selectedState = newValue!;
//                 });
//               },
//               items: states.map<DropdownMenuItem<String>>((dynamic state) {
//                 return DropdownMenuItem<String>(
//                   value: state['name'],
//                   child: Text(state['name']),
//                 );
//               }).toList(),
//               disabledHint: Text('Select a country first'),
//               isDense: true,
//               disabledHintStyle: TextStyle(color: Colors.grey),
//             ),
//           ],
//         ),
//       ),
//     );
//   }}


// CountryStateDropdowns CountryModuleFromJson(String str) => CountryStateDropdowns.fromJson(json.decode(str));
// String CountryModuleToJson(CountryStateDropdowns data) => json.encode(data.toJson());

// class CountryModule {
//   String? idcountry;
//   String? countryName;
//   String? countryCode;
//   String? isoCode2;
//   String? isoCode3;

//   CountryModule({
//     this.idcountry,
//     this.countryName,
//     this.countryCode,
//     this.isoCode2,
//     this.isoCode3,

//   });

//   factory CountryModule.fromJson(Map<String, dynamic> json) => CountryModule(
//         idcountry: json["idcountry"],
//         countryName: json["countryName"],
//         countryCode: json["countryCode"],
//         isoCode2: json["isoCode2"],
//         isoCode3: json["isoCode3"],

//       );

//   Map<String, dynamic> toJson() => {
//         "idcountry": idcountry,
//         "countryName": countryName,
//         "countryCode": countryCode,
//         "isoCode2": isoCode2,
//         "isoCode3": isoCode3,
//       };

//   @override
//   String toString() {
//     return 'CountryModule(idcountry: $idcountry, countryName: $countryName, countryCode: $countryCode, isoCode2: $isoCode2, isoCode3: $isoCode3)';
//   }
// }
 