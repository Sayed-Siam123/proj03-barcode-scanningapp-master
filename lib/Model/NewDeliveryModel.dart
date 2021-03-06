class NewDeliveryModel {
  int id_;
  String barcode_;
  String product_name_;
  int quantity_;
  String handling_unit = null;
  String note = null;
  String product_id_;

  NewDeliveryModel({this.barcode_, this.product_name_,this.product_id_,this.quantity_,this.handling_unit,this.note});

  NewDeliveryModel.withID({this.id_, this.product_name_,this.product_id_, this.barcode_,this.quantity_,this.handling_unit,this.note});


  int get id => this.id_;

  String get barcode => this.barcode_;

  String get productName => this.product_name_;

  int get quantity => this.quantity_;

  String get handlingUnit => this.handling_unit;

  String get noteText => this.note;

  String get productID => this.product_id_;


  set productName(String name) {
      this.product_name_ = name;
  }

  set Barcode(String gtin) {
    this.barcode_ = gtin;
  }

  set Quantity(int quantity) {
    this.quantity_ = quantity;
  }

  set HandlingUnit(String unit) {
    this.handling_unit = unit;
  }

  set Note(String note) {
    this.note = note;
  }

  set ProductID(String id) {
    this.product_id_ = id;
  }


  // ignore: missing_return
  Map<String, dynamic> toMap() => {

    "product_name" : this.product_name_,
    "barcode" : this.barcode_,
    "quantity" : this.quantity_,
    "handling_unit" : this.handling_unit,
    "note" : this.note,
    "product_id" : this.product_id_,

  };


  factory NewDeliveryModel.fromMapObject(Map<String, dynamic> data) => NewDeliveryModel.withID(
      id_ : data['id'],
      barcode_ : data['barcode'],
      product_name_ : data['product_name'],
      quantity_ : data['quantity'],
      handling_unit: data['handling_unit'],
      note: data['note'],
      product_id_: data['product_id']

  );

}