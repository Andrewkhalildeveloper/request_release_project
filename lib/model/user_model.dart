class UserModel {
  static const String modelName = 'userModel';

  String? name;
  String? token;
  String? message;
  bool? validation;

  UserModel({
    required this.name,
    required this.token,
    required this.message,
    required this.validation,
  });

  UserModel.fromFireStore(Map<String, dynamic> json)
      : this(
          name: json['name'],
          message: json['message'],
          token: json['token'] != null ? json['genre_ids'].cast<String>() : [],
          validation: json['validation'],
        );

  Map<String, dynamic> toFireStore() {
    return {
      'name': name,
      'message': message,
      'token': token,
      'validation': validation
    };
  }
}

// class Token {
//   String? tokenId;
//
//   Token({required this.tokenId});
//   Token.fromFireStore(Map<String, dynamic> json)
//       : this(
//           tokenId: json['tokenId'],
//         );
//
//   Map<String, dynamic> toFireStore() {
//     return {
//       'tokenId': tokenId,
//     };
//   }
// }
