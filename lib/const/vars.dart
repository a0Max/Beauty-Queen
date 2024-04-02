import 'package:easy_localization/easy_localization.dart';

import '../models/grid_item_data.dart';
import 'app_images.dart';

abstract class Connection {
  Connection._();

  static const base = 'beautyqueen.ly';
  static const baseURL = 'https://$base/';
  static const apiURL = '${baseURL}api/v1/';
  static const apiURL2 = '${baseURL}api/';
  static const storageURL = '${baseURL}storage/';
  static const storageURLOfBrand = 'https://beautyqueen.twic.pics/brands';
  static const logoURL = '${baseURL}logo.png';
  static const googleLogin = '${baseURL}auth/google/redirect';
  static const magazineUrl = 'https://beautyqueen.ly/magazines/';
  static const magazineVideoUrl = 'https://beautyqueen.ly/storage/magazines/';
  static String urlOfSlider({required String image}) {
    return "$storageURL/slides/$image";
  }

  static String urlOfCategories({required String image}) {
    return "${storageURL}categories/$image";
  }

  static String urlOfProducts({required String image}) {
    return "${storageURL}products/$image";
  }

  static String urlOfSpecial({required String image}) {
    return "${storageURL}special/$image";
  }

  static String urlOfOptions({required String image}) {
    return "${storageURL}options/$image";
  }

  static String urlOfBanner({required String image}) {
    return "${storageURL}banner/$image";
  }

  static String urlOfEvent({required String image}) {
    return "${storageURL}events/$image";
  }

  static String urlOfDiscover({required String image}) {
    return "${storageURL}discover/$image";
  }

  static String urlOfBrands({required String image}) {
    return "$storageURLOfBrand/$image";
  }

  static String urlOfBrands2({required String image}) {
    return "${storageURLOfBrand}brands/$image";
  }

  static String urlOfBrands3({required String image}) {
    return "${storageURL}Brands/$image";
  }

  static String urlOfStorage({required String image}) {
    return "$storageURL/$image";
  }

  static const String bundleId = '';
  static const String appstoreId = '';
  static const String mapKey = 'AIzaSyDDbeB2JCI9I77iwI6SdzeHpcq2bx0qeQE';

  static List<GridItemData> gridData = [
    GridItemData(
      imageAsset: AppImages.khandgranateImage, // Replace with your image
      label: tr("kPerfumes"),
      id: 44,
    ),
    GridItemData(
      imageAsset: AppImages.kpaintImage, // Replace with your image
      label: tr('kMakeup'),
      id: 43,
    ),
    // Add more data for additional grid items
    GridItemData(
      imageAsset: AppImages.kshampooImage, // Replace with your image
      label: tr('kHaircare'),
      id: 46,
    ),
    GridItemData(
      imageAsset: AppImages.kSkincare, // Replace with your image
      label: tr('kSkincare'),
      id: 45,
    ),
    GridItemData(
      imageAsset: AppImages.khandpumpImage, // Replace with your image
      label: tr('kBodyCareAndRelaxation'),
      id: 48,
    ),
    GridItemData(
      imageAsset: AppImages.kPersonalCare, // Replace with your image
      label: tr('kPersonalCare'),
      id: 47,
    ),

    GridItemData(
      imageAsset: AppImages.contactLenses, // Replace with your image
      label: tr('contactـlenses'),
      id: 50,
    ),
    GridItemData(
      imageAsset: AppImages.shavingAndHairRemoval, // Replace with your image
      label: tr('Shaving_and_hair_removal'),
      id: 49,
    ),

    GridItemData(
      imageAsset: AppImages.knailImage, // Replace with your image
      label: tr('kNails'),
      id: 52,
    ),
    GridItemData(
      imageAsset: AppImages.eyelashes, // Replace with your image
      label: tr('kLashes'),
      id: 51,
    ),
    GridItemData(
      imageAsset: AppImages.kBladeImage, // Replace with your image
      label: tr('kElectricalAppliances'),
      id: 53,
    ),
    GridItemData(
      imageAsset: AppImages.kfirstaidImage, // Replace with your image
      label: tr('kPharmacyOfBeauty'),
      id: 183,
    ),
  ];
}

abstract class TypeOfOptions {
  static const size = 'الحجم';
  static const color = 'اللون';
}

abstract class SortTypes {
  static const latest = 'latest';
  static const selling = 'selling';
  static const priceAsc = 'priceAsc';
  static const priceDesc = 'priceDesc';
  static Map listOfTTypesOfSort = {
    latest: tr(latest),
    selling: tr(selling),
    priceAsc: tr(priceAsc),
    priceDesc: tr(priceDesc)
  };
}

abstract class AccountTypes {
  static const queena = 'queena1';
}

abstract class LinkTypes {
  static const brand = 'brand';
  static const brands = 'brands';
  static const product = 'product';
}

abstract class SocialMedia {
  static const email = 'magazine@beautyqueen.ly';
  static const phone = '0919900224';
}

abstract class LocationMapLatLng {
  static const lat = 32.85027077679638;
  static const lng = 13.203011592591462;
}

abstract class OrderState {
  static const shipped = 'shipped';
  static const cancelled = 'cancelled';
  static const pending = 'pending';
  static const confirmed = 'confirmed';
  static const delayed = 'delayed';
  static const readyToPickup = 'readyToPickup';
  static const atShippingAgent = 'atShippingAgent';
  static const inCart = 'in_cart';
}

abstract class WalletState {
  static const add = 'add';
  static const refund = 'refund';
  static const deduction = 'deduction';
}

abstract class ReactionCode {
  static const like = '1';
  static const disLike = '0';
}

abstract class GiftCode {
  static const gift500 = 'GIFT500';
  static const gift100 = 'GIFT100';
  static const gift250 = 'GIFT250';
}
