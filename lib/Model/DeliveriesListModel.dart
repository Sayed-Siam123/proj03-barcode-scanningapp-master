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