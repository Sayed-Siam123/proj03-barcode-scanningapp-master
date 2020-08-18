class DeliveriesListModel {

  String id;
  String deliveryCode,
      quantity,commissionedOn;


  DeliveriesListModel({this.id, this.deliveryCode, this.quantity,this.commissionedOn});


  factory DeliveriesListModel.fromJson(Map<String, dynamic> json) {
    return DeliveriesListModel(
      id: json['id'],
      deliveryCode: json['deliveryCode'],
      quantity: json['quantity'],
      commissionedOn: json['commissionedOn'],

    );
  }
}


class PickupListModel {

  int id;
  String deliveryId,
      position,
      quantity,
      huTypeID;


  PickupListModel({this.position, this.id, this.deliveryId, this.quantity,this.huTypeID});


  factory PickupListModel.fromJson(Map<String, dynamic> json) {
    return PickupListModel(
      id: json['id'],
      deliveryId: json['deliveryId'],
      position: json['position'],
      quantity: json['quantity'],
      huTypeID: json['huTypeID'],

    );
  }
}