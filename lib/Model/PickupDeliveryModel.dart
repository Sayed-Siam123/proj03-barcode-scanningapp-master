class PickupDeliveryModel {
  int id_;
  String delivery_id_;
  String pos_;
  String qnty_;
  String huid_;


  //String note = null;

  PickupDeliveryModel({this.delivery_id_, this.huid_, this.pos_, this.qnty_});

  PickupDeliveryModel.withID({this.id_, this.delivery_id_, this.huid_, this.pos_, this.qnty_});

  int get id => this.id;

  String get deliveryID => this.delivery_id_;

  String get huID => this.huid_;

  String get pos => this.pos_;

  String get qty => this.qnty_;

  set DeliveryID(String id) {
    this.delivery_id_ = id;
  }

  set HuID(String id) {
    this.huid_ = id;
  }

  set Pos(String pos) {
    this.pos_ = pos;
  }

  set Quantity(String quantity) {
    this.qnty_ = quantity;
  }

  // ignore: missing_return
  Map<String, dynamic> toMap() => {
        "delivery_id": this.delivery_id_,
        "handling_unit": this.huid_,
        "position": this.pos_,
        "quantity": this.qnty_,
      };

  factory PickupDeliveryModel.fromMapObject(Map<String, dynamic> data) =>
      PickupDeliveryModel.withID(
        id_: data['id'],
        delivery_id_: data['delivery_id'],
        huid_: data['handling_unit'],
        pos_: data['position'],
        qnty_: data['quantity'],
      );
}

class SinglePickupDataModel{

  String position;
  String deliveryCode,huType,quantity;


  SinglePickupDataModel({this.position,this.huType,this.deliveryCode,this.quantity});





  factory SinglePickupDataModel.fromJson(Map<dynamic, dynamic> json) {
    return SinglePickupDataModel(

      position: json['id'],
      deliveryCode: json['deliveryCode'],
      huType: json['huType'],
      quantity: json['quantity'],

    );
  }

}
