// class PostModel {
//   String? name;
//   String? img;
//   String? uId;
//   String? dateTime;
//   String? text;
//   String? postImage;
//   PostModel(
//       {this.name,
//       this.img,
//       this.uId,
//       this.dateTime,
//       this.text,
//       this.postImage});
//   PostModel.fromJson(Map<String, dynamic> json) {
//     name:json['name'];
//     img:json['img'];
//     uId:json['uId'];
//     dateTime:json[' dateTime'];
//     text:json[' text;'];
//     postImage:json['postImage'];
//   }
//   Map<String, dynamic> toMap() {
//     return {
//       'name': name,
//       'img': img,
//       'uId': uId,
//       ' dateTime': dateTime,
//       ' text': text,
//       'postImage': postImage,
//     };
//   }
// }
class PostModel {
  String? name;
  String? img;
  String? uId;
  String? dateTime;
  String? text;
  String? postImage;


  PostModel({
    this.name,
    this.text,
    this.dateTime,
    this.img,
    this.postImage,
    this.uId,
  });

  PostModel.fromMap(Map<String, dynamic> json) {
    name = json['name'];
    text = json['text'];
    dateTime = json['dateTime'];
    img = json['img'];
    postImage = json['postImage'];
    uId = json['uId'];
  }

  Map<String, dynamic> toMap() => {
    'name': name,
    'text': text,
    'uId': uId,
    'dateTime': dateTime,
    'img': img,
    'postImage': postImage,
  };
}