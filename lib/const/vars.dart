import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:url_launcher/url_launcher.dart';

import '../View/brands/branddetail_screen.dart';
import '../View/categories/filter_screen2.dart';
import '../View/product_profile/products_screen.dart';
import '../View/search/search_screen.dart';
import '../controller/AlKasam_controller/alkasam_controller.dart';
import '../controller/auth_controller/auth_controler.dart';
import '../controller/product_controller/product_profile_controller_provider.dart';
import '../models/grid_item_data.dart';
import '../models/user_model.dart';
import 'app_images.dart';

abstract class UniVars {
  UniVars._(); // to disable creating an object of this data.

  static const product = 'product';

  static List<String> get values => [product];

  static openTheLink(
      {required String? isLink,
      required String? linkType,
      required String? urlLink,
      bool? makeSearchOpenOutOfApp,
      required String? linkId}) async {
    final AuthController _controllerLogin = Get.put(AuthController());
    UserModel user = _controllerLogin.userData.value;
    print('%%%%%%%%%:${user.id}');
    if (user.id == null) {
      _controllerLogin.alertOfLogin();
      return;
    }
    if (isLink == "1") {
      print("_controller.sliders[index].linkType:$linkType");
      print("_controller.sliders[index].linkType:$urlLink");

      if (linkType == LinkTypes.brand) {
        Get.to(BrandDetailScreen(
          brandId: int.parse(linkId ?? '0'),
        ));
      } else if (linkType == LinkTypes.product) {
        Get.to(ChangeNotifierProvider(
            create: (context) => ProductProfileControllerProvider(),
            child: ItemProfilePage(itemId: int.parse(linkId ?? '0'))));
      } else if (linkType == LinkTypes.category) {
        AlkasamController controller = Get.put(AlkasamController());
        controller.updateCurrentCategoryId(
            newId: int.parse(linkId ?? '0'), getChild: null);
        Get.to(FliterScreen2(
          categoryId: int.parse(linkId ?? '0'),
        ));
      } else if (linkType == LinkTypes.search) {
        String searchWord = linkId ?? '0';
        Get.to(() => SearchScreen(subKeyWord: searchWord));
      } else {
        if (makeSearchOpenOutOfApp == true) {
          log('urlLink:${urlLink}');
          log('isLink:${isLink}');
          Uri _url = Uri.parse('https://${urlLink}');
          await launchUrl(
            _url,
            mode: LaunchMode.externalApplication,
          );
        } else {
          try {
            print("_controller.sliders[index].linkType:${linkType}");
            print("_controller.sliders[index].linkType:${urlLink}");
            List linkData = urlLink.toString().split("/") ?? [];
            if (linkData[1] == LinkTypes.search) {
              String searchWord = linkData[2].replaceAll('%20', ' ');
              print('searchWord:$searchWord');
              Get.to(() => SearchScreen(subKeyWord: searchWord));
            } else {
              Uri _url = Uri.parse('https://${urlLink}');
              await launchUrl(
                _url,
                mode: LaunchMode.externalApplication,
              );
            }
          } catch (e, s) {
            // FirebaseCrashlytics.instance
            //     .recordError('Api Crash $e', s);
            Uri _url = Uri.parse('https://${urlLink}');
            await launchUrl(
              _url,
              mode: LaunchMode.externalApplication,
            );
          }
        }
      }
    }
  }
}

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
  static const flashImageUrl = 'https://beautyqueen.ly/storage/flash/';
  // static const flashImageUrl = 'https://dev.beautyqueen.ly/storage/flash';
  static String urlOfSlider({required String image}) {
    return "$storageURL/slides/$image";
  }

  static String urlOfFlash({required String image}) {
    return "$flashImageUrl/$image";
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

  static String urlOfMagazines({required String image}) {
    return "${storageURL}magazines/$image";
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
  static const color2 = 'الألوان';
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
  static const category = 'category';
  static const search = 'search';
  static const brandsPage = 'brandsPage';
  static const offers = 'offers';
  static const sales = 'sales';
  static const gifts = 'gifts';
  static const magazine = 'magazine';
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
  static const String mainPathToImages = 'assets/images';

  static const shipped = 'shipped';
  static const shippedImage = '$mainPathToImages/Shipped.png';
  static const shippedMessage =
      '.لقد تم تسليم طلبك بنجاح شكراً لاختيارك متجرنا وثقتك بنا، نتمني عودتك من جديد.';
  static const cancelled = 'cancelled';
  static const cancelledImage = '$mainPathToImages/Cancelled.png';
  // static const cancelledMessage = '$mainPathToImages/Cancelled.png';

  static const pending = 'pending';
  static const pendingImage = '$mainPathToImages/Pending.png';
  static const pendingMessage =
      'شكراً لاختيارك متجرنا … سيتم تأكيد طلبك خلال ساعات العمل والاهتمام بكل ملاحظاتك.';

  static const confirmed = 'confirmed';
  static const confirmedImage = '$mainPathToImages/Confirmed.png';
  static const confirmedMessage =
      'لقد تم تأكيد طلبك و مطابقته بالفاتورة وسيصلك خلال الوقت المحدد.';

  static const delayed = 'delayed';
  static const delayedImage = '$mainPathToImages/Delayed.png';
  static const delayedMessage =
      'لقد تم تأجيل موعد التوصيل. طلبك الآن لدى مندوب التوصيل سيتواصل معك في اقرب موعد.';

  static const readyToPickup = 'readyToPickup';
  static const shippingImage = '$mainPathToImages/Shipping.png';
  static const shippingMessage =
      'طلبك الآن مع مندوب التوصيل انتظري اتصاله عندما يكون قريباً من عنوانك';

  static const atShippingAgent = 'atShippingAgent';
  static const inCart = 'in_cart';
  static String? getImageState({required String? state}) {
    switch (state) {
      case shipped:
        return shippedImage;
      case cancelled:
        return cancelledImage;
      case pending:
        return pendingImage;
      case confirmed:
        return confirmedImage;
      case delayed:
        return delayedImage;
      case atShippingAgent:
        return shippingImage;
      case readyToPickup:
        return shippingImage;
      default:
        return null;
    }
  }

  static String? getMessageState({required String? state}) {
    switch (state) {
      case shipped:
        return shippedMessage;
      // case cancelled:
      //   return cancelledImage;
      case pending:
        return pendingMessage;
      case confirmed:
        return confirmedMessage;
      case delayed:
        return delayedMessage;
      case atShippingAgent:
        return shippingMessage;
      case readyToPickup:
        return shippingMessage;
      default:
        return null;
    }
  }
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
