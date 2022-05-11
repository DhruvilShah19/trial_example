class UserData {
  String name;
  String email;

  String uid;

  UserData();

  UserData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    // mobile = json['mobile'];
    email = json['email'];
    // profile = json['profile'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    // data['mobile'] = this.mobilecode + this.mobile;
    data['email'] = this.email;
    // data['profile'] = this.profile;
    data['uid'] = this.uid;
    return data;
  }
}
