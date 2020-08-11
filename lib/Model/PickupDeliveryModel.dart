class PickupDeliveryModel {
  int id_;
  String date_;
  String store_;
  int pos_;
  int qnty_;

  //String note = null;

  PickupDeliveryModel({this.date_, this.store_, this.pos_, this.qnty_});

  PickupDeliveryModel.withID(
      {this.id_, this.date_, this.store_, this.pos_, this.qnty_});

  int get id => this.id;

  String get date => this.date_;

  String get store => this.store_;

  int get pos => this.pos_;

  int get qty => this.qnty_;

  set Date(String date) {
    this.date_ = date;
  }

  set Store(String store) {
    this.store_ = store;
  }

  set Pos(int pos) {
    this.pos_ = pos;
  }

  set Quantity(int quantity) {
    this.qnty_ = quantity;
  }

  // ignore: missing_return
  Map<String, dynamic> toMap() => {
        "date": this.date_,
        "store": this.store_,
        "pos": this.pos_,
        "qnty": this.qnty_,
      };

  factory PickupDeliveryModel.fromMapObject(Map<String, dynamic> data) =>
      PickupDeliveryModel.withID(
        id_: data['id'],
        date_: data['date'],
        store_: data['store'],
        pos_: data['pos'],
        qnty_: data['qnty'],
      );
}
