class ProfileModel {
  String userName;
  String userEmail;
  String userDob;

  ProfileModel({
    required this.userName,
    required this.userEmail,
    required this.userDob,
  });

  factory ProfileModel.fromMap(Map<String, dynamic> json) => ProfileModel(
        userName: json["userName"],
        userEmail: json["userEmail"],
        userDob: json["userDob"],
      );
  Map<String, dynamic> toMap() => {
        "userName": userName,
        "userEmail": userEmail,
        "userDob": userDob,
      };
}
