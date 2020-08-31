class FriendModel {
  String name;
  String description;
  String personId;

  FriendModel(this.name, this.description, this.personId);

  FriendModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    personId = json['personId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['personId'] = this.personId;
    return data;
  }
}
