// import 'dart:convert';

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
//   }}