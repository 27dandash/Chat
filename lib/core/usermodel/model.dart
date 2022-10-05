class  SocialUserModel{

  String ? name;
  String ? phone;
  String ? email;
  String ? uId;
  String ? password;
  bool ? isEmailVerfied;


  SocialUserModel(
      {this.name,this.password ,this.phone, this.email, this.uId, this.isEmailVerfied});

  SocialUserModel.fromJson(Map<String,dynamic>json){
    name=json['name'];
    phone=json['phone'];
    email=json['email'];
    uId=json['uId'];
    password=json['password'];
    isEmailVerfied=json['isEmailVerfied'];
  }
  Map<String,dynamic>toMap(){
return {
  'name':name,
  'phone':phone,
  'email':email,
  'password':password,
  'uId':uId,
  'isEmailVerfied':isEmailVerfied,
};
  }

}