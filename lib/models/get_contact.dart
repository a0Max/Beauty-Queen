class GetContactModel {
  String? email;
  String? callSection;
  String? workingHours;
  String? facebook;
  String? instagram;
  String? snapchat;
  String? tiktok;

  GetContactModel(
      {this.email,
      this.callSection,
      this.workingHours,
      this.facebook,
      this.instagram,
      this.snapchat,
      this.tiktok});

  GetContactModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    callSection = json['call_section'];
    workingHours = json['working_hours'];
    facebook = json['facebook'];
    instagram = json['instagram'];
    snapchat = json['snapchat'];
    tiktok = json['tiktok'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['call_section'] = this.callSection;
    data['working_hours'] = this.workingHours;
    data['facebook'] = this.facebook;
    data['instagram'] = this.instagram;
    data['snapchat'] = this.snapchat;
    data['tiktok'] = this.tiktok;
    return data;
  }
}
