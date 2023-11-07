class UserModel {
  int id;
  String name;
  String email;
  String phone;
  int orderCount;

  UserModel(
      {required this.email,
      required this.id,
      required this.phone,
      required this.name,
      required this.orderCount});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        email: json['email'],
        id: json['id'],
        phone: json['phone'],
        name: json['f_name'],
        orderCount: json['order_count']
      );
  }
}
