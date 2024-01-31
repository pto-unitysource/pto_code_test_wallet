class UserModel {
  String uid;
  String name;
  String email;
  String imgUrl;
  double amount;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.imgUrl,
    required this.amount,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
      imgUrl: json['imgUrl'],
      amount: json['amount'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'imgUrl': imgUrl,
      'amount': amount,
    };
  }
}
