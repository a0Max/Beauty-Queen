///TODO: need to delete it
class User {
  final int? id;
  final String? name;
  final String? lastName;
  final String? birthDate;
  final String? email;
  final String? phone;
  final String? address;
  final int? cityId;
  final int? areaId;
  final String? emailVerifiedAt;
  final String? createdAt;
  final String? updatedAt;
  final int? balance;
  final String? accountType;
  final int? queenaBalance;
  final String? upgradedToQueenaAt;
  final int? brand1;
  final int? brand2;
  final int? brand3;
  final String? phone2;
  final String? whatsappPhone;

  User({
    this.id,
    this.name,
    this.lastName,
    this.birthDate,
    this.email,
    this.phone,
    this.address,
    this.cityId,
    this.areaId,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.balance,
    this.accountType,
    this.queenaBalance,
    this.upgradedToQueenaAt,
    this.brand1,
    this.brand2,
    this.brand3,
    this.phone2,
    this.whatsappPhone,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      lastName: json['last_name'],
      birthDate: json['birth_date'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      cityId: json['city_id'],
      areaId: json['area_id'],
      emailVerifiedAt: json['email_verified_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      balance: json['balance'],
      accountType: json['account_type'],
      queenaBalance: json['queena_balance'],
      upgradedToQueenaAt: json['upgraded_to_queena_at'],
      brand1: json['brand1'],
      brand2: json['brand2'],
      brand3: json['brand3'],
      phone2: json['phone2'],
      whatsappPhone: json['whatsapp_phone'],
    );
  }
}
