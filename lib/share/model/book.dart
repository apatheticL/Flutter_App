import 'package:flutter/material.dart';

import 'author.dart';
import 'category.dart';

class Book {
  int id;
  String description;
  String name;
  String code;
  double unitPrice;
  int quantity;
  String thumbnail;
  int totalSold;
  String publisher;
  String publicationDate;
  String editionDate;
  bool isNew;
  bool isHotSale;
  bool isComingSoon;
  bool isCombo;
  bool visible;
  int totalPages;
  String weight;
  String width;
  String height;
  String length;
  String imgUrl1;
  String imgUrl2;
  String imgUrl3;
  String imgUrl4;
  String imgUrl5;
  String previewDemoUrl;

  bool isDeleted;
  bool isFamous;
  int curUserId;
  List<String> imgUrls;
  List<Category> categories;
  List<Author> authors;
  String authorsText;
  List<VipGroupDiscounts> vipGroupDiscounts;
  String keyTag;

  Book(
      {this.id,
        this.description,
        this.name,
        this.code,
        this.unitPrice,
        this.quantity,
        this.thumbnail,
        this.totalSold,
        this.publisher,
        this.publicationDate,
        this.isNew,
        this.isHotSale,
        this.isComingSoon,
        this.isCombo,
        this.visible,
        this.totalPages,
        this.weight,
        this.width,
        this.height,
        this.length,
        this.imgUrl1,
        this.imgUrl2,
        this.imgUrl3,
        this.imgUrl4,
        this.imgUrl5,
        this.previewDemoUrl,
        this.isDeleted,
        this.isFamous,
        this.curUserId,
        this.imgUrls,
        this.editionDate,
        this.categories,
        this.authors,
        this.vipGroupDiscounts});

  Book.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    description = json['Description'];
    name = json['Name'];
    code = json['Code'];
    unitPrice = double.parse(json['UnitPrice'].toString());
    quantity = json['Quantity'];
    thumbnail = json['Thumbnail'];
    totalSold = json['TotalSold'];
    publisher = json['Publisher'];
    publicationDate = json['PublicationDate'];
    isNew = json['IsNew'] ?? false;
    isHotSale = json['IsHotSale'] ?? false;
    isComingSoon = json['IsComingSoon'] ?? false;
    isCombo = json['IsCombo'] ?? false;
    visible = json['Visible'];
    totalPages = json['TotalPages'];
    weight = json['Weight'];
    width = json['Width'];
    height = json['Height'];
    length = json['Length'];
    imgUrl1 = json['ImgUrl1'];
    imgUrl2 = json['ImgUrl2'];
    imgUrl3 = json['ImgUrl3'];
    imgUrl4 = json['ImgUrl4'];
    imgUrl5 = json['ImgUrl5'];
    previewDemoUrl = json['PreviewDemoUrl'];
    isDeleted = json['IsDeleted'];
    isFamous = json['IsFamous'];
    editionDate = json['EditionDate'];
    curUserId = json['CurUserId'];
    imgUrls = json['ImgUrls']?.cast<String>();
    categories = new List<Category>();
    if (json['Categories'] != null) {
      json['Categories'].forEach((v) {
        categories.add(new Category.fromJson(v));
      });
    }
    authors = new List<Author>();
    authorsText = '';
    if (json['Authors'] != null) {
      json['Authors'].forEach((v) {
        var author = new Author.fromJson(v);
        authors.add(author);
        authorsText += author.name + ", ";
      });
      if (authorsText.length > 2)
        authorsText = authorsText.substring(0, authorsText.length - 2);
    }
    vipGroupDiscounts = new List<VipGroupDiscounts>();
    if (json['VipGroupDiscounts'] != null) {
      json['VipGroupDiscounts'].forEach((v) {
        vipGroupDiscounts.add(new VipGroupDiscounts.fromJson(v));
      });
    }
    if (imgUrls == null || imgUrls.length == 0) {
      imgUrls = new List<String>();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Description'] = this.description;
    data['Name'] = this.name;
    data['Code'] = this.code;
    data['UnitPrice'] = this.unitPrice;
    data['Quantity'] = this.quantity;
    data['Thumbnail'] = this.thumbnail;
    data['TotalSold'] = this.totalSold;
    data['Publisher'] = this.publisher;
    data['PublicationDate'] = this.publicationDate;
    data['IsNew'] = this.isNew;
    data['IsHotSale'] = this.isHotSale;
    data['IsComingSoon'] = this.isComingSoon;
    data['IsCombo'] = this.isCombo;
    data['Visible'] = this.visible;
    data['TotalPages'] = this.totalPages;
    data['Weight'] = this.weight;
    data['Width'] = this.width;
    data['Height'] = this.height;
    data['Length'] = this.length;
    data['ImgUrl1'] = this.imgUrl1;
    data['PreviewDemoUrl '] = this.previewDemoUrl;
    data['IsDeleted'] = this.isDeleted;
    data['IsFamous'] = this.isFamous;
    data['CurUserId'] = this.curUserId;
    data['ImgUrls'] = this.imgUrls;
    data['EditionDate'] = this.editionDate;

    if (this.categories != null) {
      data['Categories'] = this.categories.map((v) => v.toJson()).toList();
    }
    if (this.authors != null) {
      data['Authors'] = this.authors.map((v) => v.toJson()).toList();
    }
    if (this.vipGroupDiscounts != null) {
      data['VipGroupDiscounts'] =
          this.vipGroupDiscounts.map((v) => v.toJson()).toList();
    }
    return data;
  }

  static List<Book> listFromJson(List<dynamic> list) {
    List<Book> rows = list.map((i) => Book.fromJson(i)).toList();
    return rows;
  }
}

class VipGroupDiscounts {
  double priceAfterDiscount;
  String vipGroupText;
  bool isCurrentVipGroup;
  String discountPercent;
  String iconUrl;

  VipGroupDiscounts(
      {this.priceAfterDiscount,
        this.vipGroupText,
        this.isCurrentVipGroup,
        this.discountPercent,
        this.iconUrl});

  VipGroupDiscounts.fromJson(Map<String, dynamic> json) {
    priceAfterDiscount = double.parse(json['PriceAfterDiscount'].toString());
    vipGroupText = json['VipGroupText'];
    isCurrentVipGroup = json['IsCurrentVipGroup'];
    discountPercent = json['DiscountPercent'];
    iconUrl = json['IconUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PriceAfterDiscount'] = this.priceAfterDiscount;
    data['VipGroupText'] = this.vipGroupText;
    data['IsCurrentVipGroup'] = this.isCurrentVipGroup;
    data['DiscountPercent'] = this.discountPercent;
    data['IconUrl'] = this.iconUrl;
    return data;
  }
}
