class Author {
  int id;
  String name;
  bool isFamous;
  bool visible;
  bool isDeleted;

  Author({this.id, this.name, this.isFamous, this.visible, this.isDeleted});

  Author.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    isFamous = json['IsFamous'];
    visible = json['Visible'];
    isDeleted = json['IsDeleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Name'] = this.name;
    data['IsFamous'] = this.isFamous;
    data['Visible'] = this.visible;
    data['IsDeleted'] = this.isDeleted;
    return data;
  }

  static List<Author> listFromJson(List<dynamic> list) {
    List<Author> rows = list.map((i) => Author.fromJson(i)).toList();
    return rows;
  }
}
