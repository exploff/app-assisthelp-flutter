import 'package:equatable/equatable.dart';

class User extends Equatable {
  int? id;
  String? username;
  String? email;
  String? phone;
  String? address;
  String? city;
  String? country;
  String? zip;
  String? description;
  String? createdDate;
  String? modifiedDate;
  String? birthdayDate;
  String? firstName;
  String? lastName;
  double? indemnite;

  User(
      {this.id,
      this.username,
      this.email,
      this.phone,
      this.address,
      this.city,
      this.country,
      this.zip,
      this.description,
      this.createdDate,
      this.modifiedDate,
      this.birthdayDate,
      this.firstName,
      this.lastName,
      this.indemnite});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    city = json['city'];
    country = json['country'];
    zip = json['zip'];
    description = json['description'];
    createdDate = json['createdDate'];
    modifiedDate = json['modifiedDate'];
    birthdayDate = json['birthdayDate'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    indemnite = json['indemnite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['city'] = this.city;
    data['country'] = this.country;
    data['zip'] = this.zip;
    data['description'] = this.description;
    data['createdDate'] = this.createdDate;
    data['modifiedDate'] = this.modifiedDate;
    data['birthdayDate'] = this.birthdayDate;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['indemnite'] = this.indemnite;
    return data;
  }

  @override
  List<Object> get props => [id!];

}