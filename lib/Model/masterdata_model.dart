class MasterDataModel{

  String id;
  String manufacturerName,gtin,productId,productName,subCategoryName,categoryName,productDescription,referenceNo,listPrice,productWeight,packagingUnit,productPicture;


  MasterDataModel({this.gtin,this.categoryName,this.id,this.listPrice,this.manufacturerName,this.packagingUnit,this.productDescription,this.productId,this.productPicture,
  this.productName,this.productWeight,this.referenceNo,this.subCategoryName});





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