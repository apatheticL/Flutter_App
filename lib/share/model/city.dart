import 'District.dart';

class City {
  int id;
  String name;
  List<District> districts;


  City({this.id, this.name, this.districts});

  City.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    districts =
    json['v_district'] == null ? [] : District.listFromJson(json['v_district']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Name'] = this.name;
    return data;
  }

  static List<City> listFromJson(List<dynamic> list) {
    List<City> rows = list.map((i) => City.fromJson(i)).toList();
    return rows;
  }


  static City copyData(City city) {
    if (city == null) return null;
    return new City(
        id: city.id,
        name: city.name
    );
  }
}
