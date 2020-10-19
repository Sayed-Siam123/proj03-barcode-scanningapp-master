import 'package:app/Model/PhotoDocumentationImageModel.dart';

class MasterDataModel{

  String id=null;
  String product_id=null,manufacturerName=null,gtin=null,productId=null,productName=null,subCategoryName=null,categoryName=null,productDescription=null,referenceNo=null,listPrice=null,productWeight=null,packagingUnit=null,productPicture=null;
  String updateFlag=null,newFlag=null, price_show = null;
  String manufacturerId=null,manufacturerPN=null,unitId=null,categoryNameId=null,subCategoryNameId=null,isTransferToApp=null,isOrderableViaApp=null,productLength=null,productHeight=null,productWidth=null,unitName=null;


  MasterDataModel({this.gtin,this.product_id,this.categoryName,this.id,this.listPrice,this.manufacturerName,this.packagingUnit,this.productDescription,this.productId,this.productPicture,
  this.productName,this.productWeight,this.referenceNo,this.subCategoryName,this.updateFlag,this.newFlag,this.price_show,
    this.manufacturerId,this.manufacturerPN,this.unitId,this.categoryNameId,this.subCategoryNameId,this.isTransferToApp,this.isOrderableViaApp,this.productLength,this.productHeight,this.productWidth,this.unitName});

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

  String get getmanufacturerId => this.manufacturerId;
  String get getmanufacturerPN => this.manufacturerPN;
  String get getunitId => this.unitId;
  String get getcategoryNameId => this.categoryNameId;
  String get getsubCategoryNameId => this.subCategoryNameId;
  String get getisTransferToApp => this.isTransferToApp;
  String get getisOrderableViaApp => this.isOrderableViaApp;
  String get getproductLength => this.productLength;
  String get getproductHeight => this.productHeight;
  String get getproductWidth => this.productWidth;
  String get getunitName => this.unitName;



  set setproductWidth(String productWidth) {
    this.productWidth = productWidth;
  }

  set setunitName(String unitName) {
    this.unitName = unitName;
  }

  set setsubCategoryNameId(String subCategoryNameId) {
    this.subCategoryNameId = subCategoryNameId;
  }

  set setisTransferToApp(String isTransferToApp) {
    this.isTransferToApp = isTransferToApp;
  }

  set setisOrderableViaApp(String isOrderableViaApp) {
    this.isOrderableViaApp = isOrderableViaApp;
  }

  set setproductLength(String productLength) {
    this.productLength = productLength;
  }





  set setcategoryNameId(String categoryNameId) {
    this.categoryNameId = categoryNameId;
  }

  set setproductHeight(String productHeight) {
    this.productHeight = productHeight;
  }
  set setmanufacturerPN(String manufacturerPN) {
    this.manufacturerPN = manufacturerPN;
  }

  set setproductId(String productId) {
    this.productId = productId;
  }




  set setunitId(String unitId) {
    this.unitId = unitId;
  }


  set setmanufacturerName(String manufac_name) {
    this.manufacturerName = manufac_name;
  }

  set setGtin(String gtin) {
    this.gtin = gtin;
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

  set setmanufacturerId(String manufacturerId) {
    this.manufacturerId = manufacturerId;
  }





  // ignore: missing_return
  Map<String, dynamic> toMap() => {
    "id" : this.id,  //product id te id pathabo
    "productName" : this.productName,
    "manufacturerName" : this.manufacturerName,
    "manufacturerId" : this.manufacturerId,
    "manufacturerPN": this.manufacturerPN,
    "categoryName" : this.categoryName,
    'categoryNameId': this.categoryNameId,
    "subCategoryName" : this.subCategoryName,
    "subCategoryNameId": this.subCategoryNameId,
    "unitName": this.unitName,
    "unitId": this.unitId,
    "referenceNo" : this.referenceNo,
    "gtin" : this.gtin,
    "productDescription" : this.productDescription,
    "listPrice" : this.listPrice,
    "isTransferToApp":this.isTransferToApp,
    "isOrderableViaApp": this.isOrderableViaApp,
    "productLength":this.productLength,
    "productHeight": this.productHeight,
    "productWidth":this.productWidth,
    "productWeight" : this.productWeight,
    "packagingUnit" : this.packagingUnit,
    "productPicture" : this.productPicture,
    "updateFlag" : this.updateFlag,
    "newFlag" : this.newFlag,

  };


  factory MasterDataModel.fromJson(Map<String, dynamic> json) {
    return MasterDataModel(
      id: json['id'],
      productPicture: json['productPicture'],
      productName: json['productName'],
      categoryName: json['categoryName'],
      categoryNameId: json['categoryNameId'],
      subCategoryName: json['subCategoryName'],
      subCategoryNameId: json['subCategoryNameId'],
      gtin: json['gtin'],
      listPrice: json['listPrice'],
      manufacturerName: json['manufacturerName'],
      manufacturerId: json['manufacturerId'],
      manufacturerPN: json['manufacturerPN'],
      packagingUnit: json['packagingUnit'],
      unitId: json['unitId'],
      unitName: json['unitName'],
      isOrderableViaApp: json['isOrderableViaApp'],
      isTransferToApp: json['isTransferToApp'],
      productDescription: json['productDescription'],
      productId: json['productId'],
      productWeight: json['productWeight'],
      productHeight: json['productHeight'],
      productLength: json['productLength'],
      productWidth: json['productWidth'],
      referenceNo: json['referenceNo'],
      updateFlag: json['updateFlag'],
      newFlag: json['newFlag'],
    );
  }
}


class SingleMasterDataModel{

