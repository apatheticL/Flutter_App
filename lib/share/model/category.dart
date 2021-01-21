class Category {
  String odataId;
  String odataEditLink;
  int id;
  String description;
  String name;
  int no;
  bool visible;
  bool visibleOnMainMenu;
  bool visibleOnHomePage;
  bool isDeleted;

  Category(
      {this.odataId,
        this.odataEditLink,
        this.id,
        this.description,
        this.name,
        this.no,
        this.visible,
        this.visibleOnMainMenu,
        this.visibleOnHomePage,
        this.isDeleted});

  Category.fromJson(Map<String, dynamic> json) {
    odataId = json['@odata.id'];
    odataEditLink = json['@odata.editLink'];
    id = json['Id'];
    description = json['Description'];
    name = json['Name'];
    no = json['No'];
    visible = json['Visible'];
    visibleOnMainMenu = json['VisibleOnMainMenu'];
    visibleOnHomePage = json['VisibleOnHomePage'];
    isDeleted = json['IsDeleted'];
  }


  static List<Category> listFromJson(List<dynamic> list) {
    List<Category> rows = list.map((i) => Category.fromJson(i)).toList();
    return rows;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['@odata.id'] = this.odataId;
    data['@odata.editLink'] = this.odataEditLink;
    data['Id'] = this.id;
    data['Description'] = this.description;
    data['Name'] = this.name;
    data['No'] = this.no;
    data['Visible'] = this.visible;
    data['VisibleOnMainMenu'] = this.visibleOnMainMenu;
    data['VisibleOnHomePage'] = this.visibleOnHomePage;
    data['IsDeleted'] = this.isDeleted;
    return data;
  }
}