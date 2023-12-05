import 'package:quiver/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserModel {
  int? id;
  String? name;
  String? lastName;
  String? birthDate;
  String? email;
  String? phone;
  String? address;
  String? cityId;
  String? areaId;
  String? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  int? balance;
  String? accountType;
  int? queenaBalance;
  String? upgradedToQueenaAt;
  String? brand1;
  String? brand2;
  String? brand3;
  String? phone2;
  String? whatsappPhone;


  UserModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.createdAt,
    this.emailVerifiedAt,
    this.address,
    this.accountType,
    this.areaId,
    this.balance,
    this.birthDate,
    this.brand1,
    this.brand2,
    this.brand3,
    this.cityId,
    this.lastName,
    this.phone2,
    this.queenaBalance,
    this.updatedAt,
    this.upgradedToQueenaAt,
    this.whatsappPhone
  });

  UserModel.fromMap(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    lastName = json['last_name'];
    birthDate = json['birth_date'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    cityId = json['city_id'];
    areaId = json['area_id'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    balance = json['balance'];
    accountType = json['account_type'];
    queenaBalance = json['queena_balance'];
    upgradedToQueenaAt = json['upgraded_to_queena_at'];
    brand1 = json['brand1'];
    brand2 = json['brand2'];
    brand3 = json['brand3'];
    phone2 = json['phone2'];
    whatsappPhone = json['whatsapp_phone'];
    if (isNotBlank(json["token"])) saveToken(json["token"]);
  }

  Map<String, dynamic> toMap() {
    return {
      if (name != null) "name": name,
      if (email != null) "email": email,
      if (phone != null) "phone": phone,
    };
  }

  static Future<String?> get getToken async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }


  static Future<bool> get isLoggedIn async => await getToken != null;

  static Future<void> saveToken(String? token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token == null ? prefs.remove('token') : prefs.setString('token', token);
  }

}