  String id=null;
  String product_id=null,manufacturerName=null,gtin=null,productId=null,productName=null,subCategoryName=null,categoryName=null,productDescription=null,referenceNo=null,listPrice=null,productWeight=null,packagingUnit=null,productPicture=null;
  String updateFlag=null,newFlag = null;
  String manufacturerId=null,manufacturerPN=null,unitId=null,categoryNameId=null,subCategoryNameId=null,isTransferToApp=null,isOrderableViaApp=null,productLength=null,productHeight=null,productWidth=null,unitName=null;



  SingleMasterDataModel({this.gtin,this.product_id,this.categoryName,this.id,this.listPrice,this.manufacturerName,this.packagingUnit,this.productDescription,this.productId,this.productPicture,
    this.productName,this.productWeight,this.referenceNo,this.subCategoryName,this.updateFlag,this.newFlag,
    this.manufacturerId,this.manufacturerPN,this.unitId,this.categoryNameId,this.subCategoryNameId,this.isTransferToApp,this.isOrderableViaApp,this.productLength,this.productHeight,this.productWidth,this.unitName});


  Map<String, dynamic> toMap() => {
    "id" : this.id,  //product id te id pathabo
    "productName" : this.productName,
    "manufacturerName" : this.manufacturerName,
    "manufacturerId" : this.manufacturerId,
    "manufacturerPN": this.manufacturerPN,
    "categoryName" : this.categoryName,
    'categoryNameId': this.categoryNameId,
    "subCategoryName" : this.subCategoryName,
    "subCategoryNameId": this.subCategoryNameId,
    "unitName": this.unitName,
    "unitId": this.unitId,
    "referenceNo" : this.referenceNo,
    "gtin" : this.gtin,
    "productDescription" : this.productDescription,
    "listPrice" : this.listPrice,
    "isTransferToApp":this.isTransferToApp,
    "isOrderableViaApp": this.isOrderableViaApp,
    "productLength":this.productLength,
    "productHeight": this.productHeight,
    "productWidth":this.productWidth,
    "productWeight" : this.productWeight,
    "packagingUnit" : this.packagingUnit,
    "productPicture" : this.productPicture,
    "updateFlag" : this.updateFlag,
    "newFlag" : this.newFlag,

  };



  factory SingleMasterDataModel.fromJson(Map<dynamic, dynamic> json) {
    return SingleMasterDataModel(
      id: json['id'],
      productPicture: json['productPicture'],
      productName: json['productName'],
      categoryName: json['categoryName'],
      categoryNameId: json['categoryNameId'],
      subCategoryName: json['subCategoryName'],
      subCategoryNameId: json['subCategoryNameId'],
      gtin: json['gtin'],
      listPrice: json['listPrice'],
      manufacturerName: json['manufacturerName'],
      manufacturerId: json['manufacturerId'],
      manufacturerPN: json['manufacturerPN'],
      packagingUnit: json['packagingUnit'],
      unitId: json['unitId'],
      unitName: json['unitName'],
      isOrderableViaApp: json['isOrderableViaApp'],
      isTransferToApp: json['isTransferToApp'],
      productDescription: json['productDescription'],
      productId: json['productId'],
      productWeight: json['productWeight'],
      productHeight: json['productHeight'],
      productLength: json['productLength'],
      productWidth: json['productWidth'],
      referenceNo: json['referenceNo'],
      updateFlag: json['updateFlag'],
      newFlag: json['newFlag'],
      
    );
  }

}

class MasterDataModelV2{
  String id=null,gtin=null,productDescription=null,listPrice=null,productPicture=null,updateFlag=null,newFlag=null,price_show = null;
  PhotoDocumentationImageModel photos;

  MasterDataModelV2({this.id,this.gtin,this.productDescription,this.listPrice,this.productPicture,this.updateFlag,this.newFlag,this.price_show,this.photos});

  Map<String, dynamic> toMap() => {
    "id" : this.id,  //product id te id pathabo
    "gtin" : this.gtin,
    "productDescription" : this.productDescription,
    "listPrice" : this.listPrice,
    "productPicture" : this.productPicture,
    "updateFlag" : this.updateFlag,
    "newFlag" : this.newFlag,
  };



  factory MasterDataModelV2.fromJson(Map<dynamic, dynamic> json) {
    return MasterDataModelV2(
      id: json['id'],
      productPicture: json['productPicture'],
      gtin: json['gtin'],
      listPrice: json['listPrice'],
      productDescription: json['productDescription'],
      updateFlag: json['updateFlag'],
      newFlag: json['newFlag'],
    );
  }


}

class SingleMasterDataModelV2{
  String id=null,gtin=null,productDescription=null,listPrice=null,productPicture=null,updateFlag=null,newFlag=null,price_show = null;

  SingleMasterDataModelV2({this.id,this.gtin,this.productDescription,this.listPrice,this.productPicture,this.updateFlag,this.newFlag,this.price_show});

  Map<String, dynamic> toMap() => {
    "id" : this.id,  //product id te id pathabo
    "gtin" : this.gtin,
    "productDescription" : this.productDescription,
    "listPrice" : this.listPrice,
    "productPicture" : this.productPicture,
    "updateFlag" : this.updateFlag,
    "newFlag" : this.newFlag,

  };



  factory SingleMasterDataModelV2.fromJson(Map<dynamic, dynamic> json) {
    return SingleMasterDataModelV2(
      id: json['id'],
      productPicture: json['productPicture'],
      gtin: json['gtin'],
      listPrice: json['listPrice'],
      productDescription: json['productDescription'],
      updateFlag: json['updateFlag'],
      newFlag: json['newFlag'],
    );
  }


}