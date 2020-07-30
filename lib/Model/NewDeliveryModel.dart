class NewDeliveryModel{
  String barcode;
  String product_name;

  NewDeliveryModel({this.barcode,this.product_name});

  @override
  String toString() {
    return '{ ${this.barcode}, ${this.product_name} }';
  }

}