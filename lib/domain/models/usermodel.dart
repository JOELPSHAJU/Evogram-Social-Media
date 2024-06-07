class UserModel {
  final String email;
  final String userName;
  final String phone;
  final String password;

  UserModel({
    required this.email,
    required this.userName,
    required this.phone,
    required this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json['email']  ,
        userName: json['userName'],
        phone: json['phone'],
        password: json['password'],
      );

  Map<String, dynamic> toJson() => {
        'email': email,
        'userName': userName,
        'phone': phone,
        'password': password,
      };
}

