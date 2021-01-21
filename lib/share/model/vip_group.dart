class VipGroup {
  int id;
  String name;
  String description;
  String discount;
  bool isDeleted;
  String amount;
  String iconUrl;

  VipGroup(
      {this.id,
      this.name,
      this.description,
      this.discount,
      this.isDeleted,
      this.amount,
      this.iconUrl});

  VipGroup.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    description = json['Description'];
    discount = json['Discount'];
    isDeleted = json['IsDeleted'];
    amount = json['Amount'];
    iconUrl = json['IconUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Name'] = this.name;
    data['Description'] = this.description;
    data['Discount'] = this.discount;
    data['IsDeleted'] = this.isDeleted;
    data['Amount'] = this.amount;
    data['IconUrl'] = this.iconUrl;
    return data;
  }

  static List<VipGroup> listFromJson(List<dynamic> list) {
    List<VipGroup> rows = list.map((i) => VipGroup.fromJson(i)).toList();
    return rows;
  }
}
