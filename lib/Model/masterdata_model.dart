class MasterDataModel{

  String id;
  String product_id=null,manufacturerName,gtin,productId,productName,subCategoryName,categoryName,productDescription,referenceNo,listPrice,productWeight,packagingUnit,productPicture;
  String updateFlag="false";


  MasterDataModel({this.gtin,this.product_id,this.categoryName,this.id,this.listPrice,this.manufacturerName,this.packagingUnit,this.productDescription,this.productId,this.productPicture,
  this.productName,this.productWeight,this.referenceNo,this.subCategoryName,this.updateFlag});

  MasterDataModel.withID({this.gtin,this.product_id,this.categoryName,this.listPrice,this.manufacturerName,this.packagingUnit,this.productDescription,this.productId,this.productPicture,
    this.productName,this.productWeight,this.referenceNo,this.subCategoryName,this.updateFlag});

  MasterDataModel.withoutID({this.gtin,this.product_id,this.categoryName,this.listPrice,this.manufacturerName,this.packagingUnit,this.productDescription,this.productId,this.productPicture,
    this.productName,this.productWeight,this.referenceNo,this.subCategoryName,this.updateFlag});
  
  

  String get getId => this.id;

  String get getmanufacturerName => this.manufacturerName;
  String get getGtin => this.gtin;
  String get getproductId => this.product_id;
  String get getproductName => this.productName;
  String get getsubCategoryName => this.subCategoryName;
  String get getcategoryName => this.categoryName;
  String get getproductDescription => this.productDescription;
  String get getreferenceNo => this.referenceNo;
  String get getlistPrice => this.listPrice;
  String get getproductWeight => this.productWeight;
  String get getpackagingUnit => this.packagingUnit;
  String get getproductPicture => this.productPicture;

  String get getupdateFlag => this.updateFlag;

  set setmanufacturerName(String manufac_name) {
    this.manufacturerName = manufac_name;
  }

  set setGtin(String gtin) {
    this.gtin = gtin;
  }

  set setproductId(String productId) {
    this.productId = productId;
  }

  set setproductName(String productName) {
    this.productName = productName;
  }

  set setsubCategoryName(String subCategoryName) {
    this.subCategoryName = subCategoryName;
  }

  set setcategoryName(String categoryName) {
    this.categoryName = categoryName;
  }

  set setproductDescription(String productDescription) {
    this.productDescription = productDescription;
  }

  set setreferenceNo(String referenceNo) {
    this.referenceNo = referenceNo;
  }

  set setlistPrice(String listPrice) {
    this.listPrice = listPrice;
  }

  set setproductWeight(String productWeight) {
    this.productWeight = productWeight;
  }

  set setpackagingUnit(String packagingUnit) {
    this.packagingUnit = packagingUnit;
  }

  set setproductPicture(String productPicture) {
    this.productPicture = productPicture;
  }

  set setupdateFlag(String flag) {
    this.updateFlag = flag;
  }



  // ignore: missing_return
  Map<String, dynamic> toMap() => {
    "id" : this.id,  //product id te id pathabo
    "productName" : this.productName,
    "manufacturerName" : this.manufacturerName,
    "categoryName" : this.categoryName,
    "subCategoryName" : this.subCategoryName,
    "referenceNo" : this.referenceNo,
    "gtin" : this.gtin,
    "productDescription" : this.productDescription,
    "listPrice" : this.listPrice,
    "productWeight" : this.productWeight,
    "packagingUnit" : this.packagingUnit,
    "productPicture" : this.productPicture,
    "updateFlag" : this.updateFlag,
  };


  factory MasterDataModel.fromJson(Map<String, dynamic> json) {
    return MasterDataModel(
      id: json['id'],
      productPicture: json['productPicture'],
      productName: json['productName'],
      categoryName: json['categoryName'],
      subCategoryName: json['subCategoryName'],
      gtin: json['gtin'],
      listPrice: json['listPrice'],
      manufacturerName: json['manufacturerName'],
      packagingUnit: json['packagingUnit'],
      productDescription: json['productDescription'],
      productId: json['productId'],
      productWeight: json['productWeight'],
      referenceNo: json['referenceNo'],
      updateFlag: json['updateFlag'],
    );
  }
}


class SingleMasterDataModel{

  String id;
  String manufacturerName,gtin,productId,productName,subCategoryName,categoryName,productDescription,referenceNo,listPrice,productWeight,packagingUnit,
      manufacturerId,manufacturerPN,unitId,categoryNameId,subCategoryNameId,materialId,packagingNotes,materialName,productPicture;


  SingleMasterDataModel({this.gtin,this.categoryName,this.id,this.listPrice,this.manufacturerName,this.packagingUnit,this.productDescription,this.productId,
    this.productName,this.productWeight,this.referenceNo,this.subCategoryName,this.categoryNameId,this.manufacturerId,this.manufacturerPN,this.materialId,
  this.materialName,this.packagingNotes,this.subCategoryNameId,this.unitId,this.productPicture});





