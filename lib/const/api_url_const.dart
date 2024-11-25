class ApiUrlConst {
  static bool isLive = true;
  static String baseUrl =
      isLive ? "https://www.googleapis.com/" : "http://127.0.0.1:1998/";

  static String books = "${baseUrl}products";
  static String productsURL =
      "https://search.retailershakti.com/searchv2/?q=cal&wh=1&panindia=0&bbug=2&device=&m=0&include_discontinued=0&app_version=1.0.0&t=1732557997269000&format=2";

  static String reverseGeocode = "https://nominatim.openstreetmap.org/reverse";

  static String hostUrl = "https://www.stg-googleapis.com/";
}
