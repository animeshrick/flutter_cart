import 'package:flutter_cart/service/value_handler.dart';

class ProductList {
  Items? items;

  ProductList({this.items});

  ProductList.fromJson(Map<String, dynamic> json) {
    items = json['items'] != null ? Items.fromJson(json['items']) : null;
  }
}

class Items {
  Products? products;

  Items({this.products});

  Items.fromJson(Map<String, dynamic> json) {
    products = json['products'] != null
        ? Products.fromJson(json['products'])
        : null;
  }
}

class Products {
  List<Product>? notc;

  Products({this.notc});

  Products.fromJson(Map<String, dynamic> json) {
    if (json['notc'] != null) {
      notc = <Product>[];
      json['notc'].forEach((v) {
        notc!.add(Product.fromJson(v));
      });
    }
  }
}

class Product {
  // Salts? salts;
  // String? interactiveModule;
  // String? productName;
  // String? mfgGroup;
  // String? bBExpiryDate;
  // int? isPurchased;
  // String? documentId;
   String? productId;
  // int? groupSize;
  // String? refProductId;
  // int? displayFactor;
  // int? bBIsFlashSaleOn;
  // Null dosageFormDisplaySeq;
  // int? bBFlashSaleSoldPercent;
  // String? productShortDescription;
  // bool? applyPincodeWiseDiscount;
  // int? avgRating;
  // String? offerTitle;
  // String? encodeProdId;
  // int? dosageAlert;
  // int? bBMinQty;
  // int? recentOrderCount;
  // int? isFeatured;
  // String? brand;
  // String? brandImage;
  // int? maxSKUOrderCount;
  // int? active;
  // int? dealPrice;
  // String? productAliasName;
  // int? dealMaxQty;
  // int? numCustomer;
  // String? dosageForm;
  // String? schemeFreeBaseQtyOfferText;
  // double? lastMRP;
  // String? pKLotId;
  // String? primaryDisease;
  // String? keywords;
  // int? bBDiscountPercent;
  // String? offerImage;
  // int? bBHighDisc;
   String? productImage;
  // double? bBMRP;
  // int? isNew;
  // String? bBIsOutOfStock;
  // String? interactiveSubModule;
  // double? bBOfferPrice;
  // int? pTRDiscType;
  // double? pTR;
  // String? hasOffer;
  // int? dosageRestriction;
   String? displayName;
  // String? prescriptionOTC;
  // int? offerCategoryId;
  // int? orderCount;
  // double? custOfferPrice;
  // int? isRedeemable;
  // int? recentProductCount;
  // int? pTRDiscPercent;
  // int? numRating;
  // int? isGiftableProduct;
  // String? productStatus;
  // int? customScoreManipulator;
  // int? custDiscPercent;
  // int? routeId;
  // int? deliveryDelayedDay;
  // int? schemeFreeBaseQty;
  // int? recentCustCount;
  // int? sKUOrderCount;
  // double? unitPrice;
  // int? pTRDicPct;
  // int? isFoodProduct;
  // int? displayRank;
  // int? bBIsCourierable;
  // int? gSTPercentage;
  // String? offerCategory;
  // String? strength;
  // int? isCustomizable;
  // String? highlightedTerms;
   num? offerPrice;
  // int? discountPercent;

  Product(
      {
      //   this.salts,
      // this.interactiveModule,
      // this.productName,
      // this.mfgGroup,
      // this.bBExpiryDate,
      // this.isPurchased,
      // this.documentId,
      this.productId,
      // this.groupSize,
      // this.refProductId,
      // this.displayFactor,
      // this.bBIsFlashSaleOn,
      // this.dosageFormDisplaySeq,
      // this.bBFlashSaleSoldPercent,
      // this.productShortDescription,
      // this.applyPincodeWiseDiscount,
      // this.avgRating,
      // this.offerTitle,
      // this.encodeProdId,
      // this.dosageAlert,
      // this.bBMinQty,
      // this.recentOrderCount,
      // this.isFeatured,
      // this.brand,
      // this.brandImage,
      // this.maxSKUOrderCount,
      // this.active,
      // this.dealPrice,
      // this.productAliasName,
      // this.dealMaxQty,
      // this.numCustomer,
      // this.dosageForm,
      // this.schemeFreeBaseQtyOfferText,
      // this.lastMRP,
      // this.pKLotId,
      // this.primaryDisease,
      // this.keywords,
      // this.bBDiscountPercent,
      // this.offerImage,
      // this.bBHighDisc,
       this.productImage,
      // this.bBMRP,
      // this.isNew,
      // this.bBIsOutOfStock,
      // this.interactiveSubModule,
      // this.bBOfferPrice,
      // this.pTRDiscType,
      // this.pTR,
      // this.hasOffer,
      // this.dosageRestriction,
      this.displayName,
      // this.prescriptionOTC,
      // this.offerCategoryId,
      // this.orderCount,
      // this.custOfferPrice,
      // this.isRedeemable,
      // this.recentProductCount,
      // this.pTRDiscPercent,
      // this.numRating,
      // this.isGiftableProduct,
      // this.productStatus,
      // this.customScoreManipulator,
      // this.custDiscPercent,
      // this.routeId,
      // this.deliveryDelayedDay,
      // this.schemeFreeBaseQty,
      // this.recentCustCount,
      // this.sKUOrderCount,
      // this.unitPrice,
      // this.pTRDicPct,
      // this.isFoodProduct,
      // this.displayRank,
      // this.bBIsCourierable,
      // this.gSTPercentage,
      // this.offerCategory,
      // this.strength,
      // this.isCustomizable,
      // this.highlightedTerms,
      // this.offerPrice,
      // this.discountPercent
      });

