class MessageModel {
  String? senderId;
  String? recivreId;
  String? dateTime;
  String? text;



  MessageModel({
    this.senderId,
    this.text,
    this.dateTime,
    this.recivreId,

  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    senderId = json['name'];
    text = json['text'];
    dateTime = json['dateTime'];
    recivreId = json['img'];

  }

  Map<String, dynamic> toMap() => {
    'name': senderId,
    'text': text,

    'dateTime': dateTime,
    'img': recivreId,

  };
}