  factory SingleMasterDataModel.fromJson(Map<dynamic, dynamic> json) {
    return SingleMasterDataModel(
      id: json['id'],
      productName: json['productName'],
      categoryName: json['categoryName'],
      productPicture: json['productPicture'],
      subCategoryName: json['subCategoryName'],
      gtin: json['gtin'],
      listPrice: json['listPrice'],
      manufacturerName: json['manufacturerName'],
      packagingUnit: json['packagingUnit'],
      productDescription: json['productDescription'],
      productId: json['productId'],
      productWeight: json['productWeight'],
      referenceNo: json['referenceNo'],
      categoryNameId: json['categoryNameId'],
      manufacturerId: json['manufacturerId'],
      manufacturerPN: json['manufacturerPN'],
      materialId: json['materialId'],
      materialName: json['materialName'],
      packagingNotes: json['packagingNotes'],
      subCategoryNameId: json['subCategoryNameId'],
      unitId: json['unitId'],

    );
  }

}

class MasterdataDBModel {
  String id_;
  String product_id,manufacturerName,gtin,productId,productName,subCategoryName,categoryName,productDescription,referenceNo,listPrice,productWeight,packagingUnit,productPicture;

  MasterdataDBModel({this.id_,this.gtin,this.categoryName,this.listPrice,this.manufacturerName,this.packagingUnit,this.productDescription,this.productId,this.productPicture,
    this.productName,this.productWeight,this.referenceNo,this.subCategoryName,this.product_id});

  MasterdataDBModel.withID({this.id_, this.gtin,this.categoryName,this.listPrice,this.manufacturerName,this.packagingUnit,this.productDescription,this.productId,this.productPicture,
    this.productName,this.productWeight,this.referenceNo,this.subCategoryName,this.product_id});


  String get id => this.id_;

  String get getmanufacturerName => this.manufacturerName;
  String get getGtin => this.gtin;
  String get getproductId => this.product_id;
  String get getproductName => this.productName;
  String get getsubCategoryName => this.subCategoryName;
  String get getcategoryName => this.categoryName;
  String get getproductDescription => this.productDescription;
  String get getreferenceNo => this.referenceNo;
  String get getlistPrice => this.listPrice;
  String get getproductWeight => this.productWeight;
  String get getpackagingUnit => this.packagingUnit;
  String get getproductPicture => this.productPicture;



  set setmanufacturerName(String manufac_name) {
    this.manufacturerName = manufac_name;
  }

  set setGtin(String gtin) {
    this.gtin = gtin;
  }

  set setproductId(String productId) {
    this.productId = productId;
  }

  set setproductName(String productName) {
    this.productName = productName;
  }

  set setsubCategoryName(String subCategoryName) {
    this.subCategoryName = subCategoryName;
  }

  set setcategoryName(String categoryName) {
    this.categoryName = categoryName;
  }

  set setproductDescription(String productDescription) {
    this.productDescription = productDescription;
  }

  set setreferenceNo(String referenceNo) {
    this.referenceNo = referenceNo;
  }

  set setlistPrice(String listPrice) {
    this.listPrice = listPrice;
  }

  set setproductWeight(String productWeight) {
    this.productWeight = productWeight;
  }

  set setpackagingUnit(String packagingUnit) {
    this.packagingUnit = packagingUnit;
  }

  set setproductPicture(String productPicture) {
    this.productPicture = productPicture;
  }



  // ignore: missing_return
  Map<String, dynamic> toMap() => {
    "product_id" : this.product_id,  //product id te id pathabo
    "productName" : this.productName,
    "manufacturerName" : this.manufacturerName,
    "categoryName" : this.categoryName,
    "subCategoryName" : this.subCategoryName,
    "referenceNo" : this.referenceNo,
    "gtin" : this.gtin,
    "productDescription" : this.productDescription,
    "listPrice" : this.listPrice,
    "productWeight" : this.productWeight,
    "packagingUnit" : this.packagingUnit,
    "productPicture" : this.productPicture,
  };


  factory MasterdataDBModel.fromMapObject(Map<String, dynamic> data) => MasterdataDBModel.withID(
//      id_ : data['id'],
//      barcode_ : data['barcode'],
//      product_name_ : data['product_name'],
//      quantity_ : data['quantity'],
//      handling_unit: data['handling_unit'],
//      note: data['note'],
//      product_id_: data['product_id']


    id_: data['id'], //product id te id pathabo
    product_id: data['product_id'], //product id te id pathabo
    productName: data['productName'], //product id te id pathabo
    manufacturerName : data['manufacturerName'], //product id te id pathabo
    categoryName: data['categoryName'], //product id te id pathabo
    subCategoryName: data['subCategoryName'], //product id te id pathabo
    productDescription: data['productDescription'], //product id te id pathabo
    referenceNo: data['referenceNo'], //product id te id pathabo
    packagingUnit:  data['packagingUnit'], //product id te id pathabo
    productPicture: data['productPicture'], //product id te id pathabo
    listPrice: data['listPrice'], //product id te id pathabo
    gtin: data['gtin'], //product id te id pathabo
    productWeight: data['productWeight'],

  );

}