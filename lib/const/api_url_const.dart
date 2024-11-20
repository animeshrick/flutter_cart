class ApiUrlConst {
  static bool isLive = true;
  static String baseUrl = isLive
      ? "https://www.googleapis.com/"
      : "http://127.0.0.1:1998/";

  static String books = "${baseUrl}products";

  static String reverseGeocode = "https://nominatim.openstreetmap.org/reverse";

  static String hostUrl = "https://www.stg-googleapis.com/";
}
