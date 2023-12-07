abstract class Connection {
  Connection._();

  static const base = 'beautyqueen.ly';
  static const baseURL = 'https://$base/';
  static const apiURL = '${baseURL}api/v1/';
  static const storageURL = '${baseURL}storage/';
  static const storageURLOfBrand = 'https://beautyqueen.twic.pics/brands';
  static const logoURL = '${baseURL}logo.png';
  static const googleLogin = '${baseURL}auth/google/redirect';
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
  static String urlOfBanner({required String image}) {
    return "${storageURL}banner/$image";
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


  static const String bundleId = '';
  static const String appstoreId = '';
  static const String mapKey = 'AIzaSyDDbeB2JCI9I77iwI6SdzeHpcq2bx0qeQE';
}