  Product.fromJson(Map<String, dynamic> json) {
    // salts = json['Salts'] != null ? Salts.fromJson(json['Salts']) : null;
    // interactiveModule = json['InteractiveModule'];
    // productName = json['ProductName'];
    // mfgGroup = json['MfgGroup'];
    // bBExpiryDate = json['BBExpiryDate'];
    // isPurchased = json['IsPurchased'];
    // documentId = json['DocumentId'];
    productId = json['ProductId'];
    // groupSize = json['GroupSize'];
    // refProductId = json['RefProductId'];
    // displayFactor = json['DisplayFactor'];
    // bBIsFlashSaleOn = json['BBIsFlashSaleOn'];
    // dosageFormDisplaySeq = json['DosageFormDisplaySeq'];
    // bBFlashSaleSoldPercent = json['BBFlashSaleSoldPercent'];
    // productShortDescription = json['ProductShortDescription'];
    // applyPincodeWiseDiscount = json['ApplyPincodeWiseDiscount'];
    // avgRating = json['AvgRating'];
    // offerTitle = json['OfferTitle'];
    // encodeProdId = json['EncodeProdId'];
    // dosageAlert = json['DosageAlert'];
    // bBMinQty = json['BBMinQty'];
    // recentOrderCount = json['RecentOrderCount'];
    // isFeatured = json['IsFeatured'];
    // brand = json['Brand'];
    // brandImage = json['BrandImage'];
    // maxSKUOrderCount = json['MaxSKUOrderCount'];
    // active = json['Active'];
    // dealPrice = json['DealPrice'];
    // productAliasName = json['ProductAliasName'];
    // dealMaxQty = json['DealMaxQty'];
    // numCustomer = json['NumCustomer'];
    // dosageForm = json['DosageForm'];
    // schemeFreeBaseQtyOfferText = json['SchemeFreeBaseQtyOfferText'];
    // lastMRP = json['LastMRP'];
    // pKLotId = json['PKLotId'];
    // primaryDisease = json['PrimaryDisease'];
    // keywords = json['Keywords'];
    // bBDiscountPercent = json['BBDiscountPercent'];
    // offerImage = json['OfferImage'];
    // bBHighDisc = json['BBHighDisc'];
    productImage = json['ProductImage'];
    // bBMRP = json['BBMRP'];
    // isNew = json['IsNew'];
    // bBIsOutOfStock = json['BBIsOutOfStock'];
    // interactiveSubModule = json['InteractiveSubModule'];
    // bBOfferPrice = json['BBOfferPrice'];
    // pTRDiscType = json['PTRDiscType'];
    // pTR = json['PTR'];
    // hasOffer = json['HasOffer'];
    // dosageRestriction = json['DosageRestriction'];
    displayName = json['DisplayName'];
    // prescriptionOTC = json['PrescriptionOTC'];
    // offerCategoryId = json['OfferCategoryId'];
    // orderCount = json['OrderCount'];
    // custOfferPrice = json['CustOfferPrice'];
    // isRedeemable = json['IsRedeemable'];
    // recentProductCount = json['RecentProductCount'];
    // pTRDiscPercent = json['PTRDiscPercent'];
    // numRating = json['NumRating'];
    // isGiftableProduct = json['IsGiftableProduct'];
    // productStatus = json['ProductStatus'];
    // customScoreManipulator = json['CustomScoreManipulator'];
    // custDiscPercent = json['CustDiscPercent'];
    // routeId = json['RouteId'];
    // deliveryDelayedDay = json['DeliveryDelayedDay'];
    // schemeFreeBaseQty = json['SchemeFreeBaseQty'];
    // recentCustCount = json['RecentCustCount'];
    // sKUOrderCount = json['SKUOrderCount'];
    // unitPrice = json['UnitPrice'];
    // pTRDicPct = json['PTRDicPct'];
    // isFoodProduct = json['IsFoodProduct'];
    // displayRank = json['DisplayRank'];
    // bBIsCourierable = json['BBIsCourierable'];
    // gSTPercentage = json['GSTPercentage'];
    // offerCategory = json['OfferCategory'];
    // strength = json['Strength'];
    // isCustomizable = json['IsCustomizable'];
    // highlightedTerms = json['HighlightedTerms'];
    offerPrice = ValueHandler().numify(json['OfferPrice'].toString());
    // discountPercent = json['DiscountPercent'];
  }
   Map<String, dynamic> toJson() {
     return {
       'ProductId': productId,
       'DisplayName': displayName,
       'OfferPrice': offerPrice,
     };
   }
}

class Salts {
  String? nameSearch;
  String? saltStrengthRaw;
  String? saltStrength;
  String? id;
  String? code;
  String? name;

  Salts(
      {this.nameSearch,
      this.saltStrengthRaw,
      this.saltStrength,
      this.id,
      this.code,
      this.name});

  Salts.fromJson(Map<String, dynamic> json) {
    nameSearch = json['NameSearch'];
    saltStrengthRaw = json['SaltStrengthRaw'];
    saltStrength = json['SaltStrength'];
    id = json['Id'];
    code = json['Code'];
    name = json['Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['NameSearch'] = this.nameSearch;
    data['SaltStrengthRaw'] = this.saltStrengthRaw;
    data['SaltStrength'] = this.saltStrength;
    data['Id'] = this.id;
    data['Code'] = this.code;
    data['Name'] = this.name;
    return data;
  }
}
