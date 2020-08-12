class DeliveriesListModel {

  int id;
  String deliveryId,
      position,
      quantity,
      date;


  DeliveriesListModel({this.position, this.id, this.deliveryId, this.quantity,this.date});


  factory DeliveriesListModel.fromJson(Map<String, dynamic> json) {
    return DeliveriesListModel(
      id: json['id'],
      deliveryId: json['deliveryId'],
      position: json['position'],
      quantity: json['quantity'],
      date: json['date'],

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