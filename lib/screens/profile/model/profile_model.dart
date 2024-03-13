class ProfileModel {
  String userName;
  String userEmail;
  String userDob;
  String userImage;

  ProfileModel(
      {required this.userName,
      required this.userEmail,
      required this.userDob,
      required this.userImage});

  factory ProfileModel.fromMap(Map<String, dynamic> json) => ProfileModel(
        userName: json["userName"],
        userEmail: json["userEmail"],
        userDob: json["userDob"],
        userImage: json["userImage"],
      );
  Map<String, dynamic> toMap() => {
        "userName": userName,
        "userEmail": userEmail,
        "userDob": userDob,
        "userImage": userImage,
      };
}
