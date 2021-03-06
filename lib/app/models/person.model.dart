import 'package:meu_querido_livro/app/models/friend.model.dart';

class PersonModel {
  String id;
  String name;
  String description;
  String pictureUrl;
  String email;
  String password;
  List<FriendModel> friends;

  PersonModel(name, description, pictureUrl, {friendsList}) {
    this.name = name;
    this.description = description;
    this.pictureUrl = pictureUrl != null ? pictureUrl : null;
    this.friends = friendsList != null ? friendsList : [];
  }

  PersonModel.create(name, description, {picture, friendsList}) {
    this.name = name;
    this.description = description;
    this.pictureUrl = picture;
    this.friends = friendsList != null ? friendsList : [];
  }

  PersonModel.fromJson(Map<dynamic, dynamic> json) {
    name = json['name'] != null ? json['name'] : '';
    description = json['description'] != null ? json['description'] : '';
    pictureUrl = json['pictureUrl'] != null ? json['pictureUrl'] : null;
    friends = json['friends'] != null ? json['friends'].length > 0 ? _getFriends(json['friends']) : [] : [];
  }

  List<FriendModel> _getFriends(List<Map<dynamic, dynamic>> friendsMap) {
    List<FriendModel> result = [];
    for (Map<dynamic, dynamic> json in friendsMap) {
      result.add(FriendModel.fromJson(json));
    }
    return result;
  }

  Map<dynamic, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name != null ? this.name : '';
    data['description'] = this.description != null ? this.description : '';
    data['picture_url'] = this.pictureUrl != null ? this.pictureUrl : null;
    data['friends'] = this.friends != null ? _setFriend(friends) : [];
    return data;
  }

  List<Map<dynamic, dynamic>> _setFriend(List<FriendModel> friends) {
    List<Map<String, dynamic>> result = [];
    for (FriendModel friend in friends) {
      result.add(friend.toJson());
    }
    return result;
  }
}
