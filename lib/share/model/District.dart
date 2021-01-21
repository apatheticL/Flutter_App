class District {
  int id;
  String name;
  District({this.id, this.name});

  District.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Name'] = this.name;
    return data;
  }

  static List<District> listFromJson(List<dynamic> list) {
    List<District> rows = list.map((i) => District.fromJson(i)).toList();
    return rows;
  }
  static District copyData(District district){
    if(district==null){
      return null;
    }
    return District(
        id: district.id,
        name: district.name
    );

  }

}
