class Children {
  int? id;
  String? firstName;
  String? lastName;
  double? snackPrice;
  double? mealPrice;
  double? additionalHourPrice;
  double? hourPrice;
  double? salary;
  bool? gender;
  String? createdDate;
  String? modifiedDate;

  Children(
      {this.id,
      this.firstName,
      this.lastName,
      this.snackPrice,
      this.mealPrice,
      this.additionalHourPrice,
      this.hourPrice,
      this.salary,
      this.gender,
      this.createdDate,
      this.modifiedDate});

  Children.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    snackPrice = json['snackPrice'];
    mealPrice = json['mealPrice'];
    additionalHourPrice = json['additionalHourPrice'];
    hourPrice = json['hourPrice'];
    salary = json['salary'];
    gender = json['gender'];
    createdDate = json['createdDate'];
    modifiedDate = json['modifiedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['snackPrice'] = this.snackPrice;
    data['mealPrice'] = this.mealPrice;
    data['additionalHourPrice'] = this.additionalHourPrice;
    data['hourPrice'] = this.hourPrice;
    data['salary'] = this.salary;
    data['gender'] = this.gender;
    data['createdDate'] = this.createdDate;
    data['modifiedDate'] = this.modifiedDate;
    return data;
  }
}