class BookModel {
  String id;
  String name;
  String description;
  String pictureUrl;
  int bookPageCount;
  int readPageCount;
  int borrowedReadPageCount;
  String ownerId;
  String borrowedTo;
  bool enable;

  BookModel({this.name, this.description, this.pictureUrl, this.bookPageCount, this.readPageCount, this.borrowedReadPageCount, this.ownerId, this.borrowedTo, this.enable});

  BookModel.create(this.name, this.description, this.bookPageCount, this.ownerId, {this.pictureUrl, this.readPageCount, this.borrowedReadPageCount, this.borrowedTo, this.enable}) {
    this.name = name;
    this.description = description;
    this.bookPageCount = bookPageCount;
    this.ownerId = ownerId;
    this.pictureUrl = pictureUrl != null ? pictureUrl : null;
    this.readPageCount = readPageCount != null ? readPageCount : 0;
    this.borrowedReadPageCount = borrowedReadPageCount != null ? borrowedReadPageCount : 0;
    this.borrowedTo = borrowedTo != null ? borrowedTo : null;
    this.enable = enable != null ? enable : false;
  }

  BookModel.fromJson(Map<String, dynamic> json) {
    name = json['name'] != null ? json['name'] : '';
    description = json['description'] != null ? json['description'] : '';
    pictureUrl = json['pictureUrl'] != null ? json['pictureUrl'] : null;
    bookPageCount = json['bookPageCount'] != null ? json['bookPageCount'] : 0;
    readPageCount = json['readPageCount'] != null ? json['readPageCount'] : 0;
    borrowedReadPageCount = json['borrowedReadPageCount'] != null ? json['borrowedReadPageCount'] : 0;
    ownerId = json['ownerId'] != null ? json['ownerId'] : null;
    borrowedTo = json['borrowedTo'] != null ? json['borrowedTo'] : null;
    enable = json['enable'] != null ? json['enable'] : false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name != null ? this.name : '';
    data['description'] = this.description != null ? this.description : '';
    data['pictureUrl'] = this.pictureUrl != null ? this.pictureUrl : '';
    data['bookPageCount'] = this.bookPageCount != null ? this.bookPageCount : 0;
    data['readPageCount'] = this.readPageCount != null ? this.readPageCount : 0;
    data['borrowedReadPageCount'] = this.borrowedReadPageCount != null ? this.borrowedReadPageCount : 0;
    data['ownerId'] = this.ownerId != null ? this.ownerId : null;
    data['borrowedTo'] = this.borrowedTo != null ? this.borrowedTo : null;
    data['enable'] = this.enable != null ? this.enable : false;
    return data;
  }
}
