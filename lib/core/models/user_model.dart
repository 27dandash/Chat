class UserModel {
  String? name;
  String? phone;
  String? email;
  String? img;
  String? coverimg;
  String? bio;
  String? uId;
  String? password;
  bool? isEmailVerfied;

  UserModel(
      {this.name,
      this.password,
      this.phone,
      this.img,
      this.coverimg,
      this.bio,
      this.email,
      this.uId,
      this.isEmailVerfied});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    coverimg = json['coverimg'];
    uId = json['uId'];
    img = json['img'];
    bio = json['bio'];
    password = json['password'];
    isEmailVerfied = json['isEmailVerfied'];
  }
  //
  // @override
  // String toString() {
  //   return 'SocialUserModel{name: $name, phone: $phone, email: $email, img: $img, bio: $bio, uId: $uId, password: $password, isEmailVerfied: $isEmailVerfied}';
  // }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
      'coverimg': coverimg,
      'uId': uId,
      'img': img,
      'bio': bio,
      'password': password,
      'isEmailVerfied': isEmailVerfied,
    };
  }
}
